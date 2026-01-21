%let pgm=utl-altair-slc-computer-vision-calculate-size-of-slices-in-a-pie-chart-image-AI-python;

%stop_submission;

Altair slc computer vision calculate size of slices in a pie chart image AI python

HiRes Pie char tgat we will compute percents
https://github.com/rogerjdeangelis/utl-altair-slc-computer-vision-calculate-size-of-slices-in-a-pie-chart-image-AI-python/blob/main/pie3.png

Too long to post here, see github
https://github.com/rogerjdeangelis/utl-altair-slc-computer-vision-calculate-size-of-slices-in-a-pie-chart-image-AI-python

This has a many applications. Computer vison.

Given a high res pie image, d:/png/pie3.png, with
solid colors blue, green and red.
Calculate the percents for each pie slice.

              ***********
          ****           ****
        **                   **
      **          BLUE         **
     *            -----           *
   **             49              **
  **            49.49%             **
  *                                 *
 *                                   *
 *                                   *
 *                                   *
 *------------------+----------------*
 *    GREEN        /                 *
 *    -----       /   RED            *
 *      17       /    ---            *
  *   17.17%    /      33           *
  **           /     33.33%        **
    *         /                   *
     *       /                   *
      **    /                  **
        ** /                 **
          ****           ****
              ***********
OUTPUT                             IMAGE
         RGB         PIXEL         PIE         Cumulative    Cumulative
COLOR    COLORS      Frequency     Percent     Frequency      Percent
----------------------------------------------------------------------
BLUE     CX0000FF       54530       49.68         54530        49.68
GREEN    CX00FF00       18655       17.00         73185        66.68
RED      CXFF0000       36577       33.32        109762       100.00

/*                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
Pie chart with three slices and RGB colors Red, Green and Blue
*/

proc datasets lib=workx kill;
run;quit;

data workx.colors;
 do cnt=1 to 100;
  if cnt < 18 then do; color='green';  output; end;
  if cnt < 34 then do; color='red'  ;  output; end;
  if cnt < 50 then do; color='blue' ;  output; end;
 end;
run;quit;

/*
COLOR    Frequency     Percent
---------------------------------
blue           49       49.49
green          17       17.17
red            33       33.33
*/

filename grafout 'd:\png\pie3.png';
goptions reset=all
    gsfname=grafout
    gsfmode=replace
    device=png
    hsize=5in
    vsize=5in;

pattern1 value=solid color=CX0000FF;  * blue;
pattern2 value=solid color=CX00FF00;  * green;
pattern3 value=solid color=CXFF0000;  * red;

proc gchart data=workx.colors;
PIE color/ value=none

              noheading;
run;quit;
goptions reset=all;

filename grafout clear;


              ***********
          ****           ****
        **                   **
      **          BLUE         **
     *            -----           *
   **             49              **
  **            49.49%             **
  *                                 *
 *                                   *
 *                                   *
 *                                   *
 *------------------+----------------*
 *    GREEN        /                 *
 *    -----       /   RED            *
 *      17       /    ---            *
  *   17.17%    /      33           *
  **           /     33.33%        **
    *         /                   *
     *       /                   *
      **    /                  **
        ** /                 **
          ****           ****
              ***********
*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

proc datasets lib=workx kill;
run;quit;

options set=PYTHONHOME "D:\py314";
proc python;
submit;
import pyreadstat
from PIL import Image
import pandas as pd
import numpy
img = Image.open("d:png\\pie3.png")
im_rgb = img.convert("RGB")
colors = im_rgb.getcolors(maxcolors=200000)
print(len(colors))
colors = sorted(colors, key = lambda x:-x[0])
print(im_rgb)
s = pd.Series(data=colors[0:30])
df = s.to_frame(name='colors')
print(df)
endsubmit;
import data=workx.colors python=df;
run;quit;

