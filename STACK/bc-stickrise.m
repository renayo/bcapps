(* formulas start here *)

conds = {-Pi/2<dec<Pi/2, -Pi/2<lat<Pi/2, -Pi<ha<Pi};

az[ha_, dec_, lat_] = ArcTan[Cos[lat]*Sin[dec] - Cos[dec]*Cos[ha]*Sin[lat], 
    -(Cos[dec]*Sin[ha])]

el[ha_, dec_, lat_] = ArcTan[Sqrt[Cos[dec]^2*Sin[ha]^2 + 
      (Cos[lat]*Sin[dec] - Cos[dec]*Cos[ha]*Sin[lat])^2], 
    Cos[dec]*Cos[ha]*Cos[lat] + Sin[dec]*Sin[lat]]

cleanup = {ha -> omega, dec -> delta, lat -> phi}

ha2ha[h_] = h/12*Pi-Pi

azh[h_,dec_,lat_] = az[ha2ha[h],dec,lat]
elh[h_,dec_,lat_] = el[ha2ha[h],dec,lat]

r[h_, dec_, lat_]=Sqrt[(Cos[lat]*Sin[dec] + Cos[dec]*Cos[(h*Pi)/12]*Sin[lat])^
       2 + Cos[dec]^2*Sin[(h*Pi)/12]^2]/(-(Cos[dec]*Cos[lat]*Cos[(h*Pi)/12]) + 
     Sin[dec]*Sin[lat])

theta[h_, dec_, lat_] = (3*Pi)/2 - ArcTan[Cos[lat]*Sin[dec] + 
      Cos[dec]*Cos[(h*Pi)/12]*Sin[lat], Cos[dec]*Sin[(h*Pi)/12]]

x[h_, dec_, lat_] = (Cos[lat]*Cot[(h*Pi)/12] - Csc[(h*Pi)/12]*Sin[lat]*
      Tan[dec])^(-1)

y[h_, dec_, lat_] = (Cos[lat] + Cos[(h*Pi)/12]*Cot[dec]*Sin[lat])/
    (Cos[lat]*Cos[(h*Pi)/12]*Cot[dec] - Sin[lat])

dx[h_, dec_, lat_] = (Pi*Csc[(h*Pi)/12]*(Cos[lat]*Csc[(h*Pi)/12] - 
      Cot[(h*Pi)/12]*Sin[lat]*Tan[dec]))/
    (12*(Cos[lat]*Cot[(h*Pi)/12] - Csc[(h*Pi)/12]*Sin[lat]*Tan[dec])^2)

dy[h_, dec_, lat_] = (Pi*Cot[dec]*Sin[(h*Pi)/12])/
    (12*(-(Cos[lat]*Cos[(h*Pi)/12]*Cot[dec]) + Sin[lat])^2)

ds[h_, dec_, lat_] = 
   (Pi*Sqrt[(Cot[dec]^2*((Cos[lat]*Cot[dec] - Cos[(h*Pi)/12]*Sin[lat])^2 + 
         Sin[(h*Pi)/12]^2))/(-(Cos[lat]*Cos[(h*Pi)/12]*Cot[dec]) + Sin[lat])^
        4])/12

rplot[h_,dec_,lat_] := Max[0, r[h,dec,lat]]
xplot[h_,dec_,lat_] := rplot[h,dec,lat]*Cos[theta[h,dec,lat]]
yplot[h_,dec_,lat_] := rplot[h,dec,lat]*Sin[theta[h,dec,lat]]

(* formulas end here *)

dx[h_,dec_,lat_] = FullSimplify[D[x[h,dec,lat],h], conds]
dy[h_,dec_,lat_] = FullSimplify[D[y[h,dec,lat],h], conds]

ds[h_,dec_,lat_] = FullSimplify[Sqrt[dx[h,dec,lat]^2 + dy[h,dec,lat]^2], conds]


https://en.wikipedia.org/wiki/Visual_acuity#Motion_acuity

0.0275 rad/s

