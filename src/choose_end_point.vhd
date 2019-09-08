----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/05 16:14:30
-- Design Name: 
-- Module Name: choose_end_point - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity choose_end_point is
  Port (clk2,up2,down2,confirm2:in std_logic
        --end_point:out std_logic_vector(4 downto 0) 
        );
end choose_end_point;

architecture Behavioral of choose_end_point is

component choose_end_line
  Port (clk,up,down,confirm:in std_logic;
        end_line:out std_logic_vector(3 downto 0));
end component;

component choose_starting_point
Port (clk1,up1,down1,confirm1:in std_logic;
        starting_point:out std_logic_vector(4 downto 0));
end component;

component choose_starting_line
  Port (clk,up,down,confirm:in std_logic;
        starting_line:out std_logic_vector(3 downto 0));
end component;

signal sig_sl:std_logic_vector(3 downto 0);
signal sig_el:std_logic_vector(3 downto 0);
signal sig_sp:std_logic_vector(4 downto 0);
signal sig_ep:std_logic_vector(4 downto 0);
signal warning:std_logic;  --���棬��ʼվ���յ�վһ�£��ڶ���ģ������Ե�����������...

signal sig_end_1_point:integer range 27 downto 1;--���ź�sig_starting_1_point(��1���ߵ�վ��)�����һ��1~27������
signal sig_end_2_point:integer range 26 downto 1;--���ź�sig_starting_2_point(��1���ߵ�վ��)�����һ��1~26������
signal sig_end_3_point:integer range 29 downto 1;--���ź�sig_starting_3_point(��1���ߵ�վ��)�����һ��1~29������
signal sig_end_4_point:integer range 18 downto 1;--���ź�sig_starting_4_point(��1���ߵ�վ��)�����һ��1~18������

begin

--����ģ��
u1:choose_end_line port map(clk=>clk2,up=>up2,down=>down2,confirm=>confirm2,end_line=>sig_el);
u2:choose_starting_point port map(clk1=>clk2,up1=>up2,down1=>down2,confirm1=>confirm2,starting_point=>sig_sp);
u3:choose_starting_line port map(clk=>clk2,up=>up2,down=>down2,confirm=>confirm2,starting_line=>sig_sl);

choosing:process(clk2,up2,down2,confirm2)
variable temp1:integer range 27 downto 1;
variable temp2:integer range 26 downto 1;
variable temp3:integer range 29 downto 1;
variable temp4:integer range 18 downto 1;
begin

temp1:=8;  --����һ����Ĭ�ϳ�ʼվΪ�½ֿ�
temp2:=12; --����������Ĭ�ϳ�ʼվΪ���й�
temp3:=22; --����������Ĭ�ϳ�ʼվΪ�Ͼ���
temp4:=5;  --�����ĺ���Ĭ�ϳ�ʼվΪ������

case sig_el is --��ͬ����·
when "0001"=>
 if (clk2'event and clk2='1') then
   if (up2='1') then temp1:=temp1+1;end if;
   if (down2='1') then temp1:=temp1-1;end if;
   if (confirm2='1') then sig_end_1_point<=temp1;end if;
   --end_point<=conv_std_logic_vector(sig_end_1_point,5);--������վ��ת����5λ��������
 end if;
 
 when "0010"=>
  if (clk2'event and clk2='1') then
    if (up2='1') then temp2:=temp2+1;end if;
    if (down2='1') then temp2:=temp2-1;end if;
    if (confirm2='1') then sig_end_2_point<=temp2;end if;
    --end_point<=conv_std_logic_vector(sig_end_2_point,5);--������վ��ת����5λ��������
  end if;
  
  when "0011"=>
    if (clk2'event and clk2='1') then
      if (up2='1') then temp3:=temp3+1;end if;
      if (down2='1') then temp3:=temp3-1;end if;
      if (confirm2='1') then sig_end_3_point<=temp3;end if;
      --end_point<=conv_std_logic_vector(sig_end_3_point,5);--������վ��ת����5λ��������
    end if;
    
    when "0100"=>
      if (clk2'event and clk2='1') then
        if (up2='1') then temp4:=temp4+1;end if;
        if (down2='1') then temp2:=temp4-1;end if;
        if (confirm2='1') then sig_end_4_point<=temp4;end if;
        --end_point<=conv_std_logic_vector(sig_end_4_point,5);--������վ��ת����5λ��������
      end if;
      
 end case;
 
if (sig_sl=sig_el and sig_sp=sig_ep) then warning<='1';end if;  --�������ʼ��=�յ��ߣ��ң���ʼվ=�յ�վ���Ǿͷ�������
 
end process choosing;

end Behavioral;
