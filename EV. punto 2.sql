WITH gdp AS (
    SELECT yv."value" AS gdp_value
    FROM country_info ci
    JOIN yearly_value yv ON ci."id" = yv.country_info_id
    JOIN "indicator" i ON yv.indicator_id = i."id"
    WHERE ci.num_ci = '4877232' 
      AND i.indicator_code = 'NY.GDP.PCAP.KD' 
      AND yv."year" = 2005 
      AND ci."id" = 75
),
population AS (
    SELECT yv."value" AS pop_value
    FROM country_info ci
    JOIN yearly_value yv ON ci."id" = yv.country_info_id
    JOIN "indicator" i ON yv.indicator_id = i."id"
    WHERE ci.num_ci = '4877232' 
      AND i.indicator_code = 'SP.POP.TOTL' 
      AND yv."year" = 2005 
      AND ci."id" = 75
),
gini AS (
    SELECT yv."value" AS gini_value
    FROM country_info ci
    JOIN yearly_value yv ON ci."id" = yv.country_info_id
    JOIN "indicator" i ON yv.indicator_id = i."id"
    WHERE ci.num_ci = '4877232' 
      AND i.indicator_code = 'SI.POV.GINI' 
      AND yv."year" = 2005 
      AND ci."id" = 75
),
poverty AS (
    SELECT yv."value" AS poverty_value
    FROM country_info ci
    JOIN yearly_value yv ON ci."id" = yv.country_info_id
    JOIN "indicator" i ON yv.indicator_id = i."id"
    WHERE ci.num_ci = '4877232' 
      AND i.indicator_code = 'SI.POV.LMIC.GP' 
      AND yv."year" = 2005 
      AND ci."id" = 75
)
SELECT ci."id", ci.country_code, yv."id", yv."year" AS anio, 
  (gdp.gdp_value / population.pop_value) * 
  (1 - gini.gini_value) * 
  (1 - poverty.poverty_value) AS IPS,
  i."id"
FROM country_info ci
JOIN yearly_value yv ON ci."id" = yv.country_info_id
JOIN "indicator" i ON yv.indicator_id = i."id"
CROSS JOIN gdp
CROSS JOIN population
CROSS JOIN gini
CROSS JOIN poverty
WHERE ci.num_ci = '4877232' 
  AND yv."year" = 2005 
  AND ci."id" = 75
ORDER BY ci.country_code, yv."year";