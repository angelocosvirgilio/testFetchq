SELECT * 
FROM fetchq.doc_append('q1', '{"foo": 1}', 0, 0)
CROSS JOIN generate_series(1,:rows_number) as gs(i);