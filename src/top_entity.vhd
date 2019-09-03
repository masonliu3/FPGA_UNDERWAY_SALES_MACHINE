----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/02 19:08:29
-- Design Name: 
-- Module Name: top_entity - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.All;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_entity is
      Port (clk:IN std_logic;      --ʱ���ź�
            datain:IN std_logic;
            confirm:IN std_logic;  --��ť��ȷ����
            back:IN std_logic;     --��ť�����ء�
            up:IN std_logic;       --��ť����һ��
            down:IN std_logic;     --��ť����һ��
            led:OUT std_logic_vector(3 downto 0);    --�ĸ�LED�ƣ���ʾ1Ԫ��5Ԫ��10Ԫ��20Ԫ
            switch:IN std_logic_vector(3 downto 0);  --�ĸ����أ�Ͷ��1Ԫ��5Ԫ��10Ԫ��20Ԫ
            num1:OUT std_logic_vector(3 downto 0);  --��һ�������ģ��ĵڼ�λ��
            num2:OUT std_logic_vector(3 downto 0);  --�ڶ��������ģ��ĵڼ�λ��
            dig1:OUT std_logic_vector(7 downto 0);  --��һ�������ģ��ľ�������
            dig2:OUT std_logic_vector(7 downto 0)   --�ڶ��������ģ��ľ�������
            );
end top_entity;

architecture Behavioral of top_entity is
type state_type is(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10);  --��ʮ��״̬���ȴ���ѡ��ǰվ��·��ѡ��ǰվվ�㣬ѡƱ�ۣ�ѡĿ��վ��·��ѡĿ��վվ�㣬ѡƱ����Ͷ��״̬�������Ʊ״̬���˱ҳɹ�
signal presentstate:state_type;
signal nextstate:state_type;
begin
switch_to_next_state:process(clk)  --��һ��process
begin
if (clk'event and clk='1') then
presentstate<=nextstate;
end if;
end process switch_to_next_state;

change_state_mode:process(confirm,back,up,down,presentstate)  --�ڶ���process
variable var_temp:std_logic;
begin
case presentstate is
  when s1=>  --s1�ȴ�״̬
    if (confirm='1' or back='1' or up='1' or down='1') then
    nextstate<=s2;
    end if;
  when s2=>  --ѡ��ǰվ��·״̬
    if (confirm='1') then nextstate<=s3;
    else if (back='1') then nextstate<=s1;
    end if;
  when s3=>  --ѡ��ǰվվ��״̬
    if (up='1') then nextstate<=s4;end if;
    if (down='1') then nextstate<=s5;end if;
    if (back='1') then nextstate<=s2;
    end if;
    var_temp:='1';
  when s4=>  --ѡƱ��״̬
    if (confirm='1') then nextstate<=s5;end if;
    if (back='1') then nextstate<=s3;end if;
    var_temp:='0';
  when s5=>  --ѡĿ��վ��·״̬
    if (confirm='1') then nextstate<=s6;end if;
    if (back='1') then
      if (var_temp='1') then nextstate<=s3;
      else if (var_temp='0') then nextstate<=s4;
      end if;
    end if;
  when s6=>  --ѡĿ��վվ��״̬
    if (confirm='1') then nextstate<=s7;end if;
    if (back='1') then nextstate<=s5;end if;
  when s7=>  --ѡƱ��״̬
    if (confirm='1') then nextstate<=s8;end if;
    if (back='1') then nextstate<=s6;end if;
  when s8=>  --Ͷ��״̬
    if (back='1') then nextstate<=s10;  --��ûд���Ǯ������һ��״̬��s9�������Ʊ״̬�������
    end if; 
    if (switch="0001") then led<="0001";end if;
    if (switch="0010") then led<="0010";end if;
    if (switch="0100") then led<="0100";end if;
    if (switch="1000") then led<="1000";end if;
  when others=>   --��ʼ״̬��s1
    nextstate<=s1;
end case; --case�ﻹ����s9��s10���˱ҳɹ�״̬����s10��s1�����
end process change_state_mode;
end Behavioral;
