local Ans = select(2, ...);
local AuctionBuy = {};

local Query = AnsCore.API.Query;
local Sources = AnsCore.API.Sources;
local Utils = AnsCore.API.Utils;
local TreeView = AnsCore.API.UI.TreeView;
local Recycler = AnsCore.API.Recycler;

AuctionBuy.__index = AuctionBuy;
AuctionBuy.isInited = false;
AuctionBuy.sortHow = Query.SORT_METHODS.PRICE;
AuctionBuy.sortAsc = true;
AuctionBuy.query = Query:New("");
AuctionBuy.purchaseQuery = Query:New("");
AuctionBuy.waitingForResult = false;
AuctionBuy.waitingQuery = -1;
AuctionBuy.scanning = false;
AuctionBuy.exact = true;
AuctionBuy.purchaseScan = false;
AuctionBuy.previouslyScanning = false;
AuctionBuy.wasPreviouslyWaiting = false;
AuctionBuy.buyIndex = -1;

Ans.AuctionBuy = AuctionBuy;

local activeFilters = {};
local selectedFilters = {};

local itemQueue = {};

local filterTreeViewItems = {};
local auctionTreeItems = {};

local queueIndex = 1;
local scanResults = {};
local querySearches = {};
local purchaseScanResults = {};

local selectedBlock = nil;

local clickCount = 0;
local clickTime = time();

--- static popup for purchase confirm
StaticPopupDialogs["ANS_BUY_AUCTION_CONFIRM"] = {
    text = "Buy %s for %s PPU?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function() AuctionBuy:ConfirmPurchase() end,
    OnCancel = function() AuctionBuy:Resume() end,
    whileDead = false,
    hideOnEscape = true,
    preferredIndex = 3
};

function AuctionBuy:Init()
    local d = self;
    if (self.isInited) then
        return;
    end

    self.isInited = true;

    local frame = CreateFrame("FRAME", "AnsAuctionBuyMainPanel", AuctionFrame, "AnsAuctionBuyTemplate");
    self.frame = frame;

    AnsCore:AddAHTab("AnsBuy", 
        function()
            AuctionBuy:Show();
        end,
        function()
            AuctionBuy:Close();
        end
    );

    self.filterTreeView = TreeView:New(frame, {
        rowHeight = 20,
        childIndent = 16,
        template = "AnsFilterRowTemplate"
    }, function(item) d:ToggleFilter(item.filter) end);

    self.auctionsTreeView = TreeView:New(_G[frame:GetName().."Auctions"], {
        rowHeight = 20,
        childIndent = 16,
        template = "AnsAuctionTreeRowTemplate"
    }, 
        function(item)
            d:AuctionRowClick(item);
        end,
        nil, nil, 
        function(row, item)
            d:RenderAuctionRow(row, item);
        end
    );

    self.searchInput = _G[frame:GetName().."SearchBarSearch"];
    self.statusText = _G[frame:GetName().."BottomBarStatus"];
    self.startButton = _G[frame:GetName().."BottomBarStart"];
    self.stopButton = _G[frame:GetName().."BottomBarStop"];
    self.exactMatch = _G[frame:GetName().."SearchBarExactMatch"];

    frame:Hide();
end

