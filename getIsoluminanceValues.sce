# getIsoluminanceValues

# Is meant for testing the luminance values of green and red that are equiluminant
# to two given levels of grey for the given participant. It uses the Minimal Flicker Paradigm,
# or "heterochromatic flicker photometry".
# it is dependent on gIV_SUBS.pcl

############################# INITIATION ####################################

no_logfile = true;

# the resolution of the projector at the Skyra (not sure about bit depth)
screen_height = 768; # 25 deg. visual angle
screen_width = 1024; # 33 deg. visual angle
screen_bit_depth = 32;
# refresh rate 60Hz

## This part makes presentation use visual angle (in degrees) in stead of pixels for visual stimuli
# set these to screen measurements in inches
screen_width_distance = 17.87;# Skyra
screen_height_distance = 13.39;# Skyra
# set screen_distance to distance between screen and eyes of subject
screen_distance = 33.66;# Skyra (755 mm + 10 cm = 855 mm)

active_buttons = 5;
button_codes = 1,2,3,4,5;  # 1 = LIGHTER, 2 = lighter, 3 = darker, 4 = DARKER, 5 = confirm

# basic colours
default_background_color = 82,82,82;# see explanation below

default_font = "arial";
default_font_size = .5;# degree visual angle
default_text_color = 0,0,0; # black
default_text_align = align_center;

#####################################################################################################
begin;

picture {
	text {caption = "Kleuren aanpassen
	
We gaan nu eerst de kleuren van de beamer aanpassen aan
jouw kleurwaarneming. Je gaat kijken naar een flikkerende
groene of rode cirkel. Je kunt de felheid daarvan bijstellen
met de knoppenkast:

       [wijsvinger] = veel feller
     [middelvinger] = feller
       [ringvinger] = donkerder
             [pink] = veel donkerder

[linker wijsvinger] = bevestigen.
                                                  
                                    (linker wijsvinger) >";
} t_instruction_1; x = 0; y = 0;
} p_welcome;


picture { text { caption = " "; } t_info1; x = 0; y = .3;
          text { caption = " "; } t_info2; x = 0; y = -.6;
          text { caption = "Press [ENTER] to confirm or [Esc] to abort. "; } t_info3; x = 0; y = -1.5;
} p_info; # text

picture{
   box { height = .02; width = .02; color = 0,0,0; } dummy;
	x = 0; y = 0;
	box { height = .02; width = .4; color = 0, 0, 0; } horz_s_pic;
	x = 0; y = 0;
	box { height = .4; width = .02; color = 0, 0, 0; } vert_s_pic;
	x = 0; y = 0; 
} pic1;# dummy dot with a small fixation cross overlaid

trial {
	trial_type = fixed;
	all_responses =true;
	trial_duration = 58;# 15.15 Hz = 66 ms. 58 ms + (mean (0, 16) = 8 ms) average flip time
	picture pic1;	time = 0;	duration = 1000;#longer than the trial so it is cut off, otherwise you get annoying blank screens in between.
}trial1;

################################################################
begin_pcl;

### INITIATION ###

# -------------------------- BUTTON CODES -----------------------------

int button_BRIGHTER    = 1;  # right index
int button_brighter    = 2;  # right middle
int button_darker    = 3;  # right ring
int button_DARKER = 4;# right little finger
int button_confirm = 5;# left index

# output file --------------------------
output_file ofile1 = new output_file;

# set the brightness values for the rgb channels that the starting brightness should have
array<double> brightgreen[3] = {0.0, 180.0, 0.0};#middle green: {0.0, 95.0, 0.0};
array<double> brightred[3]   = {230.0, 0.0, 0.0};#mid red: {185.0, 0.0, 0.0};
array<double> darkgreen[3] = {0.0, 65.0, 0.0};#{0.0, 95.0, 0.0};
array<double> darkred[3]   = {130.0, 0.0, 0.0};#{185.0, 0.0, 0.0};

# The values  for bright and dark backgrouns have been determined by calculations based on the measured brightness at the Skyra.
# mid green and mid red also, but for procedural purposes, it is better to start off too dark/bright, let the participant move
# to equiluminance.

# and the background colour
array<double> brightbackground[3]  = {90.0, 90.0, 90.0};
array<double> darkbackground[3]  = {74.0, 74.0, 74.0};

################## Include the subroutines. #############
include "gIV_SUBS.pcl";	


############## ask for participant number ###############
string sInfo = GetInfo("What's the subject code (e.g., sub_01)?");

############## generating the circles ###################

# preparing the graphic surface to pass to the flickertrial sub
double visdeg = 7.19;# 7.19 degree visual angle as per Bannert & Bartels (2013) Current Biology.

vsg::ellipse_generator ellipsegen = new vsg::ellipse_generator( visdeg, visdeg, 0 );
vsg::graphic_generator graph_gen2 = new vsg::graphic_generator( visdeg, visdeg );
graph_gen2.add_transformation( ellipsegen, vsg::combine_none );

###################### instructions #####################
p_welcome.present();
WaitForButtonpress( button_confirm );

####################### MAIN LOOP #########################

array<double> bg1[3] = flickertrial( graph_gen2, brightgreen, brightbackground);# run luminance matching trial and collect end value
term.print_line( string(bg1[1]) + "\t" + string(bg1[2]) + "\t" + string(bg1[3]) );

array<double> br1[3] = flickertrial( graph_gen2, brightred, brightbackground);
array<double> bg2[3] = flickertrial( graph_gen2, brightgreen, darkbackground);
array<double> br2[3] = flickertrial( graph_gen2, brightred, darkbackground);

array<double> dg1[3] = flickertrial( graph_gen2, darkgreen, brightbackground);
array<double> dr1[3] = flickertrial( graph_gen2, darkred, brightbackground);
array<double> dg2[3] = flickertrial( graph_gen2, darkgreen, darkbackground);
array<double> dr2[3] = flickertrial( graph_gen2, darkred, darkbackground);

################### write end values to output file ###################

array<double> g1[3];
g1[1] = (bg1[1]+dg1[1])/2.0;
g1[2] = (bg1[2]+dg1[2])/2.0;
g1[3] = (bg1[3]+dg1[3])/2.0;

array<double> r1[3];
r1[1] = (br1[1] + dr1[1])/2.0;
r1[2] = (br1[2] + dr1[2])/2.0;
r1[3] = (br1[3] + dr1[3])/2.0;

array<double> g2[3];
g2[1] = (bg2[1] + dg2[1])/2.0;
g2[2] = (bg2[2] + dg2[2])/2.0;
g2[3] = (bg2[3] + dg2[3])/2.0;

array<double> r2[3];
r2[1] = (br2[1] + dr2[1])/2.0;
r2[2] = (br2[2] + dr2[2])/2.0;
r2[3] = (br2[3] + dr2[3])/2.0;

outputFileWrite(ofile1, sInfo, g1, r1, g2, r2);
