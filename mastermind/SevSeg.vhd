library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sevseg is
    Port ( RSPOT : in std_logic_vector(3 downto 0);
           RCOLOR : in std_logic_vector(3 downto 0);
           Countdown : in std_logic_vector(3 downto 0);
           clk : in STD_LOGIC;
           segment7 : out std_logic_vector(6 downto 0);
           a1, a2, a3, a0 : out STD_LOGIC);
end sevseg;

architecture Behavioral of sevseg is

component ClkDivider Port (ClkIn : in std_logic;
          Divisor : in std_logic_vector(31 downto 0);
          ClkOut : out std_logic);
end component;

signal clkd : std_logic; --ClkDivider bileşeni, clk sinyalini clkd adlı bir sinyale dönüştürür.

begin

Clkman : ClkDivider port map (ClkIn => clk, Divisor => x"00000512", ClkOut => clkd);

Display: process (clkd) is  --Display süreci, clkd sinyaline göre çalışır. Her yükselen kenarda segment7 ekranının ve çıkış sinyallerinin değerlerini günceller.
    variable digit : unsigned (1 downto 0) := "00";
    begin
    if ( rising_edge(clkd) ) then
        if(digit = "00") then --digit değişkeni, 2 bitlik bir unsigned değer olarak tanımlanmıştır ve mevcut basamağı temsil eder. digit değeri artırılarak dönüşümlü olarak segmentleri ve çıkışları günceller.
        --Her digit değeri için, ilgili segmentleri ve çıkışları RCOLOR, RSPOT veya Countdown sinyallerine göre kontrol eder ve segment7, a1, a2, a3, a0 sinyallerini günceller. Segmentlerin gösterdiği desenler, duruma bağlı olarak belirlenir.   
            a0 <= '0';
            a1 <= '1';
            a2 <= '1';
            a3 <= '1';
            case (RCOLOR) is
            when "0000"=> segment7 <="0000001";
            when "0001"=> segment7 <="1001111";
            when "0010"=> segment7 <="0010010";
            when "0011"=> segment7 <="0000110";
            when "0100"=> segment7 <="1001100";
            when "0101"=> segment7 <="0100100";
            when "0110"=> segment7 <="0100000";
            when "0111"=> segment7 <="0001111";
            when "1000"=> segment7 <="0000000";
            when "1001"=> segment7 <="0000100";
            when others => segment7 <="1111111";
            end case;
        elsif(digit = "01") then
            a0 <= '1';
            a1 <= '0';
            a2 <= '1';
            a3 <= '1';
            case (RSPOT) is
            when "0000"=> segment7 <="0000001";
            when "0001"=> segment7 <="1001111";
            when "0010"=> segment7 <="0010010";
            when "0011"=> segment7 <="0000110";
            when "0100"=> segment7 <="1001100";
            when "0101"=> segment7 <="0100100";
            when "0110"=> segment7 <="0100000";
            when "0111"=> segment7 <="0001111";
            when "1000"=> segment7 <="0000000";
            when "1001"=> segment7 <="0000100";
            when others => segment7 <="1111111";
            end case;
        elsif(digit = "10") then
            a0 <= '1';
            a1 <= '1';
            a2 <= '0';
            a3 <= '1';
            case (Countdown) is
            when "0000"=> segment7 <="0000001";
            when "0001"=> segment7 <="1001111";
            when "0010"=> segment7 <="0010010";
            when "0011"=> segment7 <="0000110";
            when "0100"=> segment7 <="1001100";
            when "0101"=> segment7 <="0100100";
            when "0110"=> segment7 <="0100000";
            when "0111"=> segment7 <="0001111";
            when "1000"=> segment7 <="0000000";
            when "1001"=> segment7 <="0000100";
            when others => segment7 <="1111111";
            end case;
        else
            a0 <= '1';
            a1 <= '1';
            a2 <= '1';
            a3 <= '1';
            segment7 <="1111111";
        end if;
        digit := digit + 1;
        
    end if;
    end process Display;
    
end Behavioral;