0.003 radian/sec (0.171887 deg/sec or 10.3'/sec)

(at a dist of 1m, that would be 3mm/s)

0.0087 rad/s

http://jov.arvojournals.org/article.aspx?articleid=2122525

looming threshold

http://journals.sagepub.com/doi/abs/10.1177/1071181312561146

below is at summer solstice noon diff lats

Plot[ds[0,23.5*Degree,lat],{lat,30*Degree,50*Degree}]

about 0.4 to 0.9 (meters per hour if stick is 1m)

111-250 micrometers per second

lower number is 247 times too slow to see (at 1m)

Maximize[{ds[h,dec,lat], el[h,dec,lat]>15*Degree}, h]

Solve[elh[h,dec,lat] == 15*Degree, h]

Solve[elh[h,23.5*Degree,40*Degree] == 15*Degree, h]

TODO: near sigtedness

Plot[elh[h,23.5*Degree,40*Degree]/Degree, {h,12,20}]

h -> 17.9864

ds[17.9864, 23.5*Degree,40*Degree]

2.898 per hour

805 micrometers per second

FindRoot[elh[h,23.5*Degree,40*Degree] == 15*Degree,{h,18}]
h -> 17.9864

FindRoot[elh[h,0*Degree,40*Degree] == 15*Degree,{h,18}]
h -> 16.6835

ds[16.6835, 0*Degree, 40*Degree]
2.99365

FindRoot[elh[h,-23.5*Degree,40*Degree] == 15*Degree,{h,18}]
h -> 14.8559

ds[14.8559,-23.5*Degree,40*Degree]
2.08454

Plot3D[ds[12,dec*Degree,lat*Degree],{dec,-23.5,+23.5}, {lat,30,50}]

Plot3D[ds[15,dec*Degree,lat*Degree],{dec,-23.5,+23.5}, {lat,30,50}]








x[h_,dec_,lat_] = FullSimplify[r[h,dec,lat]*Cos[theta[h,dec,lat]], conds]

y[h_,dec_,lat_] = FullSimplify[r[h,dec,lat]*Sin[theta[h,dec,lat]], conds]

r[h_,dec_,lat_] = FullSimplify[Cot[elh[h,dec,lat]], conds]

theta[h,dec,lat] = FullSimplify[3*Pi/2-azh[h,dec,lat],conds]

https://www.e-education.psu.edu/eme810/node/575

(*

http://astronomy.stackexchange.com/questions/19619/how-to-make-motion-of-the-sun-more-apparent-at-seconds-scale

TODO: SUMMARY ANSWER HERE

TODO: 15 deg cutoff 3.73205

We know (see references section) the Sun's azimuth and elevation at any given time is:

$
   \text{azimuth}=\tan ^{-1}(\sin (\delta ) \cos (\phi )-\cos (\delta ) \cos 
    (\omega ) \sin (\phi ),-\cos (\delta ) \sin (\omega ))
$
$
\text{elevation}=\tan ^{-1}\left(\sqrt{(\sin (\delta ) \cos (\phi )-\cos 
    (\delta ) \cos (\omega ) \sin (\phi ))^2+\cos ^2(\delta ) \sin ^2(\omega 
    )},\cos (\delta ) \cos (\omega ) \cos (\phi )+\sin (\delta ) \sin (\phi 
    )\right) 
$

where:

  - $\delta$ is the Sun's declination
  - $\phi$ is the observer's latitude
  - $\omega$ is the Sun's "hour angle":
    - $\omega$ is zero at local solar noon
    - $\omega$ is $15 {}^{\circ}$ or $\frac{\pi }{12}$ 1 hour after local solar noon (ie, 1pm on a sundial)
    - $\omega$ is $-15 {}^{\circ}$ or $-\frac{\pi }{12}$ 1 hour before local solar noon (ie, 11am on a sundial)
    - $\omega$ is $\pm180 {}^{\circ}$ or $\pm\pi$ at local solar midnight
    - $\omega$ is $-90 {}^{\circ}$ or $-\frac{\pi }{2}$ 6 hours before local solar noon (ie, 6am on a sundial), and so on.

To make things slightly easier, let's convert $\omega$ to $h$, something closer to clock time. After this conversion, we have:

$

   \text{azimuth}=\tan ^{-1}\left(\cos (\text{dec}) \cos \left(\frac{\pi 
    h}{12}\right) \sin (\text{lat})+\sin (\text{dec}) \cos (\text{lat}),\cos
    (\text{dec}) \sin \left(\frac{\pi  h}{12}\right)\right)
$
$
   \text{elevation}=\tan ^{-1}\left(\sqrt{\left(\cos (\text{dec}) \cos
    \left(\frac{\pi  h}{12}\right) \sin (\text{lat})+\sin (\text{dec}) \cos
    (\text{lat})\right)^2+\cos ^2(\text{dec}) \sin ^2\left(\frac{\pi 
    h}{12}\right)},\sin (\text{dec}) \sin (\text{lat})-\cos (\text{dec}) \cos
    \left(\frac{\pi  h}{12}\right) \cos (\text{lat})\right)
$

where the angles are now measured in radians and:

  - $h$ is 12 at local solar noon
  - $h$ is 1 when it's 1 hour after local solar noon (ie, 1pm on a sundial)
  - $h$ is 11 when it's 1 hour before local solar noon (ie, 11am on a sundial)
  - $h$ is 0 or 24 at local solar midnight
  - $h$ is 6 when it's 6 hours before local solar noon (ie, 6am on a sundial), and so on.

The direction $\theta$ in which a vertical stick's shadow points is opposite the Sun's azimuth. For example, if the Sun is due south, the shadow will point due north. For plotting purposes, we'd like north to be the positive y axis (as on standard maps), which we can achieve by adding $\frac{3 \pi }{2}$. This gives us:

$
  \theta =\frac{3 \pi }{2}-\tan ^{-1}\left(\cos (\delta ) \cos \left(\frac{\pi 
    h}{12}\right) \sin (\phi )+\sin (\delta ) \cos (\phi ),\cos (\delta ) \sin
    \left(\frac{\pi  h}{12}\right)\right)
$

The length of a vertical stick's shadow ($r$) is the cotangent of the Sun's elevation, or:

$
   r=\frac{\sqrt{\left(\cos (\delta ) \cos \left(\frac{\pi  h}{12}\right) \sin
    (\phi )+\sin (\delta ) \cos (\phi )\right)^2+\cos ^2(\delta ) \sin
    ^2\left(\frac{\pi  h}{12}\right)}}{\sin (\delta ) \sin (\phi )-\cos (\delta
    ) \cos \left(\frac{\pi  h}{12}\right) \cos (\phi )}
$

Note that this formula only makes sense when $r$ is nonnegative.

Although we could continue working in polar coordinates, it might be easier to convert to Cartesian coordinates. Using the standard transformation formulas, the x and y positions of the tip of a vertical stick's shadow (where north is the positive y axis and east is the positive x axis, as on a map) is:

$
   x=\frac{1}{\cot \left(\frac{\pi  h}{12}\right) \cos (\phi )-\tan (\delta )
    \csc \left(\frac{\pi  h}{12}\right) \sin (\phi )}
$
$
   y=\frac{\cot (\delta ) \cos \left(\frac{\pi  h}{12}\right) \sin (\phi )+\cos
    (\phi )}{\cot (\delta ) \cos \left(\frac{\pi  h}{12}\right) \cos (\phi
    )-\sin (\phi )}
$

Plotting this:

TODO: math porn warning

TODO: unhappy using r==0 as test of whether to plot or not

(* we want to put points everywhere EXCEPT on the hour where we use
text, and, of course, not when sun is down *)

tab[dec_,lat_] := Select[Table[i,{i,0,24,1/4}], 
 !IntegerQ[#] && rplot[#,dec,lat] > 0 &]

(* the text points are the hours when sun is up *)

txtpts[dec_,lat_] := Select[Table[i,{i,0,24}], rplot[#,dec,lat] > 0 &]

(* the graphics points for a given dec/lat, per tab above *)

pts[dec_,lat_] := Table[
 Point[{xplot[h,dec,lat],yplot[h,dec,lat]}],
 {h, tab[dec,lat]}]

txt[dec_,lat_] := 
 Table[Text[Style[ToString[h], FontSize -> 10], 
 {xplot[h,dec,lat], yplot[h,dec,lat]}, {0,0}],
 {h,txtpts[dec,lat]}];

graphics[dec_,lat_] := Graphics[{pts[dec,lat], txt[dec,lat]}]

testlat = 40*Degree

g = Graphics[{
 txt[0,testlat],
 txt[23.5*Degree, testlat],
 txt[-23.5*Degree, testlat],
 Hue[0], pts[23.5*Degree, testlat],
 Hue[2/3], pts[-23.5*Degree, testlat],
 Hue[1/3],
 pts[0,testlat]
}]

Show[g, Axes -> True, PlotRange -> {{-5,5},{-2,4}}, AspectRatio -> 1,
 Ticks -> False]
showit




Show[gtest, PlotRange->{{-3,3},{-1,1}}, Axes->True, AspectRatio -> 1]
showit




gtest = Show[{
 Graphics[pts[23.5*Degree, 40*Degree]],
 Graphics[txt[23.5*Degree, 40*Degree]]
}, Axes -> True, PlotRange -> {-4,4}, AspectRatio -> 1/4]
showit




gtest = Show[{
 Graphics[pts[23.5*Degree, 40*Degree]],
 Graphics[txt[23.5*Degree, 40*Degree]]
}, PlotRange -> {{-4,4},{0,1}}, Axes -> True, AspectRatio -> 16]

 
 ListPlot[pts[23.5*Degree, 35*Degree]],
 Graphics[txt[23.5*Degree, 35*Degree]]
}]



TODO: INSERT IMAGE

TODO: Moon as exercise, Venus???


TODO: http://paulscottinfo.ipage.com/making/ch41trig/ch41trigD.html




TODO: references section

https://www.google.com/search?q=sundial+time+lapse&ie=utf-8&oe=utf-8

TODO: consistently use elevation not altitude

TODO: tilting stick top will just be the same as shorter stick (but if looking at wedge, might be different)

TODO: where I get these formulas

az[ha_, dec_, lat_] = HADecLat2azEl[ha, dec, lat][[1]]
el[ha_, dec_, lat_] = HADecLat2azEl[ha, dec, lat][[2]]

TODO: graphics here re why its 1/Tan[el]

gnomr[ha_,dec_,lat_] = FullSimplify[1/Tan[el[ha,dec,lat]], conds]

(* adjustment below because we want north = up *)

gnomt[ha_,dec_,lat_] = 3*Pi/2-az[ha,dec,lat]

(* the xy point for a given ha/dec/lat, but origin if r<0 *)

xy[ha_,dec_,lat_] = FullSimplify[
 Max[gnomr[ha,dec,lat],0]*
 {Cos[gnomt[ha,dec,lat]], Sin[gnomt[ha,dec,lat]]}, conds];




dec0 = 23.5*Degree
lat0 = 35*Degree

tab0 = Table[{gnomt[ha, dec0, lat0], gnomr[ha, dec0, lat0]}, 
 {ha, -Pi/2, Pi/2, 0.01}]





TODO: simulate as animated GIF

TODO: tall building

TODO: elecbill stuff

TODO: back of envelope -- 15 deg/hour, at 45 elev?

TODO: sun has angular width, and oblong at horizon

TODO: note when setting, asymptotic to infinity

TODO: note ra/dec fixed is reasonable

TODO: link to formulas

TODO: sid day length and fixed ra cancel each other out

TODO: can't make fixed dec assumption for other problem sun max height

TODO: perhaps use ELECBILL pics to show motion of sun but not this is vertical not horizontal

TODO: consider angled stick

conds = {-Pi/2 < dec < Pi/2, 0 < ha < 2*Pi, -Pi/2 < lat < Pi/2};

az[dec_,ha_,lat_] = FullSimplify[decHaLat2azEl[dec,ha,lat][[1]],conds]
el[dec_,ha_,lat_] = FullSimplify[decHaLat2azEl[dec,ha,lat][[2]],conds]

(* angle and radius, using north as up, east as right *)

(* NOTE: 'rad' is already in use by bclib.m *)

(* TODO: this simplifies)

radi[dec_,ha_,lat_] = FullSimplify[Cot[el[dec,ha,lat]],conds]
ang[dec_,ha_,lat_] = 3*Pi/2-az[dec,ha,lat]

(* xy coords at given time *)

xy[dec_,ha_,lat_]=  radi[dec,ha,lat]*
 {Cos[ang[dec,ha,lat]],Sin[ang[dec,ha,lat]]}

txt[dec_,lat_] = 
 Table[Text[Style[ToString[Mod[ha-12,24]], FontSize -> 5], 
 xy[dec,ha,lat], {0,0}],
 {ha,0,24,1}];

(* we want to put points everywhere EXCEPT on the hour where we use text *)

t = Select[Table[i,{i,0,24,1/4}], !IntegerQ[#] &]
t = Table[i,{i,0,24,1/4}]

pts[dec_,lat_] = 
 Table[
 Point[{Mod[az[dec,ha/12*Pi,lat],2*Pi]/Degree, el[dec,ha/12*Pi,lat]/Degree}], 
 {ha,t}];



xyt[dec_,lat_] = Table[xy[dec,ha/12*Pi,lat], {ha,0,24,1/4}]

ListPlot[xyt[23.5*Degree,35*Degree]]

pts[dec_,lat_] = 
 Table[
 Point[{Mod[az[dec,ha/12*Pi,lat],2*Pi]/Degree, el[dec,ha/12*Pi,lat]/Degree}], 
 {ha,t}];

pts2[dec_,lat_] = 
 Table[
 {Mod[az[dec,ha/12*Pi,lat],2*Pi]/Degree, el[dec,ha/12*Pi,lat]/Degree}, 
 {ha,t}];

(* the stick length at various times and azimuths *)

pts3[dec_,lat_] = 
 Table[
 {Mod[az[dec,ha/12*Pi,lat],2*Pi]/Degree, Cot[el[dec,ha/12*Pi,lat]]}, 
 {ha,t}];

xtics = Table[i,{i,0,360,30}];
ytics = Table[i,{i,-90,90,10}];

ytics3 = Table[i,{i,0,5,.5}];

g2 = ListLogPlot[{
 pts3[0,35*Degree], pts3[23.5*Degree,35*Degree], pts3[-23.5*Degree,35*Degree]
}, Ticks -> {xtics, Automatic}, PlotLegends -> {"Equinox", "Summer Solstice", 
   "Winter Solstice"}, PlotMarkers -> {Automatic, 2}, PlotRange -> {0,5},
 PlotRangeClipping -> True]

g2 = ListPlot[{
 pts3[0,35*Degree], pts3[23.5*Degree,35*Degree], pts3[-23.5*Degree,35*Degree]
}, Ticks -> {xtics, ytics3}, PlotLegends -> {"Equinox", "Summer Solstice", 
   "Winter Solstice"}, PlotMarkers -> {Automatic, 2}, PlotRange -> {0,5}]

g0 = ListPlot[{
 pts2[0,35*Degree], pts2[23.5*Degree,35*Degree], pts2[-23.5*Degree,35*Degree]
}, Ticks -> {xtics, ytics}, PlotLegends -> {"Equinox", "Summer Solstice", 
   "Winter Solstice"}, PlotMarkers -> {Automatic, 2}]

g1 = Graphics[{
 txt[0, 35*Degree], txt[-23.5*Degree, 35*Degree], txt[23.5*Degree, 35*Degree]
}];

Show[{g0,g1}]
showit

TODO: consider projecting at an angle instead of flat surface, and note sun is not a point light source, but has width

Graphics[{txt[0,35*Degree], txt[23.5*Degree, 35*Degree],
          txt[-23.5*Degree, 35*Degree]}]
showit


ListPlot[{t0717[0,35*Degree], t0717[23.5*Degree, 35*Degree], 
         t0717[-23.5*Degree,35*Degree]}]
showit

TODO: mention this file



ParametricPlot[{az[tdec,ha,tlat], el[tdec,ha,tlat]}, {ha,-Pi,Pi}]

(* radius and angle of gnomon; note 'rad' is existing function, sigh *)

(* and the corresponding xy point *)

xy[dec_,ha_,lat_]=  radi[dec,ha,lat]*
 {Cos[ang[dec,ha,lat]],Sin[ang[dec,ha,lat]]}

xyfake[dec_,ha_,lat_]=  1*
 {Cos[ang[dec,ha,lat]],Sin[ang[dec,ha,lat]]}

xy[dec_,ha_,lat_]=  {
 radi[dec,ha,lat]*Cos[ang[dec,ha,lat]],
 radi[dec,ha,lat]*Sin[ang[dec,ha,lat]]
};

xy[dec_,ha_,lat_]=  {
 radi[dec,ha,lat]*Sin[ang[dec,ha,lat]],
 radi[dec,ha,lat]*Cos[ang[dec,ha,lat]]
};







t2244 = Table[xy[0,ha,35*Degree], {ha,-Pi/4,Pi/4,Pi/48}]





tdec = 0
tlat = 35*Degree;

Plot[Cot[el[tdec,ha,tlat]], {ha,-Pi,Pi}]



decHaLat2azEl[dec,ha,lat]

decHaLat2azEl[dec,0,lat]

D[decHaLat2azEl[dec,ha,lat],ha]

FullSimplify[% /. ha -> 0]

{-(Cos[dec] Csc[dec - lat]), 0}

Solve[D[-Cos[dec]*Csc[dec-lat],dec]==0, dec]

decHaLat2azEl[dec,ha,lat]

decHaLat2azEl[0,ha,35*Degree]

ParametricPlot[decHaLat2azEl[0,ha,35*Degree], {ha,-Pi,Pi}]

ParametricPlot[decHaLat2azEl[0,ha,35*Degree]/Degree, {ha,-Pi,Pi}]

TODO: actually list parametric plot so we can see distances and stuff

helper function below makes az range 0-360 because we want center

fix[pair_] := {Mod[pair[[1]],2*Pi], pair[[2]]}

t = Table[N[fix[decHaLat2azEl[0,ha,35*Degree]]]/Degree,{ha,-Pi,Pi,2*Pi/48}]
ListPlot[t, PlotRange -> {{0,360}, {-55,55}}]
showit

t = Table[N[fix[decHaLat2azEl[0,ha,35*Degree]]]/Degree,{ha,-Pi,Pi,2*Pi/48}]
ListPlot[t, PlotRange -> {{0,360}, {-55,55}}]
showit

tab[dec_] = Table[N[fix[decHaLat2azEl[dec,ha,35*Degree]]]/Degree,
 {ha,-Pi,Pi,2*Pi/48}];

(* hours and degrees *)

fix[pair_] := {Mod[pair[[1]]/Pi*180,360], pair[[2]]/Degree}

tab[dec_] = Table[fix[decHaLat2azEl[dec,ha,35*Degree]], {ha,-Pi,Pi,2*Pi/48}];

pts[dec_] = Table[
 Text[ToString[Mod[ha/Pi*12+12,24]],
 fix[decHaLat2azEl[dec,ha,35*Degree]]], {ha,-Pi,Pi,2*Pi/24}];
Graphics[pts[0]]
showit

g1 = ListPlot[{tab[-23.5*Degree], tab[0*Degree], tab[23.5*Degree]}];
g2 = Graphics[{pts[-23.5*Degree], pts[0*Degree], pts[23.5*Degree]}];
Show[{g1,g2}]
showit




TODO: label points with hours!


*)

