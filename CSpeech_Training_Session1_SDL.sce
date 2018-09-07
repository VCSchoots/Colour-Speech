####### INITIATION #######

# Initiation of the scenario and the main PCL-file

scenario = "CSpeech";
scenario_type = fMRI_emulation;
pcl_file = "CSpeech_Training_Session1_MAIN.pcl";
pulse_code = 255;
pulses_per_scan = 1;
scan_period = 2000;

# the resolution of the screen/ adapt to fit projector
screen_height = 768; 
screen_width = 1024;
screen_bit_depth = 32;

# keep SDL as simple as possible and stay clear of the parallel port
response_matching = simple_matching;
response_port_output = true; 

active_buttons = 3;
button_codes = 1,2,3;  # 1 = ENTER-exp-subj # 2 yes # 3 no

# basic colours and fonts
default_background_color = 82,82,82; # grey as luninance-matched to the brightest red minus a margin.
default_font = "arial";
default_font_size = 20;
default_text_color = 0,0,0; # black
default_text_align = align_center;

######### BEGIN ##########

begin;

##########################
picture {} default;	# blank screen

picture { box { height = 2; width = 30; color = 0, 0, 0; } horz_s;
			 x = 0; y = 0;
			 box { height = 30; width = 2; color = 0, 0, 0; } vert_s;
			 x = 0; y = 0;
} fixation;  # fixation cross

picture {ellipse_graphic {ellipse_width = 20; ellipse_height = 20; color = 0, 0, 0; rotation = 30;} circle; 
			x = 0; y = 0;
} cue; # speech cue

picture { text { caption = " "; } t_info1; x = 0; y = 20;
          text { caption = " "; } t_info2; x = 0; y = -40;
          text { caption = "Druk [ENTER] om door te gaan of [Esc] om af te sluiten. "; } t_info3; x = 0; y = -150;
} p_info; # text

######## GENERAL PICTURES ########

picture {
	text {caption = "Welkom
	
Dit is de trainingsessie. Je kunt nu de taken oefenen
die je straks in de scanner zult doen. Je krijgt tien
plaatjes te benoemen, en kunt dan kiezen of je nog een
ronde wilt oefenen of niet. Deze oefenplaatjes zijn
andere dan je in de scanner zult zien.
                                                  
                                    OK (enter) >";
} t_instruction_1; x = 0; y = 0;
} p_welcome;

picture { text { caption = "Deel 1: Plaatjes Benoemen

Je krijgt een serie plaatjes te zien. Het is de bedoeling
dat je stil (in je hoofd) de plaatjes benoemd (dus: als
je een vleermuis ziet, zeg je in je hoofd 'vleermuis').
Af en toe komt er na het plaatje een stip in beeld. 
Terwijl die stip er staat, moet je het woord hardop
uitspreken (we nemen in de scanner je respons op).
												
												Verder (enter) >"; } t_instruction_naming_1; x = 0; y = 0;  
} p_instr_naming;

picture { text { caption = "Tijdens de taak staat er een fixatiekruis in het midden
van het scherm. In de scanner is het belangrijk dat je
je blik altijd op het kruis houdt. Voor sommige mensen
is dat lastig als er een plaatje verschijnt. Dat kun je
nu ook oefenen.
												
												Verder (enter) >"; } t_instruction_naming_2; x = 0; y = 0;  
} p_instr_naming2;

picture { text { caption = "Soms is het zo dat er een wat langere pauze
tussen de plaatjes zit. Het programma blijft niet hangen.
												
												Begin (enter) >"; } t_instruction_naming_3; x = 0; y = 0;  
} p_instr_naming3;

picture { text { caption = "Deel 2: Natuurlijk of Gemaakt
Nu ga je dezelfde plaatjes bekijken, maar dit keer
zeg je in jezelf 'Natuurlijk' als het een natuurlijk
object is, en 'Gemaakt' als het door de mens gemaakt is.
Als de stip in beeld is moet je hetzelfde hardop zeggen.
												
												Begin (enter) >"; } t_instruction_judgement_1; x = 0; y = 0;  
} p_instr_judgement;

picture { text { caption = "Welkom!"; } t_welcome_1a; x = 0; y = 70;  
        text { caption = "Hartelijk dank voor je deelname aan ons experiment!";}t_welcome_1b; x = 0; y = 35; 
} p_instruction_1;

picture { text { caption = "Instructions.";} t_instruction_2a; x = 0; y = 0;
} p_instruction_2;

picture { text { caption = "PAUZE"; } t_pause_1a; x = 0; y = 35;  
        text { caption = "Je hebt nu een korte pauze.";}t_pause_1b; x = 0; y = 0; 
		text { caption = "Probeer te ontspannen.";}t_pause_1c; x = 0; y = -35;
} p_pauze;

picture { text { caption = "Insert instructions for training."; } t_traininginstr_1a; x = 0; y = 35;  
        text { caption = "Press Enter to start.";}t_traininginstr_1b; x = 0; y = 0; 
} p_instr_training;

picture { text { caption =
"Wil je nog een ronde oefenen?
Druk links voor ja, rechts voor nee."; } t_training_1; x = 0; y = 0;  
} p_training;

picture { text { caption = "Prima!
Druk enter om door te gaan met het experiment."; } t_training_1b; x = 0; y = 0;  
} p_aftertraining;

picture { text { caption = "Het experiment is nu afgelopen.
Bedankt voor het meedoen! 
Druk op [ENTER] om het experiment af te sluiten."; } t_end_1; x = 0; y = 0;  
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
          box { height = 2; width = 30; color = 0, 0, 0; } horz_s_pic;
			 x = 0; y = 0;
			 box { height = 30; width = 2; color = 0, 0, 0; } vert_s_pic;
			 x = 0; y = 0; 
} p_target; 

