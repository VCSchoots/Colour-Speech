####### INITIATION #######

# Initiation of the scenario and the main PCL-file

scenario = "CSpeech";
scenario_type = fMRI_emulation;
pcl_file = "CSpeech_Session2_MAIN.pcl";
pulse_code = 255;
pulses_per_scan = 1;
scan_period = 2000;

# the resolution of the screen/ adapt to fit projector
screen_height = 1080; 
screen_width = 1920;
screen_bit_depth = 32;  

# keep SDL as simple as possible and stay clear of the parallel port
response_matching = simple_matching;
response_port_output = true; 

active_buttons = 3;
button_codes = 1,2,3;  # 1 = ENTER-exp-subj # 2 yes # 3 no

# basic colours and fonts
default_background_color = 240,240,240; # grey as in PPM, adjust to picture background
default_font = "arial";
default_font_size = 20;
default_text_color = 0,0,0; # black
default_text_align = align_center;

######### BEGIN ##########

begin;

##########################
picture {} default;	# blank screen

picture { box { height = 2; width = 60; color = 0, 0, 0; } horz_s;
			 x = 0; y = 0;
			 box { height = 60; width = 2; color = 0, 0, 0; } vert_s;
			 x = 0; y = 0;
} fixation;  # fixation cross

picture {ellipse_graphic {ellipse_width = 20; ellipse_height = 20; color = 0, 0, 0; rotation = 30;} circle; 
			x = 0; y = 0;
} cue; # speech cue

picture { text { caption = " "; } t_info1; x = 0; y = 20;
          text { caption = " "; } t_info2; x = 0; y = -40;
          text { caption = "Press [ENTER] to confirm or [Esc] to abort. "; } t_info3; x = 0; y = -150;
} p_info; # text

######## GENERAL PICTURES ########

picture { text { caption = "Welkom!"; } t_instruction_1a; x = 0; y = 70;  
        text { caption = "We will start with training etc.";}t_instruction_1b; x = 0; y = 35; 
		text { caption = "Instructions. ";}t_instruction_1c; x = 0; y = 0;
} p_welcome;

picture { text { caption = "Part 1:"; } t_instruction_naming_1a; x = 0; y = 70;  
        text { caption = "Instructions for picture naming.";}t_instruction_naming_1b; x = 0; y = 35; 
		text { caption = "Further instructions. ";}t_instruction_naming_1c; x = 0; y = 0;
} p_instr_naming;

picture { text { caption = "Thanks! Part 1 is over."; font_size = 16; } t_end_part11a; x = 0; y = 18;  
			 text { caption = "Bedankt voor het meedoen!"; font_size = 16; } t_end_part11b; x = 0; y = -18;
			 text { caption = "Press [ENTER] to continue."; font_size = 16; } t_end_part11c; x = 0; y = -100;
} p_end_part1;

picture { text { caption = "Part 2:"; } t_instruction_judgement_1a; x = 0; y = 70;  
        text { caption = "Instructions for colour naming task.";}t_instruction_judgement_1b; x = 0; y = 35; 
		text { caption = "Further instructions. ";}t_instruction_judgement_1c; x = 0; y = 0;
} p_instr_colnaming;

picture { text { caption = "Welkom!"; } t_welcome_1a; x = 0; y = 70;  
        text { caption = "Hartelijk dank voor je deelname aan ons experiment!";}t_welcome_1b; x = 0; y = 35; 
		text { caption = "Het experiment duurt ongeveer 65 minuten. ";}t_welcome_1c; x = 0; y = 0;
} p_instruction_1;

picture { text { caption = "Instructions.";} t_instruction_2a; x = 0; y = 0;
} p_instruction_2;

picture { text { caption = "PAUZE"; } t_pause_1a; x = 0; y = 35;  
        text { caption = "Je hebt nu een korte pauze.";}t_pause_1b; x = 0; y = 0; 
		text { caption = "Probeer te ontspannen. Instructions again.";}t_pause_1c; x = 0; y = -35;
} p_pauze;

picture { text { caption = "Insert instructions for training."; } t_traininginstr_1a; x = 0; y = 35;  
        text { caption = "Press Enter to start.";}t_traininginstr_1b; x = 0; y = 0; 
} p_instr_training;

picture { text { caption = "Would you like another round of training?"; } t_training_1a; x = 0; y = 35;  
        text { caption = "Press left for yes and right for no.";}t_training_1b; x = 0; y = 0; 
} p_training;

picture { text { caption = "Great!"; } t_training_1c; x = 0; y = 35;  
        text { caption = "Press Enter to go on to the experiment.";}t_training_1d; x = 0; y = 0; 
} p_aftertraining;

picture { text { caption = "Het experiment is nu afgelopen."; font_size = 16; } t_end_1a; x = 0; y = 18;  
			 text { caption = "Bedankt voor het meedoen!"; font_size = 16; } t_end_1b; x = 0; y = -18;
			 text { caption = "Wij drukken straks op [ENTER] om het experiment af te sluiten."; font_size = 16; } t_end_1c; x = 0; y = -100;
} p_end_1;



######## STIMULI #########

##### sound file(s) ######

sound { 	wavefile { filename = "WAV-files\\Beep.wav"; preload = true;} w_beep; 
} s_beep;

sound_recording {
	duration = 4000;
	use_date_time = false;
} recording;

####### visual stimuli ########

picture { bitmap { filename = "Pictures\\empty.bmp"; preload = true; width = 300; height = 300; transparent_color = 255,255,255;} b_target; x = 0; y = 0;
          box { height = 2; width = 60; color = 0, 0, 0; } horz_s_pic;
			 x = 0; y = 0;
			 box { height = 60; width = 2; color = 0, 0, 0; } vert_s_pic;
			 x = 0; y = 0; 
} p_target; 

