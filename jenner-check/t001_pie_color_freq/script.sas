/* Pie-slice color analysis from
   utl-altair-slc-computer-vision-calculate-size-of-slices-in-a-pie-chart-image-AI-python.sas

   The original reads pie3.png with PROC PYTHON (PIL getcolors) on a Windows
   path (d:\png\pie3.png) and imports the top-30 (pixel_count, (R,G,B)) tuples
   into WORK.COLORS. Those exact tuples are documented in the source (the
   "OUTPUT FROM PYTHON" listing), so this bundle seeds WORK.COLORS from that
   captured list and then runs the original color-mapping + PROC FREQ logic
   unchanged. The pixel frequencies below match the result recorded in the
   repo: BLUE 54530, GREEN 18655, RED 36577. */

data work.colors;
  length colors $40;
  input colors $40. ;
datalines;
(366159, (255, 255, 255))
(54530, (0, 0, 255))
(36577, (255, 0, 0))
(18655, (0, 255, 0))
(197, (0, 0, 127))
(194, (127, 0, 0))
(43, (0, 0, 0))
(37, (253, 253, 253))
(31, (251, 251, 251))
(29, (23, 23, 23))
(28, (252, 252, 252))
(21, (136, 136, 136))
(19, (63, 63, 63))
(18, (35, 35, 35))
(18, (0, 0, 119))
(17, (250, 250, 250))
(16, (0, 0, 136))
(16, (24, 24, 24))
(15, (187, 187, 187))
(15, (19, 19, 19))
(15, (25, 25, 25))
(15, (20, 0, 0))
(14, (243, 243, 243))
(14, (127, 127, 127))
(14, (254, 254, 254))
(14, (170, 170, 170))
(14, (34, 34, 34))
(14, (93, 93, 93))
(14, (20, 20, 20))
(13, (219, 219, 219))
;
run;

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

data work.want;

 set work.colors;

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

proc freq data=work.want;
 table color*colors / list;
 weight count;
run;
