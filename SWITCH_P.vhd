LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY dots88 IS
PORT(
    clk     : in  std_logic;
    switch  : in  std_logic_vector(5 downto 0);
    dg      : out std_logic_vector(8 downto 1); -- columns
    dr      : out std_logic_vector(8 downto 1); -- rows
    s       : out std_logic_vector(8 downto 1)  -- scan line
);
END dots88;

ARCHITECTURE behavior OF dots88 IS
    SIGNAL scan     : std_logic_vector(2 downto 0) := "000";
    SIGNAL smile_rom: std_logic_vector(8 downto 1) := (others => '0');
    SIGNAL row_data : std_logic_vector(8 downto 1);
    SIGNAL col_data : std_logic_vector(8 downto 1);
BEGIN

    -- Simple scan line rotator (e.g., cycle 8 rows)
    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF scan = "111" THEN
                scan <= "000";
            ELSE
                scan <= scan + 1;
            END IF;
        END IF;
    END PROCESS;

    -- Convert scan index to active-low 1-hot line (e.g., row select)
    PROCESS(scan)
    BEGIN
        CASE scan IS
            WHEN "000" => s <= "10000000";
            WHEN "001" => s <= "01000000";
            WHEN "010" => s <= "00100000";
            WHEN "011" => s <= "00010000";
            WHEN "100" => s <= "00001000";
            WHEN "101" => s <= "00000100";
            WHEN "110" => s <= "00000010";
            WHEN "111" => s <= "00000001";
            WHEN OTHERS => s <= (others => '0');
        END CASE;
    END PROCESS;

    -- Hardcoded smiley face pattern (each row = 8 bits for 8 columns)
    PROCESS(scan, switch)
BEGIN
    CASE scan IS
        WHEN "000" => -- Row 0
            IF switch = "000001" THEN
                row_data <= "00111100"; -- smiley
            ELSIF switch = "000011" THEN
                row_data <= "01100110"; -- heart
            ELSE
                row_data <= (others => '0');
            END IF;

        WHEN "001" => -- Row 1
            IF switch = "000001" THEN
                row_data <= "01000010";
            ELSIF switch = "000011" THEN
                row_data <= "11111111";
            ELSE
                row_data <= (others => '0');
            END IF;

        WHEN "010" =>
            IF switch = "000001" THEN
                row_data <= "10100101";
            ELSIF switch = "000011" THEN
                row_data <= "11111111";
            ELSE
                row_data <= (others => '0');
            END IF;

        WHEN "011" =>
            IF switch = "000001" THEN
                row_data <= "10000001";
            ELSIF switch = "000011" THEN
                row_data <= "11111111";
            ELSE
                row_data <= (others => '0');
            END IF;

        WHEN "100" =>
            IF switch = "000001" THEN
                row_data <= "10100101";
            ELSIF switch = "000011" THEN
                row_data <= "01111110";
            ELSE
                row_data <= (others => '0');
            END IF;

        WHEN "101" =>
            IF switch = "000001" THEN
                row_data <= "10011001";
            ELSIF switch = "000011" THEN
                row_data <= "00111100";
            ELSE
                row_data <= (others => '0');
            END IF;

        WHEN "110" =>
            IF switch = "000001" THEN
                row_data <= "01000010";
            ELSIF switch = "000011" THEN
                row_data <= "00011000";
            ELSE
                row_data <= (others => '0');
            END IF;

        WHEN "111" =>
            IF switch = "000001" THEN
                row_data <= "00111100";
            ELSIF switch = "000011" THEN
                row_data <= "00000000";
            ELSE
                row_data <= (others => '0');
            END IF;

        WHEN OTHERS =>
            row_data <= (others => '0');
    END CASE;
END PROCESS;

    -- Output to matrix
    dg <= row_data;
    dr <= s;

END behavior;
