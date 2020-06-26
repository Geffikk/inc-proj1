-- fsm.vhd: Finite State Machine
-- Author(s): Maros Geffert <xgeffe00@stud.fit.vutbr.cz>
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------

entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------

architecture behavioral of fsm is
   type t_state is (N1, N2, N3, N4 , N5, N6, N7, N8, N9, N10, R1,
   		    N2_1, N2_2, N2_3, N2_4, N2_5, N2_6, N2_7, N2_8, N2_9, R2,
   		    WRONG, ACCESS_DENIED, ACCESS_ALLOWED, FINISH);
   signal present_state, next_state : t_state;

begin

-- -------------------------------------------------------

sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state 	<= N1;
   elsif (CLK'event AND CLK = '1') then
      present_state 	<= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------

next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is

   -- - - - - - - - - NUM 1 - CODE 1 - - - - - - - - - -

   when N1 =>
      if (KEY(1)= '1') then	  
       	 next_state 	<= N2;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N1; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - -
   -- - - - - - - - - NUM 2 - CODE 1 - - - - - - - - - -

   when N2 =>
      if (KEY(9)= '1') then	  
       	 next_state 	<= N3;
      elsif (KEY(3)= '1') then
         next_state 	<= N2_1;	      
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 3 - CODE 1 - - - - - - - - - -
   when N3 =>
      if (KEY(7)= '1') then	  
      	 next_state	 <= N4;
      elsif (KEY(15) = '1') then
         next_state 	 <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state	 <= WRONG;
      else
	 next_state	 <= N3; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 4 - CODE 1 - - - - - - - - - -

   when N4 =>
      if (KEY(1)= '1') then	  
      	 next_state 	<= N5;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N4; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 5 - CODE 1 - - - - - - - - - -

   when N5 =>
      if (KEY(8)= '1') then	  
      	 next_state 	<= N6;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N5; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
      -- - - - - - - - - NUM 6 - CODE 1 - - - - - - - - - 
   when N6 =>
      if (KEY(9)= '1') then	  
      	 next_state 	<= N7;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N6; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 7 - CODE 1 - - - - - - - - - -

   when N7 =>
      if (KEY(2)= '1') then	  
      	 next_state 	<= N8;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N7; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 8 - CODE 1 - - - - - - - - - -

   when N8 =>
      if (KEY(0)= '1') then	  
      	 next_state 	<= N9;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N8; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 9 - CODE 1 - - - - - - - - - -

   when N9 =>
      if (KEY(5)= '1') then	  
      	 next_state 	<= N10;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N9; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 10 - CODE 1 - - - - - - - - - -

   when N10 =>
      if (KEY(7)= '1') then	  
      	 next_state 	<= R1;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N10; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - - RESULT - CODE 1 - - - - - - - - -

   when R1 =>
      if (KEY(15) = '1') then	   
      	next_state 	<= ACCESS_ALLOWED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	next_state 	<= WRONG;
      else
	next_state 	<= R1;
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 3 - CODE 2 - - - - - - - - - - (Prve dve cisla su zahrnute v predchadzajucich podmienkach)

   when N2_1 =>
      if (KEY(8)= '1') then	  
      	 next_state 	<= N2_2;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_1; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 4 - CODE 2 - - - - - - - - - -

   when N2_2 =>
      if (KEY(0)= '1') then	  
      	 next_state 	<= N2_3;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_2; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 5 - CODE 2 - - - - - - - - - -

   when N2_3 =>
      if (KEY(3)= '1') then	  
      	 next_state 	<= N2_4;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_3; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 6 - CODE 2 - - - - - - - - - -

   when N2_4 =>
      if (KEY(2)= '1') then	  
      	 next_state 	<= N2_5;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_4; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 7 - CODE 2 - - - - - - - - - -

   when N2_5 =>
      if (KEY(4)= '1') then	  
      	 next_state 	<= N2_6;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_5; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 8 - CODE 2 - - - - - - - - - -

   when N2_6 =>
      if (KEY(4)= '1') then	  
      	 next_state 	<= N2_7;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_6; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - -    
   -- - - - - - - - - NUM 9 - CODE 2 - - - - - - - - - -

   when N2_7 =>
      if (KEY(4)= '1') then	  
      	 next_state 	<= N2_8;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_7; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 10 - CODE 2 - - - - - - - - - -

   when N2_8 =>
      if (KEY(0)= '1') then	  
      	 next_state 	<= N2_9;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_8; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - NUM 11 - CODE 2 - - - - - - - - - -

   when N2_9 =>
      if (KEY(0)= '1') then	  
      	 next_state 	<= R2;
      elsif (KEY(15) = '1') then
         next_state 	<= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 next_state 	<= WRONG;
      else
	 next_state 	<= N2_9; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - - - - RESULT - CODE 1 - - - - - - - - -

   when R2 =>
      if (KEY(15) = '1') then	   
      	next_state 	<= ACCESS_ALLOWED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	next_state 	<= WRONG;
      else
	next_state 	<= R2;
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - - 
   -- - - - - - - WRONG CODE KEY  - - - - - - - - - - - -

   when WRONG =>
      next_state 	<= WRONG;
      if (KEY(15) = '1') then
	next_state 	<= ACCESS_DENIED;
      end if;

   -- - - - - - - ACCESS DENIED - - - - - - - - - - - - - 

   when ACCESS_DENIED =>
      next_state 	<= ACCESS_DENIED;
      if (CNT_OF = '1') then
        next_state 	<= FINISH;
      end if;

   -- - - - - - - ACCESS ALLOWED - - - - - - - - - - - - 

   when ACCESS_ALLOWED =>
      next_state 	<= ACCESS_ALLOWED;
      if (CNT_OF = '1') then
         next_state 	<= FINISH;
      end if;	   

   -- - - - - - - - -  FINISH - - - - - - - - - - - - - -

   when FINISH =>
      next_state 	<= FINISH;
      if (KEY(15) = '1') then
         next_state 	<= N1; 
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - - - - - -

   when others =>
      next_state 	<= N1;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
-- -------------------------------------------------------

output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is

   -- - - - - - DEFINITION OF RESULT - - - - - - -

   when ACCESS_DENIED =>
         FSM_CNT_CE     <= '1';
      	 FSM_MX_LCD	<= '1';

         if (CNT_OF = '0') then
            FSM_LCD_WR     <= '1';
         end if;

   -- - - - - - - - - - - - - - - - - - - - - - -

   when ACCESS_ALLOWED =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_MX_MEM     <= '1';

      if (CNT_OF = '0') then
	 FSM_LCD_WR	<= '1';
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - -

   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - -

   when others =>
      if (KEY(15) = '1') then
	 FSM_LCD_CLR	<= '1';
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 FSM_LCD_WR	<= '1';
      end if;
   end case;
end process output_logic;

end architecture behavioral;

