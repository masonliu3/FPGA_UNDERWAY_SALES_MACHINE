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
            --num:OUT std_logic_vector( 7 downto 0 );  --�����ģ��ĵڼ�λ��
            --dig:OUT std_logic_vector( 7 downto 0 );  --�����ģ��ľ���ܽ�
            get_up_to_5sec:IN std_logic     
        );    
end top_entity;

architecture Behavioral of top_entity is

type state_type is ( s1, --�ȴ�
                s2, --ѡ��ǰվ·��
                s3, --ѡ��ǰվ��վ��
                s4, --ѡƱ��
                s5, --ѡĿ��վ·��
                s6, --ѡĿ��վվ��
                s7, --ѡƱ��
                s8, --Ͷ��
                s9, --�����Ʊ
                s10 --�˱�
                );
signal presentstate:state_type;
signal nextstate:state_type;
begin
led <= switch;
--num <= "00000000";
--dig <= "00000000";

switch_to_next_state:process(clk)  --��һ��process
begin
if (clk'event and clk='1') then
presentstate<=nextstate;
end if;
end process switch_to_next_state;

change_state_mode:process(confirm,back,up,down,presentstate)  --�ڶ���process

begin

case presentstate is

  when s1=>  --s1�ȴ�״̬
    if (rising_edge(confirm) or rising_edge(back) or rising_edge(up) or rising_edge(down)) then
    nextstate<=s2;
    end if;

  when s2=>  --ѡ��ǰվ��·״̬
    if (rising_edge(confirm)) then nextstate<=s3;end if;
    if (rising_edge(back)) then nextstate<=s1;end if;

  when s3=>  --ѡ��ǰվվ��״̬
    if (rising_edge(up)) then nextstate<=s4;end if;
    if (rising_edge(down)) then nextstate<=s5;end if;
    if (rising_edge(back)) then nextstate<=s2;
    end if;

    --flag1<='1';

  when s4=>  --ѡƱ��״̬
    if (rising_edge(confirm)) then nextstate<=s9;end if;  --ѡƱ��ȷ�Ϻ�ֱ�������Ʊ
    if (rising_edge(back)) then nextstate<=s3;end if;
    --flag1<='0';

  when s5=>  --ѡĿ��վ��·״̬
    if (rising_edge(confirm)) then nextstate<=s6;end if;
    if (rising_edge(back)) then nextstate<=s3;
      --if (flag1='1') then nextstate<=s3;
      --else if (flag1='0') then nextstate<=s4;
      --end if;
      --end if;
    end if;

  when s6=>  --ѡĿ��վվ��״̬
    if (rising_edge(confirm)) then nextstate<=s7;end if;
    if (rising_edge(back)) then nextstate<=s5;end if;

  when s7=>  --ѡƱ��״̬
    if (rising_edge(confirm)) then nextstate<=s8;end if;
    if (rising_edge(back)) then nextstate<=s6;end if;
    
  when s8=>  --Ͷ��״̬
    if (rising_edge(confirm)) then 
      if (real_pay>=should_pay) then nextstate<=s9; 
      else nextstate<=s10;
      end if;
    end if;
    if (rising_edge(back)) then nextstate<=s10;  
    end if; 

  when s9=>  --�����Ʊ״̬
    if (get_up_to_5sec='1') then nextstate<=s1;end if;  --�������5��û�����������ȴ�״̬

  when s10=>  --�˱�״̬
    if (get_up_to_5sec='1') then nextstate<=s1;end if;  --�������5��û�����������ȴ�״̬

  when others=>   --��ʼ״̬��s1
    nextstate<=s1;

end case; 

end process change_state_mode;

end Behavioral;

