#!perl
use strict;
use warnings;

use Test::More;
use Test::Number::Delta relative => 1E-10;

BEGIN {
    use_ok('Time::Moment');
}

{
    my @tests = (
        [ '0001-01-01T00:00:00Z',     1721425.5          ],
        [ '0001-01-01T00:00:00.001Z', 1721425.5000000116 ],
        [ '0001-01-01T00:00:00.002Z', 1721425.5000000233 ],
        [ '0001-01-01T00:00:00.010Z', 1721425.5000001157 ],
        [ '0001-01-01T00:00:00.020Z', 1721425.5000002314 ],
        [ '0001-01-01T00:00:00.100Z', 1721425.5000011574 ],
        [ '0001-01-01T00:00:00.200Z', 1721425.5000023148 ],
        [ '0001-01-01T00:00:00.300Z', 1721425.5000034722 ],
        [ '0001-01-01T00:00:00.400Z', 1721425.5000046296 ],
        [ '0001-01-01T00:00:00.490Z', 1721425.5000056713 ],
        [ '0001-01-01T00:00:00.499Z', 1721425.5000057756 ],
        [ '0001-01-01T00:00:00.500Z', 1721425.500005787  ],
        [ '0001-01-01T00:00:00.501Z', 1721425.5000057986 ],
        [ '0001-01-01T00:00:00.510Z', 1721425.5000059027 ],
        [ '0001-01-01T00:00:00.600Z', 1721425.5000069444 ],
        [ '0001-01-01T00:00:00.700Z', 1721425.5000081018 ],
        [ '0001-01-01T00:00:00.800Z', 1721425.5000092592 ],
        [ '0001-01-01T00:00:00.900Z', 1721425.5000104166 ],
        [ '0001-01-01T00:00:00.980Z', 1721425.5000113426 ],
        [ '0001-01-01T00:00:00.990Z', 1721425.5000114583 ],
        [ '0001-01-01T00:00:00.998Z', 1721425.500011551  ],
        [ '0001-01-01T00:00:00.999Z', 1721425.5000115624 ],
        [ '0001-01-01T00:00:01Z',     1721425.500011574  ],
        [ '0001-01-01T00:00:01.001Z', 1721425.5000115857 ],
        [ '0001-01-01T00:00:01.002Z', 1721425.5000115973 ],
        [ '0001-01-01T00:00:01.010Z', 1721425.50001169   ],
        [ '0001-01-01T00:00:01.020Z', 1721425.5000118054 ],
        [ '0001-01-01T00:00:01.100Z', 1721425.5000127316 ],
        [ '0001-01-01T00:00:01.200Z', 1721425.5000138888 ],
        [ '1899-12-31T00:00:00Z',     2415019.5          ],
        [ '1900-01-01T00:00:00Z',     2415020.5          ],
        [ '1900-02-27T00:00:00Z',     2415077.5          ],
        [ '1900-02-28T00:00:00Z',     2415078.5          ],
        [ '1900-03-01T00:00:00Z',     2415079.5          ],
        [ '1900-03-02T00:00:00Z',     2415080.5          ],
        [ '1969-12-31T23:59:58Z',     2440587.499976852  ],
        [ '1969-12-31T23:59:58.500Z', 2440587.4999826388 ],
        [ '1969-12-31T23:59:58.800Z', 2440587.4999861112 ],
        [ '1969-12-31T23:59:58.900Z', 2440587.4999872684 ],
        [ '1969-12-31T23:59:58.980Z', 2440587.4999881946 ],
        [ '1969-12-31T23:59:58.990Z', 2440587.49998831   ],
        [ '1969-12-31T23:59:58.998Z', 2440587.4999884027 ],
        [ '1969-12-31T23:59:58.999Z', 2440587.4999884143 ],
        [ '1969-12-31T23:59:59Z',     2440587.499988426  ],
        [ '1969-12-31T23:59:59.001Z', 2440587.4999884376 ],
        [ '1969-12-31T23:59:59.002Z', 2440587.4999884493 ],
        [ '1969-12-31T23:59:59.010Z', 2440587.4999885415 ],
        [ '1969-12-31T23:59:59.020Z', 2440587.4999886574 ],
        [ '1969-12-31T23:59:59.100Z', 2440587.4999895832 ],
        [ '1969-12-31T23:59:59.200Z', 2440587.4999907408 ],
        [ '1969-12-31T23:59:59.300Z', 2440587.499991898  ],
        [ '1969-12-31T23:59:59.400Z', 2440587.4999930556 ],
        [ '1969-12-31T23:59:59.490Z', 2440587.4999940973 ],
        [ '1969-12-31T23:59:59.499Z', 2440587.4999942016 ],
        [ '1969-12-31T23:59:59.500Z', 2440587.4999942128 ],
        [ '1969-12-31T23:59:59.501Z', 2440587.4999942244 ],
        [ '1969-12-31T23:59:59.510Z', 2440587.4999943287 ],
        [ '1969-12-31T23:59:59.600Z', 2440587.4999953704 ],
        [ '1969-12-31T23:59:59.700Z', 2440587.4999965276 ],
        [ '1969-12-31T23:59:59.800Z', 2440587.4999976852 ],
        [ '1969-12-31T23:59:59.900Z', 2440587.4999988424 ],
        [ '1969-12-31T23:59:59.980Z', 2440587.4999997686 ],
        [ '1969-12-31T23:59:59.990Z', 2440587.4999998841 ],
        [ '1969-12-31T23:59:59.998Z', 2440587.4999999767 ],
        [ '1969-12-31T23:59:59.999Z', 2440587.4999999884 ],
        [ '1970-01-01T00:00:00Z',     2440587.5          ],
        [ '1970-01-01T00:00:00.001Z', 2440587.5000000116 ],
        [ '1970-01-01T00:00:00.002Z', 2440587.5000000233 ],
        [ '1970-01-01T00:00:00.010Z', 2440587.5000001159 ],
        [ '1970-01-01T00:00:00.020Z', 2440587.5000002314 ],
        [ '1970-01-01T00:00:00.100Z', 2440587.5000011576 ],
        [ '1970-01-01T00:00:00.200Z', 2440587.5000023148 ],
        [ '1970-01-01T00:00:00.300Z', 2440587.5000034724 ],
        [ '1970-01-01T00:00:00.400Z', 2440587.5000046296 ],
        [ '1970-01-01T00:00:00.490Z', 2440587.5000056713 ],
        [ '1970-01-01T00:00:00.499Z', 2440587.5000057756 ],
        [ '1970-01-01T00:00:00.500Z', 2440587.5000057872 ],
        [ '1970-01-01T00:00:00.501Z', 2440587.5000057984 ],
        [ '1970-01-01T00:00:00.510Z', 2440587.5000059027 ],
        [ '1970-01-01T00:00:00.600Z', 2440587.5000069444 ],
        [ '1970-01-01T00:00:00.700Z', 2440587.500008102  ],
        [ '1970-01-01T00:00:00.800Z', 2440587.5000092592 ],
        [ '1970-01-01T00:00:00.900Z', 2440587.5000104168 ],
        [ '1970-01-01T00:00:00.980Z', 2440587.5000113426 ],
        [ '1970-01-01T00:00:00.990Z', 2440587.5000114585 ],
        [ '1970-01-01T00:00:00.998Z', 2440587.5000115507 ],
        [ '1970-01-01T00:00:00.999Z', 2440587.5000115624 ],
        [ '1970-01-01T00:00:01Z',     2440587.500011574  ],
        [ '1970-01-01T00:00:01.001Z', 2440587.5000115857 ],
        [ '1970-01-01T00:00:01.002Z', 2440587.5000115973 ],
        [ '1970-01-01T00:00:01.010Z', 2440587.50001169   ],
        [ '1970-01-01T00:00:01.020Z', 2440587.5000118054 ],
        [ '1970-01-01T00:00:01.100Z', 2440587.5000127316 ],
        [ '1970-01-01T00:00:01.200Z', 2440587.5000138888 ],
        [ '1982-08-25T00:15:20.213Z', 2445206.5106506133 ],
        [ '2065-04-19T00:16:48.290Z', 2475394.5116700232 ],
        [ '2147-12-15T00:55:25.446Z', 2505583.5384889585 ],
        [ '2230-08-10T01:02:46.891Z', 2535771.5435982756 ],
        [ '2313-04-06T01:04:15.597Z', 2565960.5446249652 ],
        [ '2395-11-30T01:09:40.889Z', 2596148.5483899191 ],
        [ '2478-07-25T01:11:32.560Z', 2626336.5496824076 ],
        [ '2561-03-21T01:30:19.169Z', 2656525.5627218634 ],
        [ '2643-11-15T01:48:25.580Z', 2686713.5752960648 ],
        [ '2726-07-12T02:03:31.919Z', 2716902.5857860995 ],
        [ '2809-03-06T02:11:11.986Z', 2747090.5911109489 ],
        [ '2891-10-31T02:24:37.095Z', 2777279.6004293403 ],
        [ '2974-06-26T02:35:07.220Z', 2807467.6077224538 ],
        [ '3057-02-19T02:45:12.109Z', 2837655.614723484  ],
        [ '3139-10-17T03:06:39.990Z', 2867844.6296295137 ],
        [ '3222-06-11T03:08:08.251Z', 2898032.630651053  ],
        [ '3305-02-05T03:19:12.576Z', 2928221.6383400001 ],
        [ '3387-10-01T03:29:42.574Z', 2958409.6456316435 ],
        [ '3470-05-27T03:37:30.813Z', 2988597.6510510761 ],
        [ '3553-01-21T04:14:38.231Z', 3018786.6768313772 ],
        [ '3635-09-16T04:16:28.559Z', 3048974.6781083215 ],
        [ '3718-05-13T04:17:58.222Z', 3079163.6791460877 ],
        [ '3801-01-06T04:21:41.794Z', 3109351.681733727  ],
        [ '3883-09-02T04:56:35.792Z', 3139540.7059698147 ],
        [ '3966-04-28T05:25:14.885Z', 3169728.7258667247 ],
        [ '4048-12-21T05:26:05.724Z', 3199916.726455139  ],
        [ '4131-08-18T05:46:44.068Z', 3230105.7407878242 ],
        [ '4214-04-13T05:48:01.141Z', 3260293.7416798729 ],
        [ '4296-12-07T05:53:52.315Z', 3290482.7457443867 ],
        [ '4379-08-03T06:14:48.580Z', 3320670.7602844909 ],
        [ '4462-03-28T06:46:15.738Z', 3350858.7821265971 ],
        [ '4544-11-22T07:31:20.407Z', 3381047.8134306367 ],
        [ '4627-07-19T07:58:33.754Z', 3411235.8323351159 ],
        [ '4710-03-15T08:07:43.130Z', 3441424.8386936341 ],
        [ '4792-11-07T08:29:11.091Z', 3471612.8536005905 ],
        [ '4875-07-04T09:08:15.328Z', 3501801.8807329629 ],
        [ '4958-02-27T09:30:41.781Z', 3531989.8963169097 ],
        [ '5040-10-23T09:34:04.462Z', 3562177.8986627543 ],
        [ '5123-06-20T09:37:23.945Z', 3592366.9009715859 ],
        [ '5206-02-12T09:37:56.655Z', 3622554.9013501736 ],
        [ '5288-10-08T09:45:12.230Z', 3652743.9063915508 ],
        [ '5371-06-04T09:54:14.782Z', 3682931.9126710882 ],
        [ '5454-01-28T09:54:22.108Z', 3713119.9127558796 ],
        [ '5536-09-24T10:01:36.151Z', 3743308.9177795257 ],
        [ '5619-05-20T12:09:48.602Z', 3773497.0068125231 ],
        [ '5702-01-14T12:34:08.549Z', 3803686.0237100581 ],
        [ '5784-09-08T12:56:06.495Z', 3833874.0389640625 ],
        [ '5867-05-06T12:58:58.217Z', 3864063.0409515854 ],
        [ '5949-12-30T12:59:54.263Z', 3894251.0416002665 ],
        [ '6032-08-24T13:34:41.331Z', 3924439.0657561459 ],
        [ '6115-04-21T13:58:28.601Z', 3954628.0822754744 ],
        [ '6197-12-14T14:02:16.899Z', 3984816.0849178126 ],
        [ '6280-08-10T14:36:17.444Z', 4015005.1085352316 ],
        [ '6363-04-06T14:37:57.451Z', 4045193.1096927198 ],
        [ '6445-11-30T14:57:42.757Z', 4075382.123411539  ],
        [ '6528-07-26T15:10:48.307Z', 4105570.1325035533 ],
        [ '6611-03-22T15:14:39.890Z', 4135758.1351839118 ],
        [ '6693-11-15T15:19:47.988Z', 4165947.1387498612 ],
        [ '6776-07-11T16:04:24.344Z', 4196135.1697262041 ],
        [ '6859-03-07T16:22:23.952Z', 4226324.1822216669 ],
        [ '6941-10-31T16:29:55.999Z', 4256512.1874536918 ],
        [ '7024-06-26T16:58:20.259Z', 4286700.2071789233 ],
        [ '7107-02-21T17:04:02.415Z', 4316889.2111390624 ],
        [ '7189-10-16T17:18:29.630Z', 4347077.2211762732 ],
        [ '7272-06-11T17:47:21.323Z', 4377266.2412190158 ],
        [ '7355-02-05T17:53:29.866Z', 4407454.2454845607 ],
        [ '7437-10-02T17:53:41.076Z', 4437643.2456143051 ],
        [ '7520-05-28T17:55:06.044Z', 4467831.2465977315 ],
        [ '7603-01-21T18:14:49.151Z', 4498019.2602910995 ],
        [ '7685-09-16T18:17:45.738Z', 4528208.2623349307 ],
        [ '7768-05-12T18:29:59.700Z', 4558396.2708298611 ],
        [ '7851-01-07T18:33:21.233Z', 4588585.273162419  ],
        [ '7933-09-02T19:14:24.673Z', 4618773.3016744554 ],
        [ '8016-04-27T19:17:12.816Z', 4648961.3036205554 ],
        [ '8098-12-22T19:23:36.418Z', 4679150.3080603937 ],
        [ '8181-08-17T19:46:25.908Z', 4709338.3239109721 ],
        [ '8264-04-13T20:07:47.314Z', 4739527.3387420606 ],
        [ '8346-12-08T20:31:37.603Z', 4769715.3552963305 ],
        [ '8429-08-03T20:39:57.770Z', 4799904.3610853013 ],
        [ '8512-03-29T20:50:17.067Z', 4830092.3682530904 ],
        [ '8594-11-22T21:02:57.827Z', 4860280.3770581828 ],
        [ '8677-07-19T21:23:05.519Z', 4890469.3910360998 ],
        [ '8760-03-14T21:34:49.572Z', 4920657.3991848612 ],
        [ '8842-11-08T21:39:05.944Z', 4950846.4021521294 ],
        [ '8925-07-04T21:39:18.426Z', 4981034.4022965971 ],
        [ '9008-02-28T21:46:07.769Z', 5011222.4070343636 ],
        [ '9090-10-24T21:57:55.662Z', 5041411.4152275696 ],
        [ '9173-06-19T22:19:11.732Z', 5071599.4299968984 ],
        [ '9256-02-13T22:23:51.376Z', 5101788.4332335182 ],
        [ '9338-10-09T22:27:58.771Z', 5131976.4360968862 ],
        [ '9421-06-05T22:43:30.392Z', 5162165.4468795368 ],
        [ '9504-01-30T22:48:25.834Z', 5192353.4502990041 ],
        [ '9586-09-24T22:53:51.727Z', 5222541.4540709145 ],
        [ '9669-05-20T23:12:56.536Z', 5252730.4673210187 ],
        [ '9752-01-14T23:15:54.109Z', 5282918.4693762613 ],
        [ '9834-09-10T23:17:12.632Z', 5313107.4702850925 ],
        [ '9999-12-31T23:59:58Z',     5373484.499976852  ],
        [ '9999-12-31T23:59:58.500Z', 5373484.4999826383 ],
        [ '9999-12-31T23:59:58.800Z', 5373484.4999861112 ],
        [ '9999-12-31T23:59:58.900Z', 5373484.4999872688 ],
        [ '9999-12-31T23:59:58.980Z', 5373484.4999881946 ],
        [ '9999-12-31T23:59:58.990Z', 5373484.49998831   ],
        [ '9999-12-31T23:59:58.998Z', 5373484.4999884032 ],
        [ '9999-12-31T23:59:58.999Z', 5373484.4999884143 ],
        [ '9999-12-31T23:59:59Z',     5373484.4999884255 ],
        [ '9999-12-31T23:59:59.001Z', 5373484.4999884376 ],
        [ '9999-12-31T23:59:59.002Z', 5373484.4999884497 ],
        [ '9999-12-31T23:59:59.010Z', 5373484.499988541  ],
        [ '9999-12-31T23:59:59.020Z', 5373484.4999886574 ],
        [ '9999-12-31T23:59:59.100Z', 5373484.4999895832 ],
        [ '9999-12-31T23:59:59.200Z', 5373484.4999907408 ],
        [ '9999-12-31T23:59:59.300Z', 5373484.4999918975 ],
        [ '9999-12-31T23:59:59.400Z', 5373484.4999930561 ],
        [ '9999-12-31T23:59:59.490Z', 5373484.4999940973 ],
        [ '9999-12-31T23:59:59.499Z', 5373484.4999942016 ],
        [ '9999-12-31T23:59:59.500Z', 5373484.4999942128 ],
        [ '9999-12-31T23:59:59.501Z', 5373484.4999942239 ],
        [ '9999-12-31T23:59:59.510Z', 5373484.4999943282 ],
        [ '9999-12-31T23:59:59.600Z', 5373484.4999953704 ],
        [ '9999-12-31T23:59:59.700Z', 5373484.499996528  ],
        [ '9999-12-31T23:59:59.800Z', 5373484.4999976847 ],
        [ '9999-12-31T23:59:59.900Z', 5373484.4999988424 ],
        [ '9999-12-31T23:59:59.980Z', 5373484.499999769  ],
        [ '9999-12-31T23:59:59.990Z', 5373484.4999998845 ],
        [ '9999-12-31T23:59:59.998Z', 5373484.4999999767 ],
        [ '9999-12-31T23:59:59.999Z', 5373484.4999999888 ],
    );

    foreach my $test (@tests) {
        my ($string, $jd) = @$test;
    
        my $tm = Time::Moment->from_jd($jd);
        is($tm->to_string, $string, "Time::Moment->from_jd($jd)");
        delta_ok($tm->jd, $jd, "$tm->jd"); 
    }
}

{
    my $tm = Time::Moment->from_jd(0, epoch => 719163);
    is($tm->to_string, '1970-01-01T00:00:00Z');
}

{
    my $tm = Time::Moment->from_jd(0, epoch => 719163);
    is($tm->to_string, '1970-01-01T00:00:00Z');
}

{
    my $tm = Time::Moment->from_jd(0.000001428888889, epoch => 719163, precision => 6);
    is($tm->to_string, '1970-01-01T00:00:00.123456Z');
}

done_testing();