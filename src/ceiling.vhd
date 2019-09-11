----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/08 19:46:16
-- Design Name: 
-- Module Name: ceiling - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ceiling is
  Port (clk,up,down,confirm,back:in std_logic;
        led:OUT std_logic_vector(3 downto 0);    --�ĸ�LED�ƣ���ʾ1Ԫ��5Ԫ��10Ԫ��20Ԫ
        switch:IN std_logic_vector(3 downto 0)
        );  --�ĸ����أ�Ͷ��1Ԫ��5Ԫ��10Ԫ��20Ԫ ); 
end ceiling;

architecture Behavioral of ceiling is

--ģ��1 ��������
component no_buffeting
Port (clk,up,down,confirm,back:in std_logic; 
        up0,down0,confirm0,back0:out std_logic
        );--����0�Ķ���ԭ�����ź�,��0������������ź�
end component;

--ģ��2 ѡ��ʼ��·
component choose_starting_line
Port (clk,up,down,confirm:in std_logic;
      starting_line:out integer range 4 downto 1
      );
end component;

--ģ��3 ѡ��ʼվ��
component choose_starting_point
Port (clk1,up1,down1,confirm1:in std_logic;
get_starting_line:in integer range 4 downto 1;
starting_point:out integer);
end component;

--ģ��4 ѡ�յ���·
component choose_end_line
Port (clk,up,down,confirm:in std_logic;
      end_line:out integer range 4 downto 1);
end component;

--ģ��5 ѡ�յ�վ��
component choose_end_point
Port (clk2,up2,down2,confirm2:in std_logic;
      get_starting_line,get_end_line:in integer range 4 downto 1;
      get_starting_point:in integer;
      end_point:out integer);
end component;

--ģ��6 �жϹ���5���޲���
component five_sec_passed
Port (clk,up,down,confirm,back:in std_logic;
        up_to_5sec:out std_logic );
end component;

--ģ��7 ״̬��
component top_entity
Port(
            clk:IN std_logic;      --ʱ���ź�
            confirm:IN std_logic;  --��ť"ȷ��"
            back:IN std_logic;     --��ť"����"
            up:IN std_logic;       --��ť"��һ"
            down:IN std_logic;     --��ť"��һ"
            led:OUT std_logic_vector(3 downto 0);    --�ĸ�LED�ƣ���ʾ1Ԫ��5Ԫ��10Ԫ��20Ԫ
            switch:IN std_logic_vector(3 downto 0);  --�ĸ����أ�Ͷ��1Ԫ��5Ԫ��10Ԫ��20Ԫ
            --num:OUT std_logic_vector( 7 downto 0 );  --�����ģ��ĵڼ�λ��
            --dig:OUT std_logic_vector( 7 downto 0 );  --�����ģ��ľ���ܽ�
            get_up_to_5sec:IN std_logic     
        );   
end component;


signal sig_up0,sig_down0,sig_confirm0,sig_back0:std_logic;

signal starting_line,end_line:integer range 4 downto 1;
signal starting_point,end_point:integer;
signal up_to_5sec:std_logic;

begin

mux1:no_buffeting
port map(
  clk=>clk,
  up=>up,
  down=>down,
  confirm=>confirm,
  back=>back,
  up0=>sig_up0,
  down0=>sig_down0,
  confirm0=>sig_confirm0,
  back0=>sig_back0
);

mux2:choose_starting_line
port map(
  clk=>clk,
  up=>up,
  down=>down,
  confirm=>confirm,
  starting_line=>starting_line
);

mux3:choose_starting_point
port map(
  clk1=>clk,
  up1=>up,
  down1=>down,
  confirm1=>confirm,
  get_starting_line=>starting_line,
  starting_point=>starting_point
);

mux4:choose_end_line
port map(
  clk=>clk,
  up=>up,
  down=>down,
  confirm=>confirm,
  end_line=>end_line
);  
  
mux5:choose_end_point
port map(
  clk2=>clk,
  up2=>up,
  down2=>down,
  confirm2=>confirm,
  get_starting_line=>starting_line,
  get_starting_point=>starting_point,
  get_end_line=>end_line,
  end_point=>end_point
);  
  
mux6:five_sec_passed
port map(
clk=>clk,
up=>up,
down=>down,
confirm=>confirm,
back=>back,
up_to_5sec=>up_to_5sec
);

mux7:top_entity
port map(
clk=>clk,
up=>up,
down=>down,
confirm=>confirm,
back=>back,
led=>led,
switch=>switch,
get_up_to_5sec=>up_to_5sec
);


end Behavioral;