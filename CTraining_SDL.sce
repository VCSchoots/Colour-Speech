####### INITIATION #######

# Initiation of the scenario and the main PCL-file
scenario_type = fMRI;#_emulation;# set to fMRI at scanner
pcl_file = "CTraining_MAIN.pcl";
pulse_code = 255;
pulses_per_scan = 1;
#scan_period = 2000;

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

# font
default_background_color = 82,82,82; # mid grey
default_font = "arial";
default_font_size = .6;
default_text_color = 0,0,0; # black
default_text_align = align_center;

# keep SDL as simple as possible and stay clear of the parallel port
response_matching = simple_matching;
response_port_output = true; 

active_buttons = 5;
button_codes = 1,2,3,4,5;  # 1 = ENTER-exp-subj # 2 yes # 3 no

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

### pictures

picture {
} default;	# blank screen

picture { text { caption = " "; } t_info1; x = 0; y = 1;
          text { caption = " "; } t_info2; x = 0; y = -1;
          text { caption = "[ENTER] om te bevestigen of [Esc] om af te sluiten. "; } t_info3; x = 0; y = -2;
} p_info; # text

picture {ellipse_graphic {ellipse_width = 0.5; ellipse_height = 0.5; color = 0, 0, 0; rotation = 30;} circle; 
			x = 0; y = 0;
}fixation; # circle fixation

picture { 	ellipse_graphic {ellipse_width = 0.3; ellipse_height = 0.3; color = 0, 0, 0;} bl_dot;
	x = 0; y = 0;
	ellipse_graphic {ellipse_width = 0.2; ellipse_height = 0.2; color = 255, 255, 255;} wh_dot;
	x = 0; y = 0;
} fixation_cross;  # fixation circle, but yeah.

picture {
   bitmap { preload = false; }dummy;
   x = 0; y = 0;
	bitmap { preload = false; }dummy2;
   x = 0; y = 0;
	ellipse_graphic bl_dot ;
	x = 0; y = 0;
	ellipse_graphic wh_dot ;
	x = 0; y = 0;
} pic;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	picture pic;
}trial1;


picture { text { caption = "Welkom
Dit deel van het experiment
zal ongeveer 20 minuten duren.
										
						(rechter wijsvinger) >";}t_welcome_1; x = 0; y = 0;
} p_welcome;

picture { text { caption = "Pauze"; } t_pause_1a; x = 0; y = 1;  
        text { caption = "Je hebt nu pauze. Blijf stil liggen s.v.p.";}t_pause_1b; x = 0; y = 0; 
		text { caption = "De proefleider zal zo het voldende deel starten met [ENTER].";}t_pause_1c; x = 0; y = -1;
} p_pause;

picture { text { caption = "Ze zult nu in elke trial bewegende cirkels te zien krijgen.
Soms rood, soms groen. Jouw taak is om aan te geven of
de beweging in dezelfde richting gaat als de vorige trial.
De kleur is niet relevant. Druk wijsvinger voor zelfde richting, 
middelvinger voor andere richting. Er zijn drie blokken van 7 minuten
met pauzes ertussen. Houd je blik op het fixeerpunt, en
probeer s.v.p. om de richting NIET in je hoofd te herhalen
om deze te onthouden, dit stoort onze analyses.
											
											(wijsvinger) >";}t_instr; x=0; y=0;
} p_instr;

picture { text { caption = "De trials komen steeds in groepjes van vier,
Met een iets langere pauze ertussen. De taak gaat gewoon door,
Dus onthoud ook tussen de blokken de laatste beweegrichting.
We beginnen met 8 trainingstrials. Je hoeft niets te drukken
voor de eerste cirkel.

Druk wijsvinger om te beginnen. >";}t_train_1; x = 0; y = 0; 
} p_training;


picture { text { caption =
"Wil je nog een ronde oefenen?
Druk wijsvinger voor ja, middelvinger voor nee."; } t_training_1; x = 0; y = 0;  
} p_trainingCont;


picture { text { caption = "Training voltooid."; } t_trainend_1a; x = 0; y = 1;  
        text { caption = "Wij starten zo het experiment met [ENTER].";}t_trainend_1b; x = 0; y = 0; 
} p_training_end;

picture { text { caption = "Bedankt, deze taak is nu afgelopen.
Er volgt nog een laatste taak (1u) en een anatomische scan (5 min).
Wij drukken straks op [ENTER] om dit deel af te sluiten.";} t_end_1; x = 0; y = -1;
} p_end_1;

picture { text { caption = "Wachten op de scanner...
"; } t_countdown; x = 0; y = 0;
} p_countdown; # countdown picture for when the scanner is collecting 30 volume-weighting volumes before the exp. starts.

##### sound file(s) ######

sound { 	wavefile { filename = "WAV-files\\Beep.wav"; preload = true;} w_beep; 
} s_beep;