/*--- OUTPUT FROM PYTHON
Altair SLC
LIST: 10:50:09

Altair SLC

The PYTHON Procedure

<PIL.Image.Image image mode=RGB size=800x600 at 0x170D2E4E900>

                       colors
0   (366159, (255, 255, 255))
1        (54530, (0, 0, 255))
2        (36577, (255, 0, 0))
3        (18655, (0, 255, 0))
4          (197, (0, 0, 127))
5          (194, (127, 0, 0))
6             (43, (0, 0, 0))
7       (37, (253, 253, 253))
8       (31, (251, 251, 251))
9          (29, (23, 23, 23))
10      (28, (252, 252, 252))
11      (21, (136, 136, 136))
12         (19, (63, 63, 63))
13         (18, (35, 35, 35))
14          (18, (0, 0, 119))
15      (17, (250, 250, 250))
16          (16, (0, 0, 136))
17         (16, (24, 24, 24))
18      (15, (187, 187, 187))
19         (15, (19, 19, 19))
20         (15, (25, 25, 25))
21           (15, (20, 0, 0))
22      (14, (243, 243, 243))
23      (14, (127, 127, 127))
24      (14, (254, 254, 254))
25      (14, (170, 170, 170))
26         (14, (34, 34, 34))
27         (14, (93, 93, 93))
28         (14, (20, 20, 20))
29      (13, (219, 219, 219))
---*/

/*--- map the colors to sas code ---*/
proc format;
  value $code2color
    'CX0000FF' =  'BLUE '
    'CX00FF00' =  'GREEN'
    'CXFF0000' =  'RED  '
    'CXFFFFFF' =  'WHITE'
    other      =  'OTHER'
;
run;


data workx.want;

 set workx.colors;

 /*--  SAMPLE INPUT          --*/
 /*--   PIXELS  R  G   B     --*/
 /*--  (54530, (0, 0, 255))  --*/
 /*--  CX       00 00  FF    --*/
 /*--  CX0000FF =  BLUE      --*/

 colors=compress(colors,'(),')  ;
 count=input(scan(colors,1),8.) ;

 Rc=scan(colors,2) ;
 Gc=scan(colors,3) ;
 Bc=scan(colors,4) ;

 R=put(inputn(rc,4.),hex2.) ;
 G=put(inputn(gc,4.),hex2.) ;
 B=put(inputn(bc,4.),hex2.) ;

 colors=cats('CX',r,g,b);

 color=put(colors,$code2color.);

 if color in ('BLUE','GREEN','RED') then output;

 keep color colors count;

run;quit;

proc freq data=workx.want;

 table color*colors / list;
 weight count;

run;

/*-- OUPTUT FROM SAS

         RGB         PIXEL         PIE         Cumulative    Cumulative
COLOR    COLORS      Frequency     Percent     Frequency      Percent
----------------------------------------------------------------------
BLUE     CX0000FF       54530       49.68         54530        49.68
GREEN    CX00FF00       18655       17.00         73185        66.68
RED      CXFF0000       36577       33.32        109762       100.00
--*/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC     11:46 Wednesday, January 21, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"
NOTE: Library workx assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: d:\wpswrkx

NOTE: Library slchelp assigned as follows:
      Engine:        WPD
      Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp


LOG:  11:46:43
NOTE: 1 record was written to file PRINT

NOTE: The data step took :
      real time : 0.015
      cpu time  : 0.000


NOTE: AUTOEXEC processing completed


Altair SLC

The DATASETS Procedure

         Directory

Libref           WORKX
Engine           SAS7BDAT
Physical Name    d:\wpswrkx

                              Members

            Member    Member
  Number    Name      Type         File Size      Date Last Modified

--------------------------------------------------------------------

       1    COLORS    DATA              5120      21JAN2026:11:43:35
       2    WANT      DATA            131072      21JAN2026:11:45:12
1
2         proc datasets lib=workx kill;
3         run;quit;
NOTE: Deleting WORKX.colors (type=DATA)
NOTE: Deleting WORKX.want (type=DATA)
NOTE: Procedure datasets step took :
      real time : 0.031
      cpu time  : 0.000


4
5         options set=PYTHONHOME "D:\py314";
6         proc python;
7         submit;
8         import pyreadstat
9         from PIL import Image
10        import pandas as pd
11        import numpy
12        img = Image.open("d:png\\pie3.png")
13        im_rgb = img.convert("RGB")
14        colors = im_rgb.getcolors(maxcolors=200000)
15        print(len(colors))
16        colors = sorted(colors, key = lambda x:-x[0])
17        print(im_rgb)
18        s = pd.Series(data=colors[0:30])
19        df = s.to_frame(name='colors')
20        print(df)
21        endsubmit;

NOTE: Submitting statements to Python:


22        import data=workx.colors python=df;
NOTE: Creating data set 'WORKX.colors' from Python data frame 'df'

2                                                                                                                         Altair SLC

NOTE: Data set "WORKX.colors" has 30 observation(s) and 1 variable(s)

