####### INITIATION #######

# Initiation of the scenario and the main PCL-file

scenario = "CSpeech";
scenario_type = fMRI_emulation;# set to fMRI at the scanner!
pcl_file = "CSpeech_Session1_MAIN.pcl";
pulse_code = 255;
pulses_per_scan = 1;
scan_period = 2000;
write_codes = true;
default_output_port = 1;
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !! at the scanner, uncomment all lines with port_code (use search function)
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# the resolution of the screen/ adapt to fit projector
screen_height = 768; 
screen_width = 1024;
screen_bit_depth = 32;  

# keep SDL as simple as possible and stay clear of the parallel port
response_matching = simple_matching;
response_port_output = true; 

active_buttons = 4;
button_codes = 1,2,3,4;  # 1 = ENTER-exp-subj # 2 yes # 3 no # 4 SPACEBAR-exp

# basic colours and fonts
default_background_color = 82,82,82; # grey as in PPM, adjust to picture background
default_font = "arial";
default_font_size = 20;
default_text_color = 0,0,0; # black
default_text_align = align_center;

######### BEGIN ##########

begin;

##########################
picture {} default;	# blank screen

picture { box { height = 3; width = 30; color = 0, 0, 0; } horz_s;
			 x = 0; y = 0;
			 box { height = 30; width = 3; color = 0, 0, 0; } vert_s;
			 x = 0; y = 0;
} fixation;  # fixation cross

picture {ellipse_graphic {ellipse_width = 20; ellipse_height = 20; color = 0, 0, 0; rotation = 30;} circle; 
			x = 0; y = 0;
} cue; # speech cue

picture { text { caption = " "; } t_info1; x = 0; y = 30;
          text { caption = " "; } t_info2; x = 0; y = 0;
          text { caption = "Druk [ENTER] om door te gaan of [Esc] om te onderbreken. "; } t_info3; x = 0; y = -30;
} p_info; # text

picture { text { caption = "Wachten op de scanner...
"; } t_countdown; x = 0; y = 0;
} p_countdown; # countdown picture for when the scanner is collecting 30 volume-weighting volumes before the exp. starts.

######## GENERAL PICTURES ########

picture {
	text {caption = "Welkom bij dit experiment.
	
De eerste taak duurt ongeveer drie kwartier (4 delen met 3x pauze),
de tweede taak duurt ook ongeveer drie kwartier, en tot slot
maken we een anatomische scan van tien minuten.

Als eerste komt nu een kalibratie van de oogcamera.
                                                  
                                    OK (wijsvinger) >";
} t_instruction_1; x = 0; y = 0;
} p_welcome;

picture { text { caption = "Deel 1: Plaatjes Benoemen

Je krijgt een serie plaatjes te zien. Het is de bedoeling
dat je stil (in je hoofd) de plaatjes benoemt (dus: als
je een vleermuis ziet, zeg je in je hoofd 'vleermuis').
Af en toe komt er na het plaatje een stip in beeld. 
Terwijl die stip er staat, moet je het woord hardop
uitspreken. We nemen je respons op, spreek s.v.p. luid
en duidelijk.
																
													(wijsvinger) >"; } t_instruction_naming_1; x = 0; y = 0;  
} p_instr_naming;

picture { text { caption =
"Je krijgt nu eerst een oefenronde, zodat je kunt wennen
aan de taak in de scanner. Het is tijdens het hele experiment
BELANGRIJK DAT JE JE BLIK IN HET MIDDEN HOUDT,
op het kruis of de stip, ook als het plaatje komt. De
plaatjes in de oefenronde zijn andere dan in het experiment.
																
													(wijsvinger) >"; } t_traininginstr_1; x = 0; y = 0;  
} p_instr_training;

picture { text { caption =
"Wil je nog een ronde oefenen?
Druk wijsvinger voor ja, middelvinger voor nee."; } t_training_1; x = 0; y = 0;  
} p_training;

picture { text { caption = "Prima!
Druk wijsvinger om door te gaan met het experiment."; } t_training_1b; x = 0; y = 0;  
} p_aftertraining;

picture { text { caption = "Bedankt! Deel 1 is klaar.
Druk wijsvinger om door te gaan naar de instructies
voor het tweede (laatste) deel."; } t_end_part11; x = 0; y = 0;  
} p_end_part1;

picture { text { caption = "Deel 2: Natuurlijk of Gemaakt
Nu ga je dezelfde plaatjes bekijken, maar dit keer
zeg je in jezelf 'Natuurlijk' als het een natuurlijk
object is, en 'Gemaakt' als het door de mens gemaakt is.
Als de stip in beeld is moet je hetzelfde hardop zeggen."; } t_instruction_judgement_1; x = 0; y = 0;  
} p_instr_judgement;

picture { text { caption = "PAUZE"; } t_pause_1a; x = 0; y = 30;  
        text { caption = "Je hebt nu pauze. Blijf stil liggen s.v.p.";}t_pause_1b; x = 0; y = 0; 
		text { caption = "De proefleider zal zo verdergaan met [ENTER].";}t_pause_1c; x = 0; y = -30;
} p_pauze;

picture { text { caption = "Oogkalibratie? [SPATIE] ja, [ENTER] nee."; } t_eyeQuest; x=0; y=0;
} p_eyeQuest;

picture { text { caption = "Het experiment is nu afgelopen.
Bedankt voor het meedoen! 
Wij drukken straks op [ENTER]. Dan volgt nog één oogkalibratie,
en tot slot de anatomische scan (10 minuten)."; } t_end_1; x = 0; y = 0;  
} p_end_1;

###################### for the eyetracker calibration ############################

trial {                             #instructions

   trial_duration = 5000;

	stimulus_event {
		picture{
			text { caption = "Kalibratie oogcamera
In deze taak moet je je blik op het kruisje fixeren "; } introtext;
			x=0;y=0;
      } textpic;
		code = "instr_text";
	}instr_event;
}text_eyetr;


trial {                             #Show focus point

   trial_duration = 2000;

	stimulus_event {
		picture {
			box {height = 3; width = 30; color = 250, 250, 250;}horizontal;
			x=0;y=0;
			box {height = 30; width = 3; color = 250, 250, 250;}vertical;
			x=0;y=0;
		}cross;
	code = "calibr_cross";
	port_code = 30; # needs to be there at scanner!! (for proper log file eyetracker)
	} crossevent;
}eyetrial;


######## STIMULI #########

##### sound file(s) ######

sound { 	wavefile { filename = "WAV-files\\Beep.wav"; preload = true;} w_beep; 
} s_beep;

sound_recording {
	duration = 4000;
	use_date_time = false;
} recording;

####### visual stimuli ########

picture {    bitmap { filename = "Pictures\\empty.bmp"; preload = true; width = 222; height = 222; } b_target;
	x = 0; y = 0;
	box { height = 3; width = 30; color = 0, 0, 0; } horz_s_pic;
	x = 0; y = 0;
	box { height = 30; width = 3; color = 0, 0, 0; } vert_s_pic;
	x = 0; y = 0; 
} p_target; 

