library IEEE;
use IEEE.STD_LOGIC_1164.ALL;--����ʹ��STD_LOGIC,STD_LOGIC_VECTOR
use IEEE.STD_LOGIC_ARITH.ALL;--��������ת��
use IEEE.STD_LOGIC_UNSIGNED.All;--��������ת��

entity top_entity is
    Port(
            clk:IN std_logic;      --ʱ���ź�
            confirm:IN std_logic;  --��ť"ȷ��"
            back:IN std_logic;     --��ť"����"
            up:IN std_logic;       --��ť"��һ"
            down:IN std_logic;     --��ť"��һ"
            led:OUT std_logic_vector(3 downto 0);    --�ĸ�LED�ƣ���ʾ1Ԫ��5Ԫ��10Ԫ��20Ԫ
            switch:IN std_logic_vector(3 downto 0);  --�ĸ����أ�Ͷ��1Ԫ��5Ԫ��10Ԫ��20Ԫ
            num:OUT std_logic_vector( 7 downto 0 );  --�����ģ��ĵڼ�λ��
            dig:OUT std_logic_vector( 7 downto 0 )  --�����ģ��ľ���ܽ�     
);    
end top_entity;

architecture Behavioral of top_entity is
type state_type is ( S1, --�ȴ�
                S2, --ѡ��ǰվ·��
                s3, --ѡ��ǰվ��վ��
                s4, --ѡƱ��
                s5, --ѡĿ��վ·��
                s6, --ѡĿ��վվ��
                s7, --ѡƱ��
                s8, --Ͷ��
                s9, --�����Ʊ
                s10 --Ͷ�ҳɹ���
                );
signal presentstate:state_type;
signal nextstate:state_type;
begin
led <= switch;
num <= "00000000";
dig <= "00000000";
switch_to_next_state:process(clk)  --��һ��process
begin
if (clk'event and clk='1') then
presentstate<=nextstate;
end if;
end process switch_to_next_state;
end Behavioral;

