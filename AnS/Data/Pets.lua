local Ans = select(2, ...);
local Pets = {};

Pets.children = {
    {
        name = "Level 1",
        ids = "p:39:1:2,p:39:1:3,p:40:1:2,p:40:1:3,p:41:1:2,p:41:1:3,p:42:1:2,p:42:1:3,p:43:1:2,p:43:1:3,p:44:1:2,p:44:1:3,p:45:1:2,p:45:1:3,p:46:1:2,p:46:1:3,p:47:1:2,p:47:1:3,p:49:1:3,p:50:1:2,p:50:1:3,p:51:1:2,p:51:1:3,p:52:1:2,p:52:1:3,p:55:1:2,p:55:1:3,p:56:1:3,p:57:1:3,p:58:1:3,p:59:1:3,p:64:1:2,p:64:1:3,p:65:1:2,p:65:1:3,p:67:1:2,p:67:1:3,p:68:1:2,p:68:1:3,p:70:1:2,p:70:1:3,p:72:1:2,p:72:1:3,p:74:1:2,p:74:1:3,p:75:1:2,p:75:1:3,p:77:1:2,p:77:1:3,p:78:1:2,p:78:1:3,p:85:1:2,p:85:1:3,p:86:1:2,p:86:1:3,p:87:1:3,p:89:1:2,p:89:1:3,p:90:1:2,p:90:1:3,p:95:1:2,p:95:1:3,p:114:1:3,p:115:1:2,p:115:1:3,p:116:1:2,p:116:1:3,p:117:1:2,p:117:1:3,p:118:1:2,p:118:1:3,p:119:1:2,p:119:1:3,p:120:1:2,p:120:1:3,p:122:1:2,p:122:1:3,p:125:1:2,p:125:1:3,p:126:1:2,p:126:1:3,p:127:1:2,p:127:1:3,p:128:1:2,p:128:1:3,p:130:1:3,p:132:1:3,p:136:1:2,p:136:1:3,p:137:1:2,p:137:1:3,p:138:1:2,p:138:1:3,p:139:1:2,p:139:1:3,p:140:1:2,p:140:1:3,p:141:1:2,p:141:1:3,p:142:1:2,p:142:1:3,p:143:1:2,p:143:1:3,p:144:1:2,p:144:1:3,p:145:1:2,p:145:1:3,p:146:1:3,p:153:1:2,p:153:1:3,p:156:1:3,p:157:1:2,p:157:1:3,p:158:1:2,p:158:1:3,p:159:1:2,p:159:1:3,p:162:1:3,p:163:1:3,p:164:1:3,p:165:1:3,p:166:1:2,p:166:1:3,p:167:1:3,p:168:1:3,p:169:1:3,p:172:1:3,p:173:1:3,p:174:1:3,p:175:1:3,p:183:1:3,p:186:1:3,p:190:1:2,p:190:1:3,p:191:1:2,p:191:1:3,p:193:1:3,p:194:1:2,p:194:1:3,p:195:1:2,p:195:1:3,p:196:1:2,p:196:1:3,p:197:1:2,p:197:1:3,p:198:1:3,p:200:1:2,p:200:1:3,p:204:1:2,p:204:1:3,p:205:1:2,p:205:1:3,p:206:1:2,p:206:1:3,p:207:1:2,p:207:1:3,p:209:1:2,p:209:1:3,p:210:1:2,p:210:1:3,p:211:1:3,p:212:1:2,p:212:1:3,p:213:1:2,p:213:1:3,p:215:1:2,p:215:1:3,p:218:1:2,p:218:1:3,p:224:1:2,p:224:1:3,p:229:1:3,p:232:1:2,p:232:1:3,p:233:1:2,p:233:1:3,p:234:1:3,p:235:1:2,p:235:1:3,p:236:1:2,p:236:1:3,p:237:1:2,p:237:1:3,p:238:1:2,p:238:1:3,p:239:1:3,p:241:1:3,p:242:1:3,p:251:1:2,p:251:1:3,p:253:1:3,p:254:1:2,p:254:1:3,p:261:1:2,p:261:1:3,p:262:1:2,p:262:1:3,p:264:1:3,p:266:1:3,p:267:1:2,p:267:1:3,p:271:1:2,p:271:1:3,p:277:1:3,p:278:1:3,p:279:1:3,p:285:1:3,p:286:1:3,p:289:1:2,p:289:1:3,p:292:1:2,p:292:1:3,p:293:1:3,p:302:1:3,p:303:1:3,p:306:1:2,p:306:1:3,p:308:1:2,p:308:1:3,p:309:1:3,p:310:1:3,p:311:1:3,p:317:1:3,p:318:1:3,p:319:1:2,p:319:1:3,p:328:1:3,p:330:1:3,p:333:1:3,p:335:1:3,p:337:1:3,p:338:1:3,p:339:1:3,p:340:1:2,p:340:1:3,p:341:1:2,p:341:1:3,p:342:1:2,p:342:1:3,p:343:1:3,p:348:1:3,p:381:1:3,p:382:1:3,p:629:1:2,p:629:1:3,p:630:1:2,p:630:1:3,p:650:1:3,p:652:1:2,p:652:1:3,p:665:1:3,p:792:1:2,p:792:1:3,p:834:1:3,p:836:1:3,p:844:1:2,p:844:1:3,p:845:1:2,p:845:1:3,p:846:1:0,p:846:1:1,p:846:1:2,p:846:1:3,p:847:1:2,p:847:1:3,p:848:1:3,p:868:1:3,p:1039:1:2,p:1039:1:3,p:1040:1:2,p:1040:1:3,p:1061:1:2,p:1061:1:3,p:1063:1:3,p:1124:1:3,p:1125:1:3,p:1126:1:3,p:1143:1:3,p:1144:1:3,p:1146:1:3,p:1147:1:3,p:1149:1:3,p:1150:1:3,p:1151:1:3,p:1152:1:3,p:1153:1:3,p:1154:1:3,p:1155:1:3,p:1156:1:3,p:1174:1:3,p:1177:1:3,p:1178:1:3,p:1180:1:3,p:1183:1:3,p:1185:1:3,p:1196:1:3,p:1197:1:3,p:1198:1:3,p:1200:1:3,p:1201:1:3,p:1202:1:3,p:1204:1:3,p:1205:1:3,p:1206:1:3,p:1207:1:3,p:1208:1:3,p:1209:1:3,p:1211:1:3,p:1212:1:3,p:1213:1:3,p:1226:1:3,p:1227:1:3,p:1228:1:3,p:1229:1:3,p:1230:1:3,p:1231:1:3,p:1232:1:3,p:1233:1:3,p:1234:1:3,p:1235:1:3,p:1237:1:3,p:1243:1:3,p:1244:1:3,p:1245:1:3,p:1256:1:3,p:1276:1:3,p:1320:1:2,p:1320:1:3,p:1321:1:2,p:1321:1:3,p:1322:1:3,p:1323:1:2,p:1323:1:3,p:1328:1:3,p:1329:1:3,p:1330:1:2,p:1330:1:3,p:1331:1:3,p:1332:1:3,p:1333:1:3,p:1334:1:3,p:1335:1:3,p:1336:1:3,p:1337:1:3,p:1338:1:3,p:1343:1:3,p:1344:1:3,p:1345:1:2,p:1345:1:3,p:1346:1:3,p:1348:1:3,p:1349:1:2,p:1349:1:3,p:1351:1:2,p:1351:1:3,p:1385:1:0,p:1385:1:1,p:1385:1:2,p:1385:1:3,p:1387:1:3,p:1394:1:3,p:1395:1:3,p:1396:1:3,p:1403:1:3,p:1412:1:3,p:1416:1:2,p:1416:1:3,p:1426:1:1,p:1426:1:2,p:1426:1:3,p:1428:1:3,p:1429:1:3,p:1430:1:3,p:1432:1:3,p:1434:1:3,p:1442:1:3,p:1446:1:2,p:1446:1:3,p:1448:1:3,p:1450:1:3,p:1453:1:3,p:1458:1:3,p:1467:1:3,p:1471:1:2,p:1471:1:3,p:1478:1:3,p:1495:1:3,p:1511:1:3,p:1515:1:2,p:1515:1:3,p:1516:1:3,p:1517:1:2,p:1517:1:3,p:1518:1:3,p:1521:1:3,p:1523:1:3,p:1524:1:3,p:1530:1:3,p:1531:1:3,p:1532:1:2,p:1532:1:3,p:1533:1:3,p:1536:1:3,p:1537:1:2,p:1537:1:3,p:1538:1:2,p:1538:1:3,p:1539:1:3,p:1540:1:2,p:1540:1:3,p:1541:1:3,p:1542:1:3,p:1544:1:3,p:1545:1:3,p:1563:1:3,p:1564:1:3,p:1565:1:3,p:1566:1:3,p:1567:1:3,p:1568:1:3,p:1569:1:3,p:1570:1:3,p:1571:1:3,p:1574:1:3,p:1575:1:2,p:1575:1:3,p:1576:1:3,p:1577:1:3,p:1588:1:3,p:1596:1:2,p:1596:1:3,p:1597:1:2,p:1597:1:3,p:1598:1:3,p:1600:1:3,p:1601:1:2,p:1601:1:3,p:1622:1:3,p:1623:1:3,p:1624:1:3,p:1625:1:3,p:1626:1:3,p:1627:1:3,p:1628:1:3,p:1629:1:3,p:1631:1:3,p:1632:1:3,p:1633:1:3,p:1634:1:3,p:1655:1:3,p:1656:1:3,p:1661:1:3,p:1662:1:3,p:1663:1:3,p:1664:1:3,p:1665:1:3,p:1672:1:3,p:1687:1:3,p:1688:1:3,p:1690:1:3,p:1692:1:3,p:1693:1:3,p:1699:1:3,p:1700:1:3,p:1701:1:3,p:1705:1:3,p:1706:1:3,p:1711:1:2,p:1711:1:3,p:1716:1:3,p:1717:1:3,p:1719:1:3,p:1720:1:3,p:1721:1:3,p:1723:1:3,p:1725:1:2,p:1725:1:3,p:1727:1:2,p:1727:1:3,p:1752:1:3,p:1753:1:3,p:1754:1:3,p:1755:1:3,p:1756:1:2,p:1756:1:3,p:1759:1:2,p:1759:1:3,p:1760:1:3,p:1764:1:3,p:1765:1:3,p:1766:1:3,p:1802:1:3,p:1803:1:3,p:1804:1:3,p:1805:1:3,p:1806:1:3,p:1808:1:3,p:1884:1:3,p:1885:1:3,p:1886:1:3,p:1887:1:3,p:1889:1:3,p:1903:1:3,p:1907:1:3,p:1911:1:2,p:1911:1:3,p:1920:1:3,p:1921:1:3,p:1922:1:3,p:1926:1:3,p:1927:1:3,p:1928:1:3,p:1929:1:3,p:1931:1:3,p:1934:1:3,p:1943:1:3,p:1949:1:3,p:1952:1:3,p:1953:1:3,p:1954:1:3,p:1955:1:3,p:1956:1:3,p:1957:1:3,p:1958:1:3,p:1959:1:3,p:1960:1:3,p:1961:1:3,p:1962:1:3,p:1963:1:3,p:1964:1:3,p:1965:1:3,p:1966:1:3,p:1967:1:3,p:1968:1:3,p:1984:1:3,p:1998:1:3,p:1999:1:2,p:1999:1:3,p:2000:1:1,p:2000:1:2,p:2000:1:3,p:2001:1:3,p:2002:1:3,p:2042:1:3,p:2050:1:3,p:2063:1:2,p:2063:1:3,p:2065:1:2,p:2065:1:3,p:2071:1:3,p:2072:1:3,p:2077:1:2,p:2077:1:3,p:2078:1:3,p:2079:1:3,p:2080:1:3,p:2081:1:3,p:2082:1:3,p:2083:1:3,p:2084:1:3,p:2085:1:3,p:2086:1:3,p:2087:1:3,p:2088:1:3,p:2089:1:3,p:2090:1:3,p:2091:1:3,p:2092:1:3,p:2117:1:3,p:2118:1:3,p:2119:1:3,p:2120:1:3,p:2121:1:3,p:2135:1:3,p:2157:1:3,p:2163:1:3,p:2186:1:3,p:2187:1:3,p:2188:1:2,p:2188:1:3,p:2189:1:2,p:2189:1:3,p:2190:1:2,p:2190:1:3,p:2192:1:2,p:2192:1:3,p:2196:1:2,p:2196:1:3,p:2197:1:2,p:2197:1:3,p:2198:1:2,p:2198:1:3,p:2199:1:3,p:2403:1:3,p:2404:1:2,p:2404:1:3,p:2405:1:2,p:2405:1:3,p:2406:1:2,p:2406:1:3,p:2407:1:2,p:2407:1:3,p:2408:1:2,p:2408:1:3,p:2409:1:2,p:2409:1:3,p:2410:1:2,p:2410:1:3,p:2411:1:2,p:2411:1:3,p:2412:1:2,p:2412:1:3,p:2413:1:2,p:2413:1:3,p:2414:1:2,p:2414:1:3,p:2415:1:2,p:2415:1:3,p:2416:1:2,p:2416:1:3,p:2417:1:2,p:2417:1:3,p:2418:1:2,p:2418:1:3,p:2419:1:2,p:2419:1:3,p:2420:1:3,p:2421:1:2,p:2421:1:3,p:2422:1:2,p:2422:1:3,p:2423:1:2,p:2423:1:3,p:2424:1:2,p:2424:1:3,p:2425:1:2,p:2425:1:3,p:2426:1:2,p:2426:1:3,p:2427:1:2,p:2427:1:3,p:2428:1:2,p:2428:1:3,p:2429:1:2,p:2429:1:3,p:2432:1:3,p:2433:1:3,p:2434:1:3,p:2435:1:3,p:2436:1:3,p:2437:1:3,p:2438:1:3,p:2439:1:2,p:2439:1:3,p:2440:1:3,p:2441:1:3,p:2443:1:3,p:2444:1:3,p:2445:1:3,p:2446:1:3,p:2447:1:3,p:2448:1:3,p:2449:1:3,p:2450:1:3,p:2451:1:3,p:2452:1:3,p:2453:1:3,p:2458:1:3,p:2459:1:3,p:2460:1:3,p:2461:1:3,p:2462:1:3,p:2463:1:3,p:2464:1:2,p:2464:1:3,p:2469:1:3,p:2471:1:3,p:2472:1:3,p:2473:1:3,p:2474:1:2,p:2474:1:3,p:2475:1:2,p:2475:1:3,p:2476:1:2,p:2476:1:3,p:2477:1:2,p:2477:1:3",
        useMaxPPU = true,
        useMinLevel = false,
        useQuality = true,
        useMinStack = true,
        usePercent = true,
        exactMatch = true,
        priceFn = "",
        types = "",
        subtypes = ""
    },
    {
        name = "Level 25",
        ids =  "p:39:25:2,p:39:25:3,p:40:25:2,p:40:25:3,p:41:25:2,p:41:25:3,p:42:25:2,p:42:25:3,p:43:25:2,p:43:25:3,p:44:25:2,p:44:25:3,p:45:25:2,p:45:25:3,p:46:25:2,p:46:25:3,p:47:25:2,p:47:25:3,p:49:25:3,p:50:25:2,p:50:25:3,p:51:25:2,p:51:25:3,p:52:25:2,p:52:25:3,p:55:25:2,p:55:25:3,p:56:25:3,p:57:25:3,p:58:25:3,p:59:25:3,p:64:25:2,p:64:25:3,p:65:25:2,p:65:25:3,p:67:25:2,p:67:25:3,p:68:25:2,p:68:25:3,p:70:25:2,p:70:25:3,p:72:25:2,p:72:25:3,p:74:25:2,p:74:25:3,p:75:25:2,p:75:25:3,p:77:25:2,p:77:25:3,p:78:25:2,p:78:25:3,p:85:25:2,p:85:25:3,p:86:25:2,p:86:25:3,p:87:25:3,p:89:25:2,p:89:25:3,p:90:25:2,p:90:25:3,p:95:25:2,p:95:25:3,p:114:25:3,p:115:25:2,p:115:25:3,p:116:25:2,p:116:25:3,p:117:25:2,p:117:25:3,p:118:25:2,p:118:25:3,p:119:25:2,p:119:25:3,p:120:25:2,p:120:25:3,p:122:25:2,p:122:25:3,p:125:25:2,p:125:25:3,p:126:25:2,p:126:25:3,p:127:25:2,p:127:25:3,p:128:25:2,p:128:25:3,p:130:25:3,p:132:25:3,p:136:25:2,p:136:25:3,p:137:25:2,p:137:25:3,p:138:25:2,p:138:25:3,p:139:25:2,p:139:25:3,p:140:25:2,p:140:25:3,p:141:25:2,p:141:25:3,p:142:25:2,p:142:25:3,p:143:25:2,p:143:25:3,p:144:25:2,p:144:25:3,p:145:25:2,p:145:25:3,p:146:25:3,p:153:25:2,p:153:25:3,p:156:25:3,p:157:25:2,p:157:25:3,p:158:25:2,p:158:25:3,p:159:25:2,p:159:25:3,p:162:25:3,p:163:25:3,p:164:25:3,p:165:25:3,p:166:25:2,p:166:25:3,p:167:25:3,p:168:25:3,p:169:25:3,p:172:25:3,p:173:25:3,p:174:25:3,p:175:25:3,p:183:25:3,p:186:25:3,p:190:25:2,p:190:25:3,p:191:25:2,p:191:25:3,p:193:25:3,p:194:25:2,p:194:25:3,p:195:25:2,p:195:25:3,p:196:25:2,p:196:25:3,p:197:25:2,p:197:25:3,p:198:25:3,p:200:25:2,p:200:25:3,p:204:25:2,p:204:25:3,p:205:25:2,p:205:25:3,p:206:25:2,p:206:25:3,p:207:25:2,p:207:25:3,p:209:25:2,p:209:25:3,p:210:25:2,p:210:25:3,p:211:25:3,p:212:25:2,p:212:25:3,p:213:25:2,p:213:25:3,p:215:25:2,p:215:25:3,p:218:25:2,p:218:25:3,p:224:25:2,p:224:25:3,p:229:25:3,p:232:25:2,p:232:25:3,p:233:25:2,p:233:25:3,p:234:25:3,p:235:25:2,p:235:25:3,p:236:25:2,p:236:25:3,p:237:25:2,p:237:25:3,p:238:25:2,p:238:25:3,p:239:25:3,p:241:25:3,p:242:25:3,p:251:25:2,p:251:25:3,p:253:25:3,p:254:25:2,p:254:25:3,p:261:25:2,p:261:25:3,p:262:25:2,p:262:25:3,p:264:25:3,p:266:25:3,p:267:25:2,p:267:25:3,p:271:25:2,p:271:25:3,p:277:25:3,p:278:25:3,p:279:25:3,p:285:25:3,p:286:25:3,p:289:25:2,p:289:25:3,p:292:25:2,p:292:25:3,p:293:25:3,p:302:25:3,p:303:25:3,p:306:25:2,p:306:25:3,p:308:25:2,p:308:25:3,p:309:25:3,p:310:25:3,p:311:25:3,p:317:25:3,p:318:25:3,p:319:25:2,p:319:25:3,p:328:25:3,p:330:25:3,p:333:25:3,p:335:25:3,p:337:25:3,p:338:25:3,p:339:25:3,p:340:25:2,p:340:25:3,p:341:25:2,p:341:25:3,p:342:25:2,p:342:25:3,p:343:25:3,p:348:25:3,p:381:25:3,p:382:25:3,p:629:25:2,p:629:25:3,p:630:25:2,p:630:25:3,p:650:25:3,p:652:25:2,p:652:25:3,p:665:25:3,p:792:25:2,p:792:25:3,p:834:25:3,p:836:25:3,p:844:25:2,p:844:25:3,p:845:25:2,p:845:25:3,p:846:25:0,p:846:25:1,p:846:25:2,p:846:25:3,p:847:25:2,p:847:25:3,p:848:25:3,p:868:25:3,p:1039:25:2,p:1039:25:3,p:1040:25:2,p:1040:25:3,p:1061:25:2,p:1061:25:3,p:1063:25:3,p:1124:25:3,p:1125:25:3,p:1126:25:3,p:1143:25:3,p:1144:25:3,p:1146:25:3,p:1147:25:3,p:1149:25:3,p:1150:25:3,p:1151:25:3,p:1152:25:3,p:1153:25:3,p:1154:25:3,p:1155:25:3,p:1156:25:3,p:1174:25:3,p:1177:25:3,p:1178:25:3,p:1180:25:3,p:1183:25:3,p:1185:25:3,p:1196:25:3,p:1197:25:3,p:1198:25:3,p:1200:25:3,p:1201:25:3,p:1202:25:3,p:1204:25:3,p:1205:25:3,p:1206:25:3,p:1207:25:3,p:1208:25:3,p:1209:25:3,p:1211:25:3,p:1212:25:3,p:1213:25:3,p:1226:25:3,p:1227:25:3,p:1228:25:3,p:1229:25:3,p:1230:25:3,p:1231:25:3,p:1232:25:3,p:1233:25:3,p:1234:25:3,p:1235:25:3,p:1237:25:3,p:1243:25:3,p:1244:25:3,p:1245:25:3,p:1256:25:3,p:1276:25:3,p:1320:25:2,p:1320:25:3,p:1321:25:2,p:1321:25:3,p:1322:25:3,p:1323:25:2,p:1323:25:3,p:1328:25:3,p:1329:25:3,p:1330:25:2,p:1330:25:3,p:1331:25:3,p:1332:25:3,p:1333:25:3,p:1334:25:3,p:1335:25:3,p:1336:25:3,p:1337:25:3,p:1338:25:3,p:1343:25:3,p:1344:25:3,p:1345:25:2,p:1345:25:3,p:1346:25:3,p:1348:25:3,p:1349:25:2,p:1349:25:3,p:1351:25:2,p:1351:25:3,p:1385:25:0,p:1385:25:1,p:1385:25:2,p:1385:25:3,p:1387:25:3,p:1394:25:3,p:1395:25:3,p:1396:25:3,p:1403:25:3,p:1412:25:3,p:1416:25:2,p:1416:25:3,p:1426:25:1,p:1426:25:2,p:1426:25:3,p:1428:25:3,p:1429:25:3,p:1430:25:3,p:1432:25:3,p:1434:25:3,p:1442:25:3,p:1446:25:2,p:1446:25:3,p:1448:25:3,p:1450:25:3,p:1453:25:3,p:1458:25:3,p:1467:25:3,p:1471:25:2,p:1471:25:3,p:1478:25:3,p:1495:25:3,p:1511:25:3,p:1515:25:2,p:1515:25:3,p:1516:25:3,p:1517:25:2,p:1517:25:3,p:1518:25:3,p:1521:25:3,p:1523:25:3,p:1524:25:3,p:1530:25:3,p:1531:25:3,p:1532:25:2,p:1532:25:3,p:1533:25:3,p:1536:25:3,p:1537:25:2,p:1537:25:3,p:1538:25:2,p:1538:25:3,p:1539:25:3,p:1540:25:2,p:1540:25:3,p:1541:25:3,p:1542:25:3,p:1544:25:3,p:1545:25:3,p:1563:25:3,p:1564:25:3,p:1565:25:3,p:1566:25:3,p:1567:25:3,p:1568:25:3,p:1569:25:3,p:1570:25:3,p:1571:25:3,p:1574:25:3,p:1575:25:2,p:1575:25:3,p:1576:25:3,p:1577:25:3,p:1588:25:3,p:1596:25:2,p:1596:25:3,p:1597:25:2,p:1597:25:3,p:1598:25:3,p:1600:25:3,p:1601:25:2,p:1601:25:3,p:1622:25:3,p:1623:25:3,p:1624:25:3,p:1625:25:3,p:1626:25:3,p:1627:25:3,p:1628:25:3,p:1629:25:3,p:1631:25:3,p:1632:25:3,p:1633:25:3,p:1634:25:3,p:1655:25:3,p:1656:25:3,p:1661:25:3,p:1662:25:3,p:1663:25:3,p:1664:25:3,p:1665:25:3,p:1672:25:3,p:1687:25:3,p:1688:25:3,p:1690:25:3,p:1692:25:3,p:1693:25:3,p:1699:25:3,p:1700:25:3,p:1701:25:3,p:1705:25:3,p:1706:25:3,p:1711:25:2,p:1711:25:3,p:1716:25:3,p:1717:25:3,p:1719:25:3,p:1720:25:3,p:1721:25:3,p:1723:25:3,p:1725:25:2,p:1725:25:3,p:1727:25:2,p:1727:25:3,p:1752:25:3,p:1753:25:3,p:1754:25:3,p:1755:25:3,p:1756:25:2,p:1756:25:3,p:1759:25:2,p:1759:25:3,p:1760:25:3,p:1764:25:3,p:1765:25:3,p:1766:25:3,p:1802:25:3,p:1803:25:3,p:1804:25:3,p:1805:25:3,p:1806:25:3,p:1808:25:3,p:1884:25:3,p:1885:25:3,p:1886:25:3,p:1887:25:3,p:1889:25:3,p:1903:25:3,p:1907:25:3,p:1911:25:2,p:1911:25:3,p:1920:25:3,p:1921:25:3,p:1922:25:3,p:1926:25:3,p:1927:25:3,p:1928:25:3,p:1929:25:3,p:1931:25:3,p:1934:25:3,p:1943:25:3,p:1949:25:3,p:1952:25:3,p:1953:25:3,p:1954:25:3,p:1955:25:3,p:1956:25:3,p:1957:25:3,p:1958:25:3,p:1959:25:3,p:1960:25:3,p:1961:25:3,p:1962:25:3,p:1963:25:3,p:1964:25:3,p:1965:25:3,p:1966:25:3,p:1967:25:3,p:1968:25:3,p:1984:25:3,p:1998:25:3,p:1999:25:2,p:1999:25:3,p:2000:25:1,p:2000:25:2,p:2000:25:3,p:2001:25:3,p:2002:25:3,p:2042:25:3,p:2050:25:3,p:2063:25:2,p:2063:25:3,p:2065:25:2,p:2065:25:3,p:2071:25:3,p:2072:25:3,p:2077:25:2,p:2077:25:3,p:2078:25:3,p:2079:25:3,p:2080:25:3,p:2081:25:3,p:2082:25:3,p:2083:25:3,p:2084:25:3,p:2085:25:3,p:2086:25:3,p:2087:25:3,p:2088:25:3,p:2089:25:3,p:2090:25:3,p:2091:25:3,p:2092:25:3,p:2117:25:3,p:2118:25:3,p:2119:25:3,p:2120:25:3,p:2121:25:3,p:2135:25:3,p:2157:25:3,p:2163:25:3,p:2186:25:3,p:2187:25:3,p:2188:25:2,p:2188:25:3,p:2189:25:2,p:2189:25:3,p:2190:25:2,p:2190:25:3,p:2192:25:2,p:2192:25:3,p:2196:25:2,p:2196:25:3,p:2197:25:2,p:2197:25:3,p:2198:25:2,p:2198:25:3,p:2199:25:3,p:2403:25:3,p:2404:25:2,p:2404:25:3,p:2405:25:2,p:2405:25:3,p:2406:25:2,p:2406:25:3,p:2407:25:2,p:2407:25:3,p:2408:25:2,p:2408:25:3,p:2409:25:2,p:2409:25:3,p:2410:25:2,p:2410:25:3,p:2411:25:2,p:2411:25:3,p:2412:25:2,p:2412:25:3,p:2413:25:2,p:2413:25:3,p:2414:25:2,p:2414:25:3,p:2415:25:2,p:2415:25:3,p:2416:25:2,p:2416:25:3,p:2417:25:2,p:2417:25:3,p:2418:25:2,p:2418:25:3,p:2419:25:2,p:2419:25:3,p:2420:25:3,p:2421:25:2,p:2421:25:3,p:2422:25:2,p:2422:25:3,p:2423:25:2,p:2423:25:3,p:2424:25:2,p:2424:25:3,p:2425:25:2,p:2425:25:3,p:2426:25:2,p:2426:25:3,p:2427:25:2,p:2427:25:3,p:2428:25:2,p:2428:25:3,p:2429:25:2,p:2429:25:3,p:2432:25:3,p:2433:25:3,p:2434:25:3,p:2435:25:3,p:2436:25:3,p:2437:25:3,p:2438:25:3,p:2439:25:2,p:2439:25:3,p:2440:25:3,p:2441:25:3,p:2443:25:3,p:2444:25:3,p:2445:25:3,p:2446:25:3,p:2447:25:3,p:2448:25:3,p:2449:25:3,p:2450:25:3,p:2451:25:3,p:2452:25:3,p:2453:25:3,p:2458:25:3,p:2459:25:3,p:2460:25:3,p:2461:25:3,p:2462:25:3,p:2463:25:3,p:2464:25:2,p:2464:25:3,p:2469:25:3,p:2471:25:3,p:2472:25:3,p:2473:25:3,p:2474:25:2,p:2474:25:3,p:2475:25:2,p:2475:25:3,p:2476:25:2,p:2476:25:3,p:2477:25:2,p:2477:25:3",
        useMaxPPU = true,
        useMinLevel = false,
        useQuality = true,
        useMinStack = true,
        usePercent = true,
        exactMatch = true,
        priceFn = "",
        types = "",
        subtypes = ""
    }
};

Pets.name = "Pets";
Pets.ids = "";
Pets.useMaxPPU = true;
Pets.useMinLevel = false;
Pets.useQuality = true;
Pets.useMinStack = true;
Pets.usePercent = true;
Pets.priceFn = "";
Pets.types = "";
Pets.subtypes = "";

tinsert(Ans.Data, Pets);