function AuctionBuy:StartScan()
    local search = self.searchInput:GetText();

    wipe(itemQueue);
    wipe(scanResults);
    wipe(purchaseScanResults);
    wipe(auctionTreeItems);
    wipe(querySearches);

    self.query:Reset();
    self.purchaseQuery:Reset();

    self.auctionsTreeView:ReleaseView();

    queueIndex = 1;

    -- set default sort based
    -- on unitprice
    -- this snippet is modified
    -- based on actual blizzard 
    -- auctionhouseui code

    SortAuctionClearSort("list");
    for i, r in pairs(AuctionSort["list_unitprice"]) do
        SortAuctionSetSort("list", r.column, r.reverse);
    end

    self:RefreshAuctions();

    if (search and string.gsub(search, " ", ""):len() > 0) then
        tinsert(itemQueue, search);
        self.exact = self.exactMatch:GetChecked();
    else
        self.exact = true;

        if (#activeFilters > 0) then
            self:BuildItemQueue(activeFilters);
        end
    end

    if (#itemQueue > 0) then
        self.startButton:Disable();
        self.stopButton:Enable();

        local item = tremove(itemQueue, 1);
        self.query:Set(item);
        self.scanning = true;
        self.purchaseScan = false;
        self.waitingForResult = false;

        self.statusText:SetText("Scan Started...");
    end
end

function AuctionBuy:BuildItemQueue(children)
    for i,v in ipairs(children) do
        for i2, tsmId in ipairs(v.ids) do
            local _, id = strsplit(":", tsmId);

            if (_ == "p") then
                local name, icon, type = C_PetJournal.GetPetInfoBySpeciesID(tonumber(id));
                if (name) then
                    tinsert(itemQueue, name);
                end
            else 
                local name = GetItemInfo(tonumber(id));
                if (name) then
                    tinsert(itemQueue, name);
                end
            end
        end

        if (#v.subfilters > 0) then
            self:BuildItemQueue(v.subfilters);
        end
    end
end

function AuctionBuy:StopScan()
    self.scanning = false;
    self.purchaseScan =  false;
    self.previouslyScanning = false;
    self.waitingForResult = false;
    self.wasPreviouslyWaiting = false;
    self.startButton:Enable();
    self.stopButton:Disable();
end

function AuctionBuy:AuctionRowClick(item)
    if (time() - clickTime > 1) then
        clickCount = 0;
    end

    clickCount = clickCount + 1;

    if (item) then
        selectedBlock = item.block;
    else
        selectedBlock = nil;
    end

    if (clickCount == 2 and selectedBlock) then
        self.previouslyScanning = self.scanning;
        self.wasPreviouslyWaiting = self.waitingForResult;
        self:ScanForPurchase();

        clickCount = 0;
    end

    self:RefreshAuctions();

    clickTime = time();
end

function AuctionBuy.ShowTip(row)
    local item = row.item;

    if (item and item.block) then
        local auction = item.block;

        if (auction.link ~= nil) then
            Utils:ShowTooltip(row, auction.link, auction.count);
        end
    end
end

function AuctionBuy:RenderAuctionRow(row, item)
    row:SetScript("OnEnter", AuctionBuy.ShowTip);
    row:SetScript("OnLeave", Utils.HideTooltip);
    if (item.block) then
        local auction = item.block;
        local name = _G[row:GetName().."Text"];
        local icon = _G[row:GetName().."ItemIcon"];
        local level = _G[row:GetName().."Level"];
        local posts = _G[row:GetName().."Posts"];
        local stack = _G[row:GetName().."Stack"];
        local seller = _G[row:GetName().."Seller"];
        local ppu = _G[row:GetName().."PPU"];
        local percent = _G[row:GetName().."Percent"];

        if (auction.texture) then
            icon:SetTexture(auction.texture);
            icon:Show();
        else
            icon:Hide();
        end

        level:SetText(auction.iLevel);
        
        local realCount = auction.stack;

        posts:SetText(realCount);
        stack:SetText(auction.count);
        seller:SetText(auction.owner or "?");
        ppu:SetText(Utils:PriceToString(auction.ppu));
        percent:SetText(auction.percent.."%");

        if (auction.percent >= 100) then
            percent:SetTextColor(1,0,0);
        elseif (auction.percent >= 75) then
            percent:SetTextColor(1,1,1);
        elseif (auction.percent >= 50) then
            percent:SetTextColor(0,1,0);
        else
            percent:SetTextColor(0,0.5,1);
        end

        local color = ITEM_QUALITY_COLORS[auction.quality];
        name:SetText(color.hex..auction.name);
    end
end

function AuctionBuy:OnUpdate()
    if (self.frame and self.frame:IsShown() and (self.scanning or self.purchaseScan)) then
        if (not self.waitingForResult) then
            if (self.purchaseScan and not self.wasPreviouslyWaiting) then
                if (self.purchaseQuery:IsReady()) then
                    self.statusText:SetText("Finding item...");
                    self.purchaseQuery:Search(0, self.exact);
                    self.waitingForResult = true;
                end
            else
                if (self.query:IsReady()) then
                    self.query:Search(0, self.exact);
                    self.waitingForResult = true;
                end
            end
        end
    end
end

function AuctionBuy:OnAuctionUpdate()
    -- only accept if shown, otherwise ignore
    if (self.frame and self.frame:IsShown() and (self.scanning or self.purchaseScan)) then
        if (self.waitingForResult) then
            local index = self.query.index;
            local last = self.query.index;

            if (not self.purchaseScan or self.wasPreviouslyWaiting) then
                if (index == 0) then
                    -- create a new auctions table
                    -- this way the previous auction table is preserved
                    -- in the scanResults
                    self.query.auctions = {};
                end

                self.query:CaptureLight();
            elseif (not self.wasPreviouslyWaiting and self.purchaseScan) then
                -- reset purchase page
                -- as capture light does not automatically clear
                -- the previous auction list
                wipe(self.purchaseQuery.auctions);
                self.purchaseQuery:CaptureLight(true);
            end

            if (not scanResults[queueIndex]) then
                scanResults[queueIndex] = {};
                tinsert(querySearches, self.query.search);
            end

            if (not self.purchaseScan or self.wasPreviouslyWaiting) then
                scanResults[queueIndex] = self.query:Items(self.sortHow, self.sortAsc, scanResults[queueIndex], true);
                -- update tree view
                self:RefreshAuctions();
            elseif (not self.wasPreviouslyWaiting and self.purchaseScan) then
                purchaseScanResults = self.purchaseQuery:Items(self.sortHow, self.sortAsc, purchaseScanResults, true);
            end

            if (not self.purchaseScan or self.wasPreviouslyWaiting) then
                if (index < 3 and not self.query:IsLastPage()) then
                    self.query:Next();    
                    index = self.query.index;

                    -- get the last page number
                    self.query:LastPage();
                    last = self.query.index;
                    -- restore to where we were
                    self.query.index = index;
                    self.statusText:SetText(self.query.search.. " page: "..(index + 1).." of "..math.min(last + 1, 4));
                else
                    if (#itemQueue > 0) then
                        local item = tremove(itemQueue, 1);
                        self.query:Set(item);
                        index = self.query.index;
                        last = self.query.index;
                        queueIndex = queueIndex + 1;
                        self.statusText:SetText(self.query.search.. " page: "..(index + 1).." of "..math.min(last + 1, 4));
                    else
                        self:StopScan();
                        self.statusText:SetText("Scan Complete");
                    end
                end
            elseif (not self.wasPreviouslyWaiting and self.purchaseScan) then
                self.purchaseScan = false;
                self.scanning = false;
                self:TryAndFind();           
            end

            self.waitingForResult = false;
            self.wasPreviouslyWaiting = false;
        end
    end
end

function AuctionBuy:ScanForPurchase()
    if (selectedBlock) then
        if (selectedBlock.stack > 0) then
            local idx = self:FindScanForBlock(selectedBlock);
            if (idx and querySearches[idx]) then
                self.purchaseQuery:Set(querySearches[idx]);
                self.purchaseQuery.index = selectedBlock.page;
                self.purchaseScan = true;
            else
                self.previouslyScanning = false;
            end
        else
            self.previouslyScanning = false;
            self:RemoveEmptyAuction(selectedBlock);
            selectedBlock = nil;
            self:RefreshAuctions();
        end
    else
        self.previouslyScanning = false;
    end
end

function AuctionBuy:ConfirmPurchase()
    if (self.buyIndex > -1 and selectedBlock) then
        
        if (not self:CheckAndPurchase(self.buyIndex, selectedBlock)) then
            self.statusText:SetText("Auction no longer exists");
        end

        selectedBlock.stack = selectedBlock.stack - 1;
        self:RemoveEmptyAuction(selectedBlock);

        self.buyIndex = -1;

        if (selectedBlock.stack <= 0) then
            selectedBlock = nil;
        end
    end
    self:RefreshAuctions();
    self:Resume();
end

function AuctionBuy:Resume()
    if (self.previouslyScanning) then
        self.scanning = true;
        self.waitingForResult = false;
        self.previouslyScanning = false;
        return true;
    end

    return false;
end

function AuctionBuy:TryAndFind()
    if (selectedBlock) then
        local success = false;
        if (#purchaseScanResults > 0) then
            for i,v in ipairs(purchaseScanResults) do
                if (self:Check(i, selectedBlock)) then
                    self.buyIndex = i;
                    success = true;
                    local color = ITEM_QUALITY_COLORS[selectedBlock.quality];
                    local name = color.hex..selectedBlock.name.."|cFFFFFFFF x "..selectedBlock.count;
                    local ppu = Utils:PriceToString(selectedBlock.ppu);
                    StaticPopup_Show("ANS_BUY_AUCTION_CONFIRM", name, ppu.."|cFFFFFFFF");
                    break;
                end
            end
        -- auctions no longer exists
        -- remove it
            if (not success) then
                selectedBlock.stack = 0;
                self:RemoveEmptyAuction(selectedBlock);
                self.statusText:SetText("Auction no longer exists");
                selectedBlock = nil;
            end
        else
            -- auction no longer exists on that page
            -- remove
            self.statusText:SetText("Auction no longer exists");
            selectedBlock.stack = 0;
            self:RemoveEmptyAuction(selectedBlock);
            selectedBlock = nil;
        end

        if (not success) then
            self.buyIndex = -1;
            self:RefreshAuctions();
            self:Resume();
        end
    end
end

function AuctionBuy:Check(index, auction)
    if (auction and auction.stack > 0) then
        local link = GetAuctionItemLink("list", index);
        if (link and auction.link == link) then
            local _,_, count,_,_,_,_,_,_,buyoutPrice, _,_, _, _,
            _, _, _, hasAllInfo = GetAuctionItemInfo("list", index);
            if (hasAllInfo and count == auction.count and buyoutPrice and
                buyoutPrice <= auction.buyoutPrice and GetMoney() >= buyoutPrice) then
                return true;
            end
        end
    end

    return false;
end

function AuctionBuy:CheckAndPurchase(index, auction)
    if (auction and auction.stack > 0) then
        local link = GetAuctionItemLink("list", index);
        if (link and auction.link == link) then
            local _,_, count,_,_,_,_,_,_,buyoutPrice, _,_, _, _,
            _, _, _, hasAllInfo = GetAuctionItemInfo("list", index);
            if (hasAllInfo and count == auction.count and buyoutPrice and
                buyoutPrice <= auction.buyoutPrice and GetMoney() >= buyoutPrice) then
                PlaceAuctionBid("list", index, buyoutPrice);
                return true;
            end
        end
    end

    return false;
end

function AuctionBuy:FindScanForBlock(block)
    for k,v in ipairs(scanResults) do
        for i2, v2 in ipairs(v) do

            -- if we were doing an exact search
            -- then we can skip results for items
            -- whose names do not match
            if (self.exact) then
                if (v2.name ~= block.name) then
                    break;
                end
            end

            if (v2 == block) then
                return k;
            end
        end
    end

    return nil;
end

function AuctionBuy:RemoveEmptyAuction(block)
    for k, v in ipairs(scanResults) do
        local i;
        for i = 1, #v do
            local remove = true;
            local v2 = v[i];

            if (v2) then
                if (self.exact) then
                    if (v2.name ~= block.name) then
                        break;
                    end
                end

                if (v2.stack > 0) then
                    remove = false;
                end
            end

            if (remove) then
                tremove(v, i);
                i = i - 1;
            end
        end
    end
end

function AuctionBuy:OnAuctionHouseClosed()
    self:Close();
end

function AuctionBuy:Close()
    -- only perform is shown
    if (self.frame:IsShown()) then
        self.frame:Hide();
        self:StopScan();

        self.query:Reset();
        self.purchaseQuery:Reset();

        wipe(itemQueue);
        wipe(scanResults);
        wipe(purchaseScanResults);
        wipe(auctionTreeItems);
        wipe(querySearches);
        wipe(filterTreeViewItems);
        queueIndex = 1;

        self.filterTreeView:ReleaseView();
        self.auctionsTreeView:ReleaseView();
    end
end

function AuctionBuy:Show()
    self.frame:Show();

    AuctionFrameMoneyFrame:Show();
    AuctionFrameAuctions:Hide();
    AuctionFrameBrowse:Hide();
    AuctionFrameBid:Hide();

    AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopLeft");
    AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotLeft");
    AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
    AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
    AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotRight");
    AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Bot");

    self:BuildTreeViewFilters();
    self.filterTreeView.items = filterTreeViewItems;
    self.filterTreeView:Refresh(); 
    self.auctionsTreeView.items = auctionTreeItems;
    self.auctionsTreeView:Refresh();

    self.stopButton:Disable();
    self.startButton:Enable();
end

function AuctionBuy:ToggleFilter(f)
    local path = f:GetPath();

    if (selectedFilters[path]) then
        selectedFilters[path] = false;
        self:RemoveFilter(f);
    else
        selectedFilters[path] = true;
        tinsert(activeFilters, f);
    end
end

function AuctionBuy:RemoveFilter(f)
    for i,v in ipairs(activeFilters) do
        if (v == f) then
            tremove(activeFilters, i);
            return;
        end
    end
end

function AuctionBuy:RefreshAuctions()
    self:BuildTreeViewAuctions();
    self.auctionsTreeView.items = auctionTreeItems;
    self.auctionsTreeView:Refresh();
end

--- builds treeivew for auction list

function AuctionBuy:BuildTreeViewAuctions()
    local totalScans = #scanResults;
    local selected = nil;

    if (selectedBlock) then
        selected = selectedBlock;
    end

    if (totalScans < #auctionTreeItems) then
        while (#auctionTreeItems > totalScans) do
            tremove(auctionTreeItems);
        end
    end

    for k,v in ipairs(scanResults) do
        local pf = auctionTreeItems[k];

        if (pf) then
            local i;
            if (#v - 1 < #pf.children) then
                while (#pf.children > #v - 1) do
                    tremove(pf.children);
                end
            end

            local v1 = v[1];
            if (v1) then
                pf.name = v1.name;
                pf.block = v1;
                pf.selected = v1 == selected;

                local c = 1;
                for i = 2, #v do
                    local v2 = v[i];
                    local pf2 = pf.children[c];
                    c = c + 1;

                    if (pf2) then
                        pf2.name = v2.name;
                        pf2.block = v2;
                        pf2.selected = v2 == selected;
                        pf2.expanded = false;
                        pf2.children = {};

                    else
                        local t2 = {
                            name = v2.name,
                            block = v2,
                            expanded = false,
                            selected = v2 == selected,
                            children = {}
                        };

                        tinsert(pf.children, t2);
                    end
                end
            end
        else
            local i;
            local v1 = v[1];
            if (v1) then
                local t = {
                    name = v1.name,
                    block = v1,
                    expanded = false,
                    selected = v1 == selected,
                    children = {}
                };

                for i = 2, #v do
                    local v2 = v[i];

                    local t2 = {
                        name = v2.name,
                        block = v2,
                        expanded = false,
                        selected = v2 == selected,
                        children = {}
                    };

                    tinsert(t.children, t2);
                end

                tinsert(auctionTreeItems, t);
            end
        end
    end
end

--- builds treeview item list from known filters
function AuctionBuy:BuildTreeViewFilters()
    local filters = AnsCore.API.Filters;

    if (#filters < #filterTreeViewItems) then
        while (#filterTreeViewItems > #filters) do
            tremove(filterTreeViewItems);
        end
    end

    self:UpdateSubTreeFilters(filters, filterTreeViewItems);
end

function AuctionBuy:UpdateSubTreeFilters(children, parent)
    local c = 1;
    for i, v in ipairs(children) do
        local pf = parent[c];
        if (v:HasIds()) then
            c = c + 1;

            if (pf) then
                pf.selected = selectedFilters[v:GetPath()] or false;

                if (pf.name ~= v.name) then
                    pf.expanded = false;
                    pf.name = v.name;
                    pf.filter = v;
                    pf.children = {};

                    if(#v.subfilters > 0) then
                        self:BuildSubTreeFilters(v.subfilters, pf.children);
                    end
                else
                    if(#v.subfilters > 0) then
                        if (#v.subfilters < #pf.children) then
                            while (#pf.children > #v.subfilters) do
                                tremove(pf.children);
                            end
                        end

                        self:UpdateSubTreeFilters(v.subfilters, pf.children);
                    else
                        pf.children = {};
                    end
                end
            else
                local t = {
                    selected = selectedFilters[v:GetPath()] or false,
                    name = v.name,
                    expanded = false,
                    filter = v,
                    children = {}
                };

                if (#v.subfilters > 0) then
                    self:BuildSubTreeFilters(v.subfilters, t.children);
                end
        
                tinsert(parent, t);
            end
        elseif (pf and pf.name == v.name) then
            tremove(parent, c);
            c = c - 1;
        end
    end
end

function AuctionBuy:BuildSubTreeFilters(children, parent)
    for i,v in ipairs(children) do
        if (v:HasIds()) then
            local t = {
                selected = selectedFilters[v:GetPath()] or false,
                name = v.name,
                expanded = false,
                filter = v,
                children = {}
            };

            if (#v.subfilters > 0) then
                self:BuildSubTreeFilters(v.subfilters, t.children);
            end

            tinsert(parent, t);
        end
    end
end