
UPDATE aerea.matriz_aerea
SET aereo_2023 = cast(replace(replace(TRIM(aereo_2023), '.', ''), ',', '.') as float4);

