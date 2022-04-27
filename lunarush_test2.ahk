#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2





/* needs to be done: 
Integration for Warriors greater than 12
Checking if the luna rush page is already completly loaded.
Loginto MetaMask
Checking if logged in or kicked out of the game
Checking if it is on the right page
and a lot more



                                            ██
                                          ██░░██                                        
                                        ██░░░░░░██                           
                                      ██░░░░░░░░░░██                                    
                                      ██░░░░░░░░░░██                                    
                                    ██░░░░░░░░░░░░░░██                                  
                                  ██░░░░░░██████░░░░░░██                                
                                  ██░░░░░░██████░░░░░░██                                
                                ██░░░░░░░░██████░░░░░░░░██                              
                                ██░░░░░░░░██████░░░░░░░░██                              
                              ██░░░░░░░░░░██████░░░░░░░░░░██                            
                            ██░░░░░░░░░░░░██████░░░░░░░░░░░░██                          
                            ██░░░░░░░░░░░░██████░░░░░░░░░░░░██                          
                          ██░░░░░░░░░░░░░░██████░░░░░░░░░░░░░░██                        
                          ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                        
                        ██░░░░░░░░░░░░░░░░██████░░░░░░░░░░░░░░░░██                      
                        ██░░░░░░░░░░░░░░░░██████░░░░░░░░░░░░░░░░██                      
                      ██░░░░░░░░░░░░░░░░░░██████░░░░░░░░░░░░░░░░░░██                    
                      ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                    
                        ██████████████████████████████████████████        
WARNING: THERE ARE ALMOST NO CHECKS IMPLEMENTED RIGHT NOW; IT WILL JUST CLICK ON THE COORDINATES; USE AT YOUR OWN RISK!!



naming convention: where__what
	the first part refers to the current page and the second part after the "__" to what should be done; e.g. bosshunt__boss_selection
	refers to an action on the bosshunt page and the action is to select the boss
*/

^!r::Reload

#IfWinActive Luna Rush

sleep_around_x_seconds(sleep_seconds) 
		{
		Random, sleep_seconds, sleep_seconds * 800, sleep_seconds * 1200
		sleep, sleep_seconds
		return
		}
		
sleep_random:   ; sleeps randomly between 10 and 12,5 seconds
		{
		Random, sleep_random_duration, 10000, 12500
		sleep, sleep_random_duration
		return
		}

random_tolerance_x_percent(given_tolerance) {     ; returns a random factor within the given tolerance range in percent. e.g input 10 --> outputs a random number between 0.90 and 1.10
	given_tolerance_percent := given_tolerance / 100
	Random, x_tolerance, 1 - given_tolerance_percent, 1 + given_tolerance_percent
	return x_tolerance
}

main__click_boss_hunt:  ; clicks at the Boss-Hunt-Button Position in the main menu and open the BossHunt screen
		Gosub, sleep_random
		Send {Click, 500 620}
		return


bosshunt__boss_selection(boss_number) { ; selects the boss
		Gosub, sleep_random   
		tolerance := random_tolerance_x_percent(8)
		x_pos1 := 845 * tolerance   ; absolut position of the Boss 1 button in the first line
		y_pos1 := 525 * tolerance
		x_pos2 := 975 * tolerance  ; absolut position of the Boss 2 button in the second line
		y_pos2 := 855 * tolerance
		x_pos_relative := 390  ; x-distance between the buttons in the same line for example between boss 1 and boss 3
	
		if Mod(boss_number, 2) = 0	; used for bosses in the second line, thus boss 2 4 6 8 
			{	
			x_pos := x_pos2 + (boss_number - 2) / 2 * x_pos_relative 
			MouseClick, Left, x_pos, y_pos2
			}
			
		else 	; for the first line 1 3 5 7 
			{	
			x_pos := x_pos1 + (boss_number - 1) / 2 
			MouseClick, Left, x_pos, y_pos1
			}
			return
		} return
		
	
	
bosshunt_expanded__warrior_selection(warrior_number) {     ; clicks on  selected warrior view must be expanded >>>> currently works for warriors 1 to 12 only <<<<
			Gosub, sleep_random
			tolerance := random_tolerance_x_percent(9)
			x_pos_warrior1 := 300 * tolerance
			y_pos_warrior1 := 500 * tolerance
			x_pos_warrior_relativ := 150 ; that means e.g. that warrior 2 is 150 more to the right 
			y_pos_warrior_relativ := 200 ; that means e.g. that line 2 is 200 down in relation to line 1
			If (warrior_number < 5)  ; line 1 warriors 1 to 4
				{
				MouseClick, Left, x_pos_warrior1 + x_pos_warrior_relativ * (warrior_number - 1), y_pos_warrior1
				return
				} 
			Else If (warrior_number > 4 ) and (warrior_number < 9)  ; line 2
				{
				MouseClick, Left, x_pos_warrior1 + x_pos_warrior_relativ * (warrior_number - 5), y_pos_warrior1 + y_pos_warrior_relativ
				return
				}
			Else If (warrior_number > 8 ) and ( warrior_number < 13 ) ; line 3
				{
				MouseClick, Left, x_pos_warrior1 + x_pos_warrior_relativ * (warrior_number - 9), y_pos_warrior1 + y_pos_warrior_relativ * 2
				return
				}
			} return



				
remove-all:
Gosub, sleep_random
Send {Click, 1100 950}
Gosub, sleep_random
return

bosshunt__expand-view: ; expands the warriors_view
Gosub, sleep_random   
Send {Click, 555 666}
return 

bosshunt__start_battle:   ; clicks at the Boss-Hunt Button Position in the Boss Hunt Screen and starts the battle
Gosub, sleep_random
Send {Click, 1500 960}
return

bosshunt__warrior1:
return


open_chest:          ; opens the chest after the battle and returns to the boss-hunt-screen
Send {Click, 950 950}
sleep 3000
Send {Click, 950 950}
return

bosshunt__remove-all:        ; clicks "removes all" to remove all warriors from the team in the boss-hunt-screen
Gosub, sleep_random
Send {Click, 1100 970}
return




!o::
Gosub, open_chest
return

!b::         ; start battle and open chest 
Gosub, bosshunt__start_battle
Gosub, open_chest
return



!n::

bosshunt_expanded__warrior_selection(1)

bosshunt_expanded__warrior_selection(6)

bosshunt_expanded__warrior_selection(9)


return