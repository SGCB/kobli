INSERT INTO subscription_numberpatterns
    (label, displayorder, description, numberingmethod,
    label1, add1, every1, whenmorethan1, setto1, numbering1,
    label2, add2, every2, whenmorethan2, setto2, numbering2,
    label3, add3, every3, whenmorethan3, setto3, numbering3)
VALUES
    ('Número', 1, 'Método simple de numeración', 'No.{X}',
    'Número', 1, 1, 99999, 1, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL),

    ('Volumen, Número, Ejemplar', 2, 'Volumen Número Ejemplar 1', 'Vol.{X}, Número {Y}, Ejemplar {Z}',
    'Volumen', 1, 48, 99999, 1, NULL,
    'Número', 1, 4, 12, 1, NULL,
    'Ejemplar', 1, 1, 4, 1, NULL),

    ('Volumen, Número', 3, 'Volumen Número 1', 'Vol {X}, No {Y}',
    'Volumen', 1, 12, 99999, 1, NULL,
    'Número', 1, 1, 12, 1, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL),

    ('Estacional', 4, 'Estación del año', '{X} {Y}',
    'Estación', 1, 1, 3, 0, 'estación',
    'Año', 1, 4, 99999, 1, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL);