23        run;quit;
NOTE: Procedure python step took :
      real time : 0.949
      cpu time  : 0.015


24
25        /*--- OUTPUT FROM PYTHON
26        Altair SLC
27        LIST: 10:50:09
28
29        Altair SLC
30
31        The PYTHON Procedure
32
33        <PIL.Image.Image image mode=RGB size=800x600 at 0x170D2E4E900>
34
35                               colors
36        0   (366159, (255, 255, 255))
37        1        (54530, (0, 0, 255))
38        2        (36577, (255, 0, 0))
39        3        (18655, (0, 255, 0))
40        4          (197, (0, 0, 127))
41        5          (194, (127, 0, 0))
42        6             (43, (0, 0, 0))
43        7       (37, (253, 253, 253))
44        8       (31, (251, 251, 251))
45        9          (29, (23, 23, 23))
46        10      (28, (252, 252, 252))
47        11      (21, (136, 136, 136))
48        12         (19, (63, 63, 63))
49        13         (18, (35, 35, 35))
50        14          (18, (0, 0, 119))
51        15      (17, (250, 250, 250))
52        16          (16, (0, 0, 136))
53        17         (16, (24, 24, 24))
54        18      (15, (187, 187, 187))
55        19         (15, (19, 19, 19))
56        20         (15, (25, 25, 25))
57        21           (15, (20, 0, 0))
58        22      (14, (243, 243, 243))
59        23      (14, (127, 127, 127))
60        24      (14, (254, 254, 254))
61        25      (14, (170, 170, 170))
62        26         (14, (34, 34, 34))
63        27         (14, (93, 93, 93))
64        28         (14, (20, 20, 20))
65        29      (13, (219, 219, 219))
66        ---*/
67
68        /*--- map the colors to sas code ---*/
69        proc format;
70          value $code2color
71            'CX0000FF' =  'BLUE '
72            'CX00FF00' =  'GREEN'
73            'CXFF0000' =  'RED  '
74            'CXFFFFFF' =  'WHITE'
75            other      =  'OTHER'
76        ;
NOTE: Format $code2color output
77        run;

3                                                                                                                         Altair SLC

NOTE: Procedure format step took :
      real time : 0.000
      cpu time  : 0.000


78
79
80        data workx.want;
81
82         set workx.colors;
83
84         /*--  SAMPLE INPUT          --*/
85         /*--   PIXELS  R  G   B     --*/
86         /*--  (54530, (0, 0, 255))  --*/
87         /*--  CX       00 00  FF    --*/
88         /*--  CX0000FF =  BLUE      --*/
89
90         colors=compress(colors,'(),')  ;
91         count=input(scan(colors,1),8.) ;
92
93         Rc=scan(colors,2) ;
94         Gc=scan(colors,3) ;
95         Bc=scan(colors,4) ;
96
97         R=put(inputn(rc,4.),hex2.) ;
98         G=put(inputn(gc,4.),hex2.) ;
99         B=put(inputn(bc,4.),hex2.) ;
100
101        colors=cats('CX',r,g,b);
102
103        color=put(colors,$code2color.);
104
105        if color in ('BLUE','GREEN','RED') then output;
106
107        keep color colors count;
108
109       run;

NOTE: Numeric values have been converted to character values at the places given by: (Line):(Column)
      97:18   98:18   99:18
NOTE: 30 observations were read from "WORKX.colors"
NOTE: Data set "WORKX.want" has 3 observation(s) and 3 variable(s)
NOTE: The data step took :
      real time : 0.031
      cpu time  : 0.000


109     !     quit;
110
111       proc freq data=workx.want;
112
113        table color*colors / list;
114        weight count;
115
116       run;
NOTE: 3 observations were read from "WORKX.want"
NOTE: Procedure freq step took :
      real time : 0.015
      cpu time  : 0.000


117
118       /*-- OUPTUT FROM SAS

4                                                                                                                         Altair SLC

119
120                RGB         PIXEL         PIE         Cumulative    Cumulative
121       COLOR    COLORS      Frequency     Percent     Frequency      Percent
122       ----------------------------------------------------------------------
123       BLUE     CX0000FF       54530       49.68         54530        49.68
124       GREEN    CX00FF00       18655       17.00         73185        66.68
125       RED      CXFF0000       36577       33.32        109762       100.00
126       --*/
ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 1.099
      cpu time  : 0.109

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
