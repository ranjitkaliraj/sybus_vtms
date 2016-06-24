

--Inserting busstop information
insert into busstop(stop_name, location_point) values('Swayambhu Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.71595, 85.28364),4326)),900913));
insert into busstop(stop_name, location_point) values('Sitapaila Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70743, 85.28263),4326)),900913));
insert into busstop(stop_name, location_point) values('Kalanki Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.69337, 85.28174),4326)),900913));
insert into busstop(stop_name, location_point) values('SoaltiMood Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.69664, 85.29356),4326)),900913));
insert into busstop(stop_name, location_point) values('Kalimati Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.69835, 85.29960),4326)),900913));
insert into busstop(stop_name, location_point) values('Teku Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.69667, 85.30570),4326)),900913));
insert into busstop(stop_name, location_point) values('Tripureshwor1 Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.69462, 85.31135),4326)),900913));
insert into busstop(stop_name, location_point) values('Tripureshwor2 Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.69397, 85.31336),4326)),900913));
insert into busstop(stop_name, location_point) values('RNAC Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70157, 85.31357),4326)),900913));
insert into busstop(stop_name, location_point) values('Jamal Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70926, 85.31666),4326)),900913));
insert into busstop(stop_name, location_point) values('DurbarMarg Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.71332, 85.31819),4326)),900913));
insert into busstop(stop_name, location_point) values('Hattisar Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.71099, 85.32210),4326)),900913));
insert into busstop(stop_name, location_point) values('Kamalpokhari Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.71010, 85.32514),4326)),900913));
insert into busstop(stop_name, location_point) values('Gyaneshwor Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70866, 85.33199),4326)),900913));
insert into busstop(stop_name, location_point) values('Maitidevi Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70830, 85.33338),4326)),900913));
insert into busstop(stop_name, location_point) values('Ratopul Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70811, 85.33626),4326)),900913));
insert into busstop(stop_name, location_point) values('Gaushala Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70780, 85.34334),4326)),900913));
insert into busstop(stop_name, location_point) values('Tilganga Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70613, 85.34959),4326)),900913));
insert into busstop(stop_name, location_point) values('Airport Bus Station',ST_Transform( ST_FlipCoordinates(ST_SetSRID(ST_MakePoint(27.70019, 85.35411),4326)),900913));



--Inserting route information
INSERT INTO route(route_name, bus_stops) VALUES('Route 1', 'Swayambhu Bus Station,Sitapaila Bus Station,Kalanki Bus Station,SoaltiMood Bus Station,Kalimati Bus Station,Teku Bus Station,Tripureshwor1 Bus Station,Tripureshwor2 Bus Station,RNAC Bus Station,Jamal Bus Station,DurbarMarg Bus Station,Hattisar Bus Station,Kamalpokhari Bus Station,Gyaneshwor Bus Station,Maitidevi Bus Station,Ratopul Bus Station,Gaushala Bus Station,Tilganga Bus Station,Airport Bus Station');
INSERT INTO route(route_name, bus_stops) VALUES('Route 2', 'Kalimati Bus Station,Teku Bus Station,Tripureshwor1 Bus Station,Tripureshwor2 Bus Station,RNAC Bus Station,Jamal Bus Station,DurbarMarg Bus Station,Hattisar Bus Station,Kamalpokhari Bus Station,Gyaneshwor Bus Station,Maitidevi Bus Station,Ratopul Bus Station');
INSERT INTO route(route_name, bus_stops) VALUES('Route 3', 'Swayambhu Bus Station,Sitapaila Bus Station,Kalanki Bus Station,SoaltiMood Bus Station,Kalimati Bus Station,Teku Bus Station,Tripureshwor1 Bus Station,Tripureshwor2 Bus Station,RNAC Bus Station');


--Inserting route way information
update route set route_way = ST_GeomFromText('LINESTRING(9493731.37779686 3213208.55494593,9493618.94511116 3212137.2306662,9493523.21034907 3211140.16950828,9493497.60686619 3211024.50001657,9493498.7200611 3210956.60750816,9493519.87076435 3210369.47705031,9493632.30345005 3210393.3640948,9493738.0569663 3210421.02282983,9493825.99936403 3210459.99659654,9493880.54591452 3210482.62657639,9494336.95582677 3210615.8927702,9494415.99266524 3210623.43617837,9494449.38851248 3210630.97959068,9494519.51979167 3210654.86709034,9494537.3309102 3210654.86709034,9494551.802444 3210653.60985248,9494662.00873989 3210632.23682646,9494679.81985842 3210629.722355,9494717.66848529 3210633.49406237,9494739.93238344 3210641.0374802,9494756.63030706 3210648.58090218,9494780.00740013 3210673.72567207,9494835.66714553 3210780.59145811,9494863.49701822 3210791.90670771,9494936.96788215 3210819.56624601,9495508.03686992 3211014.44184598,9495552.56466624 3211027.01456037,9495634.94108942 3211005.64095276,9495841.9953423 3210959.12203952,9495947.74885855 3210927.69043066,9495966.67317199 3210917.63233103,9496187.08576376 3210784.36320694,9496206.01007719 3210775.56246128,9496336.25388142 3210734.07330779,9496416.40391479 3210705.15669923,9496474.29005 3210681.26911203,9496672.43874362 3210585.71917903,9496816.04088674 3210526.62942181,9496895.0777252 3210490.1699113,9496920.68120809 3210480.11213234,

9496970.77497894 3210462.51103691,9497039.79306323 3210444.90996404,9497083.20766464 3210436.10943608,9497105.4715628 3210433.59500055,9497107.69795262 3210439.88109023,9497112.15073225 3210446.16718278,9497118.8299017 3210463.76825726,9497122.16948642 3210486.39824333,9497121.05629151 3210505.25659355,9497093.22641882 3210717.72913025,9497082.09446974 3210835.91054484,9497075.41530029 3210866.08468615,9497052.03820722 3210933.97674667,9497042.01945305 3210951.57844683,9497033.11389378 3210964.15110362,9497045.35903777 3211120.05300489,9497049.81181741 3211161.54332544,9497053.15140213 3211203.03377144,9497056.49098685 3211272.18479358,9497063.1701563 3211400.42942988,9497066.50974102 3211434.37674013,9497085.43405446 3211650.63565143,9497083.20766464 3211677.03958922,9497088.77363918 3211705.95824606,9497092.11322391 3211762.53840314,9497096.56600354 3211778.88382529,9497116.60351188 3211878.21411715,9497124.39587624 3211922.22143838,9497145.54657949 3212090.707916,9497151.11255403 3212193.81260205,9497155.56533366 3212267.99816044,9497160.01811329 3212278.05725009,9497181.16881654 3212301.94761758,9497202.31951979 3212301.94761758,9497255.75287537 3212310.74934241,9497322.54456985 3212333.38237504,9497407.14738285 3212367.33199401,9497448.33559445 3212384.93553322,9497455.01476389 3212389.96512,9497462.80712825 3212398.76690131,

9497467.25990788 3212410.08348557,9497471.71268751 3212446.54809837,9497470.5994926 3212467.92395095,9497487.29741622 3212495.58686843,9497537.39118708 3212838.86316812,9497545.18355143 3212867.78427443,9497577.46620377 3212877.84380396,9497709.93639781 3212913.05221543,9497775.61489738 3212920.59688679,9497998.25387896 3212926.88411609,9498006.04624332 3212891.67566912,9498022.74416694 3212729.46649155,9498027.19694657 3212659.05070155,9498021.63097203 3212620.07068753,9498012.72541277 3212584.86302816,9497999.36707387 3212523.24984171,9498027.19694657 3212501.87390291,9498080.63030215 3212496.8442751,9498125.15809847 3212491.81464913,9498279.89219067 3212481.75540271,9498351.13666478 3212472.95356816,9498451.32420649 3212461.63693202,9498472.47490974 3212452.83511038,9498823.13130574 3212361.04502119,9498868.77229697 3212350.98587068,9498919.97926273 3212337.15455078,9498966.73344886 3212327.09541778,9498966.73344886 3212327.09541778,9499113.67517671 3212291.88851041,9499139.2786596 3212286.85895959,9499216.08910824 3212260.45384804,9499259.50370965 3212245.36523569,

9499268.40926892 3212246.62261942,9499296.23914161 3212241.59308519,9499589.0094024 3212222.73234828,9499619.06566491 3212221.47496674,9499932.98662895 3212206.38639727,9499944.11857803 3212206.38639727,9499999.77832343 3212205.12901723,9500028.72139103 3212208.90115769,9500113.32420404 3212231.53402228,9500135.5881022 3212235.30617001,9500212.39855084 3212230.27663993,9500258.03954207 3212221.47496674,9500284.75621986 3212213.93067993,9500354.88749906 3212190.04046573,9500377.15139722 3212183.75357418,9500418.33960881 3212167.40766961,9500490.69727783 3212109.56847139,9500652.11053948 3211964.97154276,9500674.37443763 3211951.14061206,9500694.41194598 3211942.33911796,9500732.26057285 3211929.76556477,9500755.63766591 3211925.99350106,9500776.78836916 3211924.73614672,9500819.08977566 3211927.25085551,9501072.89821467 3211973.77305137,9501151.93505314 3211986.3466449,9501171.97256148 3211988.86136499,9501196.46284946 3211987.60400489,9501220.95313743 3211982.57456563,9501242.10384068 3211973.77305137,9501261.02815412 3211963.71418485,9501282.17885737 3211947.36854247,9501298.87678098 3211931.02291957,9501315.5747046 3211908.39055078,9501326.70665368 3211888.27292099,9501335.61221295 3211864.38327392,9501338.95179767 3211844.26570866,9501355.64972129 3211586.51201406,9501361.21569583 3211557.593609,9501376.80042454 3211519.87404182,9501511.4970084 3211319.962067,9501533.76090656 3211292.30152001,9501576.06231306 3211226.92226696)',900913) where route_name='Route 1';

update route set route_way = ST_GeomFromText('LINESTRING(9497039.79306323 3210444.90996404,9497083.20766464 3210436.10943608,9497105.4715628 3210433.59500055,9497107.69795262 3210439.88109023,9497112.15073225 3210446.16718278,9497118.8299017 3210463.76825726,9497122.16948642 3210486.39824333,9497121.05629151 3210505.25659355,9497093.22641882 3210717.72913025,9497082.09446974 3210835.91054484,9497075.41530029 3210866.08468615,9497052.03820722 3210933.97674667,9497042.01945305 3210951.57844683,9497033.11389378 3210964.15110362,9497045.35903777 3211120.05300489,9497049.81181741 3211161.54332544,9497053.15140213 3211203.03377144,9497056.49098685 3211272.18479358,9497063.1701563 3211400.42942988,9497066.50974102 3211434.37674013,9497085.43405446 3211650.63565143,9497083.20766464 3211677.03958922,9497088.77363918 3211705.95824606,9497092.11322391 3211762.53840314,9497096.56600354 3211778.88382529,9497116.60351188 3211878.21411715,9497124.39587624 3211922.22143838,9497145.54657949 3212090.707916,9497151.11255403 3212193.81260205,9497155.56533366 3212267.99816044,9497160.01811329 3212278.05725009,9497181.16881654 3212301.94761758,9497202.31951979 3212301.94761758,9497255.75287537 3212310.74934241,9497322.54456985 3212333.38237504,9497407.14738285 3212367.33199401,9497448.33559445 3212384.93553322,

9497455.01476389 3212389.96512,9497462.80712825 3212398.76690131,9497467.25990788 3212410.08348557,9497471.71268751 3212446.54809837,9497470.5994926 3212467.92395095,9497487.29741622 3212495.58686843,9497537.39118708 3212838.86316812,9497545.18355143 3212867.78427443,9497577.46620377 3212877.84380396,9497709.93639781 3212913.05221543,9497775.61489738 3212920.59688679,9497998.25387896 3212926.88411609,9498006.04624332 3212891.67566912,9498022.74416694 3212729.46649155,9498027.19694657 3212659.05070155,9498021.63097203 3212620.07068753,9498012.72541277 3212584.86302816,9497999.36707387 3212523.24984171,9498027.19694657 3212501.87390291,9498080.63030215 3212496.8442751,9498125.15809847 3212491.81464913,9498279.89219067 3212481.75540271,9498351.13666478 3212472.95356816,9498451.32420649 3212461.63693202,9498472.47490974 3212452.83511038,9498823.13130574 3212361.04502119,9498868.77229697 3212350.98587068,9498919.97926273 3212337.15455078,9498966.73344886 3212327.09541778,9498966.73344886 3212327.09541778,9499113.67517671 3212291.88851041,9499139.2786596 3212286.85895959,9499216.08910824 3212260.45384804)',900913) where route_name='Route 2';

update route set route_way = ST_GeomFromText('LINESTRING(9497471.71268751 3212446.54809837,9497470.5994926 3212467.92395095,9497487.29741622 3212495.58686843,9497537.39118708 3212838.86316812,9497545.18355143 3212867.78427443,9497577.46620377 3212877.84380396,9497709.93639781 3212913.05221543,9497775.61489738 3212920.59688679,9497998.25387896 3212926.88411609,9498006.04624332 3212891.67566912,9498022.74416694 3212729.46649155,9498027.19694657 3212659.05070155,9498021.63097203 3212620.07068753,9498012.72541277 3212584.86302816,9497999.36707387 3212523.24984171,9498027.19694657 3212501.87390291,9498080.63030215 3212496.8442751,9498125.15809847 3212491.81464913,9498279.89219067 3212481.75540271,9498351.13666478 3212472.95356816,9498451.32420649 3212461.63693202,9498472.47490974 3212452.83511038,9498823.13130574 3212361.04502119,9498868.77229697 3212350.98587068,9498919.97926273 3212337.15455078,9498966.73344886 3212327.09541778,9498966.73344886 3212327.09541778,9499113.67517671 3212291.88851041,9499139.2786596 3212286.85895959,9499216.08910824 3212260.45384804,9499259.50370965 3212245.36523569,9499268.40926892 3212246.62261942,9499296.23914161 3212241.59308519,9499589.0094024 3212222.73234828,

9499619.06566491 3212221.47496674,9499932.98662895 3212206.38639727,9499944.11857803 3212206.38639727,9499999.77832343 3212205.12901723,9500028.72139103 3212208.90115769,9500113.32420404 3212231.53402228,9500135.5881022 3212235.30617001,9500212.39855084 3212230.27663993,9500258.03954207 3212221.47496674,9500284.75621986 3212213.93067993,9500354.88749906 3212190.04046573,9500377.15139722 3212183.75357418,9500418.33960881 3212167.40766961,9500490.69727783 3212109.56847139,9500652.11053948 3211964.97154276,9500674.37443763 3211951.14061206,9500694.41194598 3211942.33911796,9500732.26057285 3211929.76556477,9500755.63766591 3211925.99350106,9500776.78836916 3211924.73614672,9500819.08977566 3211927.25085551,9501072.89821467 3211973.77305137,9501151.93505314 3211986.3466449,9501171.97256148 3211988.86136499,9501196.46284946 3211987.60400489,9501220.95313743 3211982.57456563,9501242.10384068 3211973.77305137,9501261.02815412 3211963.71418485,9501282.17885737 3211947.36854247,9501298.87678098 3211931.02291957,9501315.5747046 3211908.39055078,9501326.70665368 3211888.27292099,9501335.61221295 3211864.38327392,9501338.95179767 3211844.26570866,9501355.64972129 3211586.51201406,9501361.21569583 3211557.593609,9501376.80042454 3211519.87404182,9501511.4970084 3211319.962067,9501533.76090656 3211292.30152001,9501576.06231306 3211226.92226696)',900913) where route_name='Route 3';



--Inserting route stops distance information
--Route 1
INSERT INTO distance(distance, stop_id, route_id) VALUES(5, (SELECT stop_id FROM busstop WHERE stop_name='Swayambhu Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(6, (SELECT stop_id FROM busstop WHERE stop_name='Sitapaila Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Kalanki Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(6, (SELECT stop_id FROM busstop WHERE stop_name='SoaltiMood Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Kalimati Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Teku Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Tripureshwor1 Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(4, (SELECT stop_id FROM busstop WHERE stop_name='Tripureshwor2 Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(7, (SELECT stop_id FROM busstop WHERE stop_name='RNAC Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Jamal Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='DurbarMarg Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(5, (SELECT stop_id FROM busstop WHERE stop_name='Hattisar Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(5, (SELECT stop_id FROM busstop WHERE stop_name='Kamalpokhari Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Gyaneshwor Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Maitidevi Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Ratopul Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Gaushala Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Tilganga Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(1, (SELECT stop_id FROM busstop WHERE stop_name='Airport Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 1'));

--Route 2
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Kalimati Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Teku Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Tripureshwor1 Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(4, (SELECT stop_id FROM busstop WHERE stop_name='Tripureshwor2 Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(7, (SELECT stop_id FROM busstop WHERE stop_name='RNAC Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Jamal Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='DurbarMarg Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(5, (SELECT stop_id FROM busstop WHERE stop_name='Hattisar Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(5, (SELECT stop_id FROM busstop WHERE stop_name='Kamalpokhari Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Gyaneshwor Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Maitidevi Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Ratopul Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 2'));

--Route 3
INSERT INTO distance(distance, stop_id, route_id) VALUES(5, (SELECT stop_id FROM busstop WHERE stop_name='Swayambhu Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(6, (SELECT stop_id FROM busstop WHERE stop_name='Sitapaila Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Kalanki Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(6, (SELECT stop_id FROM busstop WHERE stop_name='SoaltiMood Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Kalimati Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(3, (SELECT stop_id FROM busstop WHERE stop_name='Teku Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(2, (SELECT stop_id FROM busstop WHERE stop_name='Tripureshwor1 Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(4, (SELECT stop_id FROM busstop WHERE stop_name='Tripureshwor2 Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));
INSERT INTO distance(distance, stop_id, route_id) VALUES(7, (SELECT stop_id FROM busstop WHERE stop_name='RNAC Bus Station'),(SELECT route_id FROM route WHERE route_name='Route 3'));



--Inserting vehicle information
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 1111');
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 2222');
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 3333');
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 4444');
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 5555');
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 6666');
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 7777');
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 8888');
INSERT INTO vehicle(vehicle_name) VALUES('BA 50 PA 9999');



--Inserting Schedule information
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111'), (SELECT route_id from route WHERE route_name='Route 1'), '10:30');
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222'), (SELECT route_id from route WHERE route_name='Route 1'), '10:45');
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333'), (SELECT route_id from route WHERE route_name='Route 1'), '11:00');
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 4444'), (SELECT route_id from route WHERE route_name='Route 1'), '11:15');
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 5555'), (SELECT route_id from route WHERE route_name='Route 1'), '11:30');
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 6666'), (SELECT route_id from route WHERE route_name='Route 2'), '12:30');
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 7777'), (SELECT route_id from route WHERE route_name='Route 2'), '12:45');
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 8888'), (SELECT route_id from route WHERE route_name='Route 2'), '01:00');
INSERT INTO schedule(vehicle_id, route_id, schedule_time) values((SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 9999'), (SELECT route_id from route WHERE route_name='Route 2'), '01:15');




--Inserting fare information
INSERT INTO fare(amount, distance) VALUES(10, 5);
INSERT INTO fare(amount, distance) VALUES(12, 8);
INSERT INTO fare(amount, distance) VALUES(15, 10);
INSERT INTO fare(amount, distance) VALUES(18, 15);
INSERT INTO fare(amount, distance) VALUES(20, 18);
INSERT INTO fare(amount, distance) VALUES(22, 20);
INSERT INTO fare(amount, distance) VALUES(25, 25);
INSERT INTO fare(amount, distance) VALUES(28, 30);
INSERT INTO fare(amount, distance) VALUES(30, 35);
INSERT INTO fare(amount, distance) VALUES(35, 40);
INSERT INTO fare(amount, distance) VALUES(40, 50);


--Vehicle Session information

--location soaltimoad road LONGITUDE: 85.297149, LATITUDE: 27.697721
INSERT INTO VEHICLESESSION(location_point, flag_status, schedule_id) VALUES((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.294925,27.697056), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), false, (SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1')));

--location Teku LONGITUDE: LONGITUDE: 85.305508, LATITUDE: 27.696766
INSERT INTO VEHICLESESSION(location_point, flag_status, schedule_id) VALUES((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.301587,27.698258), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), false, (SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1')));

--location New Road LONGITUDE: 85.313566, LATITUDE: 27.701344
INSERT INTO VEHICLESESSION(location_point, flag_status, schedule_id) VALUES((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.303818,27.697664), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), false, (SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1')));




--Vehicle location history information 

--Inserting to the vehicle location history for vehicle BA 50 PA 1111. From Kalanki to Soaltimoad Total 6 mins.
/*
LONGITUDE: 85.297149, LATITUDE: 27.697721		Soaltimoad
LONGITUDE: 85.296378, LATITUDE: 27.697465
LONGITUDE: 85.295713, LATITUDE: 27.697294
LONGITUDE: 85.294174, LATITUDE: 27.696781
LONGITUDE: 85.293470, LATITUDE: 27.696467
LONGITUDE: 85.293282, LATITUDE: 27.696168
LONGITUDE: 85.293111, LATITUDE: 27.695817
LONGITUDE: 85.292961, LATITUDE: 27.695684
LONGITUDE: 85.292789, LATITUDE: 27.695555
LONGITUDE: 85.292145, LATITUDE: 27.695446
LONGITUDE: 85.291775, LATITUDE: 27.695475
LONGITUDE: 85.291244, LATITUDE: 27.695579
LONGITUDE: 85.290439, LATITUDE: 27.695555
LONGITUDE: 85.289683, LATITUDE: 27.695375
LONGITUDE: 85.288894, LATITUDE: 27.695275
LONGITUDE: 85.288245, LATITUDE: 27.695095
LONGITUDE: 85.287022, LATITUDE: 27.694772
LONGITUDE: 85.286228, LATITUDE: 27.694577
LONGITUDE: 85.285584, LATITUDE: 27.694411
LONGITUDE: 85.284839, LATITUDE: 27.694187
LONGITUDE: 85.284077, LATITUDE: 27.693907
LONGITUDE: 85.283047, LATITUDE: 27.693622
LONGITUDE: 85.282189, LATITUDE: 27.693442
LONGITUDE: 85.281727, LATITUDE: 27.693356		Kalanki
*/
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.297149, 27.697721 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.296378, 27.697465 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.295713, 27.697294 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.294174, 27.696781 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.293470, 27.696467 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.293282, 27.696168 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.293111, 27.695817 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.292961, 27.695684 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.292789, 27.695555 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.292145, 27.695446 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.291775, 27.695475 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.291244, 27.695579 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.290439, 27.695555 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.289683, 27.695375 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.288894, 27.695275 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.288245, 27.695095 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.287022, 27.694772 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.286228, 27.694577 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.285584, 27.694411 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.284839, 27.694187 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.284077, 27.693907 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.283047, 27.693622 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.282189, 27.693442 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.281727, 27.693356 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 1111') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));




--Inserting to the vehicle location history for vehicle BA 50 PA 2222. From soaltimoad to Teku Total 6 mins.
/*
LONGITUDE: 85.305508, LATITUDE: 27.696766		Teku
LONGITUDE: 85.305009, LATITUDE: 27.697032    
LONGITUDE: 85.304510, LATITUDE: 27.697308
LONGITUDE: 85.303963, LATITUDE: 27.697588
LONGITUDE: 85.303405, LATITUDE: 27.697849
LONGITUDE: 85.302268, LATITUDE: 27.698101
LONGITUDE: 85.301640, LATITUDE: 27.698239
LONGITUDE: 85.300390, LATITUDE: 27.698500
LONGITUDE: 85.299999, LATITUDE: 27.698576
LONGITUDE: 85.299763, LATITUDE: 27.698510
LONGITUDE: 85.299425, LATITUDE: 27.698410
LONGITUDE: 85.299076, LATITUDE: 27.698310
LONGITUDE: 85.298582, LATITUDE: 27.698168
LONGITUDE: 85.298159, LATITUDE: 27.698035
LONGITUDE: 85.297665, LATITUDE: 27.697864
LONGITUDE: 85.297354, LATITUDE: 27.697773
LONGITUDE: 85.296877, LATITUDE: 27.697640
LONGITUDE: 85.296367, LATITUDE: 27.697474
LONGITUDE: 85.295879, LATITUDE: 27.697360
LONGITUDE: 85.295514, LATITUDE: 27.697218
LONGITUDE: 85.295090, LATITUDE: 27.697104
LONGITUDE: 85.294473, LATITUDE: 27.696928
LONGITUDE: 85.293615, LATITUDE: 27.696648
LONGITUDE: 85.293269, LATITUDE: 27.696084		Soaltimoad
*/
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.305508, 27.696766 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));	
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.305009, 27.697032 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));  
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.304510, 27.697308 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.303963, 27.697588 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.303405, 27.697849 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.302268, 27.698101 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.301640, 27.698239 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.300390, 27.698500 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.299999, 27.698576 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.299763, 27.698510 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.299425, 27.698410 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.299076, 27.698310 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.298582, 27.698168 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.298159, 27.698035 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.297665, 27.697864 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.297354, 27.697773 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.296877, 27.697640 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.296367, 27.697474 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.295879, 27.697360 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.295514, 27.697218 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.295090, 27.697104 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.294473, 27.696928 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.293615, 27.696648 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.293269, 27.696084 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 2222') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));		




--Inserting to the vehicle location history for vehicle BA 50 PA 3333. From Teku to New Road Total 6 mins.
/*
LONGITUDE: 85.313566, LATITUDE: 27.701344	New Road
LONGITUDE: 85.313534, LATITUDE: 27.700888
LONGITUDE: 85.313507, LATITUDE: 27.700494
LONGITUDE: 85.313454, LATITUDE: 27.699620
LONGITUDE: 85.313432, LATITUDE: 27.699468
LONGITUDE: 85.313384, LATITUDE: 27.699212
LONGITUDE: 85.313384, LATITUDE: 27.698922
LONGITUDE: 85.313352, LATITUDE: 27.698528
LONGITUDE: 85.313314, LATITUDE: 27.698115
LONGITUDE: 85.313614, LATITUDE: 27.697502
LONGITUDE: 85.313722, LATITUDE: 27.697065
LONGITUDE: 85.313867, LATITUDE: 27.696105
LONGITUDE: 85.314065, LATITUDE: 27.694795
LONGITUDE: 85.314242, LATITUDE: 27.694039
LONGITUDE: 85.313582, LATITUDE: 27.693911
LONGITUDE: 85.312960, LATITUDE: 27.694049
LONGITUDE: 85.312247, LATITUDE: 27.694253
LONGITUDE: 85.311715, LATITUDE: 27.694472
LONGITUDE: 85.310922, LATITUDE: 27.694757
LONGITUDE: 85.310342, LATITUDE: 27.694951
LONGITUDE: 85.309790, LATITUDE: 27.695193
LONGITUDE: 85.309071, LATITUDE: 27.695478
LONGITUDE: 85.308373, LATITUDE: 27.695806
LONGITUDE: 85.307172, LATITUDE: 27.696196
LONGITUDE: 85.306190, LATITUDE: 27.696500	Teku Rastriya Banijya Bank
*/
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313566, 27.701344 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:06:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));	
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313534, 27.700888 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313507, 27.700494 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313454, 27.699620 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313432, 27.699468 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:05:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313384, 27.699212 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313384, 27.698922 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313352, 27.698528 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313314, 27.698115 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:04:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313614, 27.697502 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313722, 27.697065 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313867, 27.696105 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.314065, 27.694795 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:03:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.314242, 27.694039 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.313582, 27.693911 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.312960, 27.694049 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.312247, 27.694253 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:02:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.311715, 27.694472 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.310922, 27.694757 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.310342, 27.694951 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.309790, 27.695193 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:01:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.309071, 27.695478 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:45',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.308373, 27.695806 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:30',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.307172, 27.696196 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:15',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));
INSERT INTO locationHistory(location, time, session_id) VALUES ((SELECT ST_ClosestPoint(route_way, ST_Transform(ST_SetSRID(ST_MakePoint(85.306190, 27.696500 ), 4326),900913)) As way FROM ROUTE WHERE route_name ='Route 1'), '12:00:00',(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='BA 50 PA 3333') AND route_id=(SELECT route_id FROM route WHERE route_name='Route 1'))));	




--Web system User login information
--username = apple, password = ball
 INSERT INTO sylogin(username, password) VALUES ('apple','ehA/Gz8ocj83UAI/TT8/');
 
 
 
 
 
 
 