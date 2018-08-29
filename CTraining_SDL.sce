####### INITIATION #######

# Initiation of the scenario and the main PCL-file

scenario_type = fMRI_emulation;
pcl_file = "CTraining_MAIN.pcl";
pulse_code = 255;
pulses_per_scan = 1;
scan_period = 2000;

# font
default_background_color = 82,82,82; # mid grey
default_font = "arial";
#default_font_size = 20;
default_text_color = 255,255,255; # white
default_text_align = align_center;

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
screen_distance = 30.12;# Skyra

# keep SDL as simple as possible and stay clear of the parallel port
response_matching = simple_matching;
response_port_output = true; 

active_buttons = 3;
button_codes = 1,2,3;  # 1 = ENTER-exp-subj # 2 yes # 3 no


### Definitions

# To copy Bannert & Bartels (2013)
# periodicity 0.5 cycles / visual degree, expand or contract with 1 deg/s.
# this later needs to be calibrated such that we make a high- and low luminance version,
# where the green and red hue have been made equiluminant with a 162 cd/m^2 and a 198 cd/m^2 background.
# (that is + and - 10% around the background luminance).

# it needs to be combined with an ellipse with width and height to visual angle 7.19 deg (Bannert & Bartels 2013)
# the background value (of the mask and in-between the colours of the circles) should be calibrated to be 180 cd/m^2 luminance.x

######### BEGIN ##########

begin;

##########################

### pictures

picture {
} default;	# blank screen

picture { text { caption = " "; } t_info1; x = 0; y = 1;
          text { caption = " "; } t_info2; x = 0; y = -1;
          text { caption = "Press [ENTER] to confirm or [Esc] to abort. "; } t_info3; x = 0; y = -2;
} p_info; # text

picture {ellipse_graphic {ellipse_width = 0.5; ellipse_height = 0.5; color = 0, 0, 0; rotation = 30;} circle; 
			x = 0; y = 0;
}fixation; # circle fixation

picture { box { height = 0.05; width = 2; color = 0, 0, 0; } horz_s;
			 x = 0; y = 0;
			 box { height = 2; width = 0.05; color = 0, 0, 0; } vert_s;
			 x = 0; y = 0;
} fixation_cross;  # fixation cross

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


picture { text { caption = "Welcome!"; } t_welcome_1a; x = 0; y = 1;  
        text { caption = "This part of the experiment will last";}t_welcome_1b; x = 0; y = 0; 
		text { caption = "approximately 20 minutes.";}t_welcome_1c; x = 0; y = -1;
} p_welcome;

picture { text { caption = "Pause."; } t_pause_1a; x = 0; y = 1;  
        text { caption = "This is pause 1.";}t_pause_1b; x = 0; y = 0; 
		text { caption = "The experimenter will continue with [ENTER].";}t_pause_1c; x = 0; y = -1;
} p_pause;

picture { text { caption = "Instructions: Please answer the following question for every picture you see: ";}t_instruction_1a; x = 0; y = 3;
			text { caption = "Do the circles move in the same direction as before?";}t_instruction_1b; x = 0; y = 2;
			text { caption = "Press left for yes and right for no while you see the circles.";}t_instruction_1c; x = 0; y = 1;
			text { caption = "Please try not to repeat the direction in your head to remember it.";}t_instruction_1d; x = 0; y = 0;		
			text { caption = "The task will be the same for all blocks.";}t_instruction_1e; x = 0; y = -1; 
			text { caption = "Press enter to continue.";}t_instruction_1f; x = 0; y = -3; 
} p_instr;

picture { text { caption = "We will start with 4 training trials."; } t_train_1a; x = 0; y = 1;  
        text { caption = "You don't have to press anything for the first circle.";}t_train_1b; x = 0; y = 0; 
		text { caption = "Press enter to continue.";}t_train_1c; x = 0; y = -1; 
} p_training;

picture { text { caption = "Training end screen."; } t_trainend_1a; x = 0; y = 1;  
        text { caption = "Press enter to continue to the experiment.";}t_trainend_1b; x = 0; y = 0; 
} p_training_end;

picture { text { caption = "Het experiment is nu afgelopen."; } t_end_1a; x = 0; y = 1;  
			 text { caption = "Bedankt voor het meedoen!";  } t_end_1b; x = 0; y = 0;
			 text { caption = "Wij drukken straks op [ENTER] om het experiment af te sluiten.";} t_end_1c; x = 0; y = -1;
} p_end_1;

##### sound file(s) ######

sound { 	wavefile { filename = "WAV-files\\Beep.wav"; preload = true;} w_beep; 
} s_beep;
