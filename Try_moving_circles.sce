no_logfile = true;

begin;

picture {
   bitmap { preload = false; }dummy;
   x = 0; y = 0;
	bitmap { preload = false; }dummy2;
   x = 0; y = 0;
} pic;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	picture pic;
}trial1;

#======================================================
begin_pcl;

# To copy Bannert & Bartels (2013)
# periodicity 0.5 cycles / visual degree, expand or contract with 1 deg/s.
# this later needs to be calibrated such that we make a high- and low luminance version,
# where the green and red hue have been made equiluminant with a 162 cd/m^2 and a 198 cd/m^2 background.
# (that is + and - 10% around the background luminance).

# it needs to be combined with an ellipse with width and height to visual angle 7.19 deg (Bannert & Bartels 2013)
# the background value (of the mask and in-between the colours of the circles) should be calibrated to be 180 cd/m^2 luminance.

### definitions ###
# set the brightness values for the rgb channels that the maximum brightness should have
array<double> brightred[3]   = {255.0, 0, 0};
array<double> darkred[3]     = {200.0, 0, 0};
array<double> brightgreen[3] = {0, 255.0, 0};
array<double> darkgreen[3]   = {0, 200.0, 0};
# and the background colour
array<double> background[3]  = {127.5, 127.5, 127.5};
#these can later be overwritten by reading in a log file from a colour luminance matching script
###################

# calculate the necessary background and amplitude numbers for the sine waves used in stimulus generation
array<double> BR[6];# BR for 'Bright Red', array to be filled with {red background, red amplitude, g backgr, g amp, b backgr, b amp}
BR[1] = (brightred[1] + background[1])/ 2.0;# red channel background (difference between brightest and darkest halved)
BR[2] = (brightred[1] - background[1])/ 2.0;# red channel amplitude (average of brightest and darkest)
BR[3] = (brightred[2] + background[2])/ 2.0;# green backgr (same thing, but inverted so that the period is inverse to that of the red channel)
BR[4] = (brightred[2] - background[2])/ 2.0;# green amp
BR[5] = (brightred[3] + background[3])/ 2.0;# blue
BR[6] = (brightred[3] - background[3])/ 2.0;# blue

# making an array of graphic surfaces with red-and-grey circles moving inward on each iteration
vsg::circular_generator circlegen = new vsg::circular_generator( 25.0, 0.0, false );# the sinusoid circles are generated
array<graphic_surface>redsurfaces[50];# empty surfaces
vsg::graphic_generator graph_gen = new vsg::graphic_generator( 800.0, 600.0 );
graph_gen.add_transformation( circlegen, vsg::combine_none );
graph_gen.add_parameter_increment( circlegen, vsg::phase, 10.0 );
graph_gen.set_colors( BR[1], BR[2], BR[3], BR[4], BR[5], BR[6] );# red-and-grey circles
graph_gen.draw( redsurfaces, 50 );

# making an array of green-and-grey inward moving circles
array<graphic_surface>greensurfaces[50];# empty surfaces
graph_gen.set_colors( 63.75, -63.75, 191.25, 63.75, 63.75, -63.75 );# green-and-grey circles
graph_gen.draw( greensurfaces, 50 );

# making a mask that sets the screen surronding the cicrles to grey
vsg::ellipse_generator ellipsegen = new vsg::ellipse_generator( 600.0, 600.0, 0.0 );# an ellipse to act as a mask
vsg::graphic_generator graph_gen2 = new vsg::graphic_generator( 800.0, 600.0 );
graph_gen2.add_transformation( ellipsegen, vsg::combine_none );
graph_gen2.set_colors( 63.75, -63.75, 63.75, -63.75, 63.75, -63.75 );# grey background, black circle
graphic_surface mask = graph_gen2.create();
mask.set_transparent_color( 0, 0, 0 );

# putting the mask in the picture
pic.set_part( 2, mask );

# putting the red inward circles in the picture and presenting them
loop int i = 1 until i > redsurfaces.count()
begin
   pic.set_part( 1, redsurfaces[i] );
   trial1.present();
   wait_interval(20);
   i = i + 1;
end;

# putting the green inward circles in the picture and presenting them
loop int i = 1 until i > greensurfaces.count()
begin
   pic.set_part( 1, greensurfaces[i] );
   trial1.present();
   wait_interval(20);
   i = i + 1;
end;

# putting the red outward circles in the picture and presenting them
loop int i = 1 until i > redsurfaces.count()
begin
   pic.set_part( 1, redsurfaces[51 - i] );
   trial1.present();
   wait_interval(20);
   i = i + 1;
end;

# putting the green outward circles in the picture and presenting them
loop int i = 1 until i > greensurfaces.count()
begin
   pic.set_part( 1, greensurfaces[51 - i] );
   trial1.present();
   wait_interval(20);
   i = i + 1;
end;

