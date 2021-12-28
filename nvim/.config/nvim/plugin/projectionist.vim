let g:projectionist_heuristics = {
	\'*': {
	\	'src/*.c': {
	\		'alternate': [
	\			'src/{}.h',
	\			'tests/{}.test.c'
	\		],
	\		'type': 'source'
	\	},
	\	'src/*.h': {
	\		'alternate': [
	\			'tests/{}.test.c',
	\			'src/{}.c'
	\		],
	\		'type': 'header'
	\	},
	\	'tests/*.test.c': {
	\		'alternate': [
	\			'src/{}.c',
	\			'src/{}.h',
	\		],
	\		'type': 'test'
	\	},
	\ }
\}
