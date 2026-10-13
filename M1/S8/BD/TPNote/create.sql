DROP TABLE IF EXISTS valstat CASCADE;
DROP TABLE IF EXISTS libellestat CASCADE;
DROP TABLE IF EXISTS communes CASCADE;
DROP TABLE IF EXISTS departements CASCADE;
DROP TABLE IF EXISTS regions CASCADE;

create table regions(
    idr int constraint pk_regions primary key, 
    libelle varchar(250) constraint nom_region_null not null
);

create table departements(
    idd int constraint pk_dep primary key,
    idr int constraint fk_reg_dep references regions(idr) constraint idr_dep_null not null,
    libelle varchar(250) constraint nom_dep_null not null
);

create table communes(
    idc int constraint pk_com primary key, 
    idd int constraint fk_dep_com references departements(idd) constraint idd_com_null not null,
    libelle varchar(250) constraint nom_com_null not null,
    codgeo char(5) constraint codgeo_com_null not null
);

create table libellestat(
    idl int constraint pk_libelle_stat primary key,  
    libelle varchar(200) constraint libelle_stat_null not null,
    estintervalle boolean constraint estintervalle_stat_null not null
);

create table valstat(
    idc int constraint fk_com_valstat references communes(idc),
    idl int constraint fk_libelle_valstat references libellestat(idl),
    AnneDebut int,
    AnneeFin int,
    valeur float  constraint estintervalle_stat_null not null  constraint val_positif check (valeur >= 0),
    constraint pk_valstat primary key(idc, idl, AnneDebut)
);

insert into regions values(75, 'Nouvelle-Aquitaine');

insert into departements values
(16, 75, 'Charente'),
(17, 75, 'Charente-Maritime'),
(19, 75, 'Corrèze'),
(23, 75, 'Creuse'),
(24, 75, 'Dordogne'),
(33, 75, 'Gironde'),
(40, 75, 'Landes'),
(47, 75, 'Lot-et-Garonne'),
(64, 75, 'Pyrénées-Atlantiques'),
(79, 75, 'Deux-Sèvres'),
(86, 75, 'Vienne'),
(87, 75, 'Haute-Vienne');

insert into libellestat values
(1, 'Population', false),
(2, 'Nombre de naissance', true),
(3, 'Nombre de logements vacants', false);


COPY public.communes (idc, idd, libelle, codgeo) FROM stdin;
1	16	Abzac	16001
2	16	Les Adjots	16002
3	16	Agris	16003
4	16	Aigre	16005
5	16	Alloue	16007
6	16	Ambérac	16008
7	16	Ambernac	16009
8	16	Anais	16011
9	16	Angeac-Champagne	16012
10	16	Angeac-Charente	16013
11	16	Angeduc	16014
12	16	Angoulême	16015
13	16	Ansac-sur-Vienne	16016
14	16	Ars	16018
15	16	Asnières-sur-Nouère	16019
16	16	Aubeterre-sur-Dronne	16020
17	16	Aunac-sur-Charente	16023
18	16	Aussac-Vadalle	16024
19	16	Baignes-Sainte-Radegonde	16025
20	16	Balzac	16026
21	16	Barbezières	16027
22	16	Barbezieux-Saint-Hilaire	16028
23	16	Bardenac	16029
24	16	Barret	16030
25	16	Barro	16031
26	16	Bassac	16032
27	16	Bazac	16034
28	16	Beaulieu-sur-Sonnette	16035
29	16	Bécheresse	16036
30	16	Bellon	16037
31	16	Benest	16038
32	16	Bernac	16039
33	16	Berneuil	16040
34	16	Bessac	16041
35	16	Bessé	16042
36	16	Bioussac	16044
37	16	Birac	16045
38	16	Coteaux-du-Blanzacais	16046
39	16	Blanzaguet-Saint-Cybard	16047
40	16	Boisbreteau	16048
41	16	Bonnes	16049
42	16	Bonneuil	16050
43	16	Bors (Canton de Tude-et-Lavalette)	16052
44	16	Bors (Canton de Charente-Sud)	16053
45	16	Le Bouchage	16054
46	16	Bouëx	16055
47	16	Bourg-Charente	16056
48	16	Bouteville	16057
49	16	Boutiers-Saint-Trojan	16058
50	16	Brettes	16059
51	16	Bréville	16060
52	16	Brie	16061
53	16	Brie-sous-Barbezieux	16062
54	16	Brie-sous-Chalais	16063
55	16	Brigueuil	16064
56	16	Brillac	16065
57	16	Brossac	16066
58	16	Bunzac	16067
59	16	Cellefrouin	16068
60	16	Cellettes	16069
61	16	Chabanais	16070
62	16	Chabrac	16071
63	16	Chadurie	16072
64	16	Chalais	16073
65	16	Challignac	16074
66	16	Champagne-Vigny	16075
67	16	Champagne-Mouton	16076
68	16	Champmillon	16077
69	16	Champniers	16078
70	16	Chantillac	16079
71	16	La Chapelle	16081
72	16	Boisné-La Tude	16082
73	16	Charmé	16083
74	16	Charras	16084
75	16	Chasseneuil-sur-Bonnieure	16085
76	16	Chassenon	16086
77	16	Chassiecq	16087
78	16	Chassors	16088
79	16	Châteaubernard	16089
80	16	Châteauneuf-sur-Charente	16090
81	16	Châtignac	16091
82	16	Chazelles	16093
83	16	Chenon	16095
84	16	Cherves-Châtelars	16096
85	16	Val-de-Cognac	16097
86	16	La Chèvrerie	16098
87	16	Chillac	16099
88	16	Chirac	16100
89	16	Claix	16101
90	16	Cognac	16102
91	16	Combiers	16103
92	16	Condac	16104
93	16	Condéon	16105
94	16	Confolens	16106
95	16	Coulgens	16107
96	16	Coulonges	16108
97	16	Courbillac	16109
98	16	Courcôme	16110
99	16	Courgeac	16111
100	16	Courlac	16112
101	16	La Couronne	16113
102	16	Couture	16114
103	16	Criteuil-la-Magdeleine	16116
104	16	Curac	16117
105	16	Deviat	16118
106	16	Dignac	16119
107	16	Dirac	16120
108	16	Douzat	16121
109	16	Ébréon	16122
110	16	Échallat	16123
111	16	Écuras	16124
112	16	Édon	16125
113	16	Empuré	16127
114	16	Épenède	16128
115	16	Les Essards	16130
116	16	Esse	16131
117	16	Étagnac	16132
118	16	Étriac	16133
119	16	Exideuil-sur-Vienne	16134
120	16	Eymouthiers	16135
121	16	La Faye	16136
122	16	Feuillade	16137
123	16	Fléac	16138
124	16	Fleurac	16139
125	16	Fontenille	16141
126	16	La Forêt-de-Tessé	16142
127	16	Fouquebrune	16143
128	16	Fouqueure	16144
129	16	Foussignac	16145
130	16	Garat	16146
131	16	Genac-Bignac	16148
132	16	Gensac-la-Pallue	16150
133	16	Genté	16151
134	16	Gimeux	16152
135	16	Mainxe-Gondeville	16153
136	16	Gond-Pontouvre	16154
137	16	Les Gours	16155
138	16	Le Grand-Madieu	16157
139	16	Grassac	16158
140	16	Guimps	16160
141	16	Guizengeard	16161
142	16	Gurat	16162
143	16	Hiersac	16163
144	16	Hiesse	16164
145	16	Houlette	16165
146	16	L'Isle-d'Espagnac	16166
147	16	Jarnac	16167
148	16	Jauldes	16168
149	16	Javrezac	16169
150	16	Juignac	16170
151	16	Juillac-le-Coq	16171
152	16	Juillé	16173
153	16	Julienne	16174
154	16	Val des Vignes	16175
155	16	Lachaise	16176
156	16	Ladiville	16177
157	16	Lagarde-sur-le-Né	16178
158	16	Laprade	16180
159	16	Lessac	16181
160	16	Lesterps	16182
161	16	Lésignac-Durand	16183
162	16	Lichères	16184
163	16	Ligné	16185
164	16	Lignières-Ambleville	16186
165	16	Linars	16187
166	16	Le Lindois	16188
167	16	Londigny	16189
168	16	Longré	16190
169	16	Lonnes	16191
170	16	Terres-de-Haute-Charente	16192
171	16	Louzac-Saint-André	16193
172	16	Lupsault	16194
173	16	Lussac	16195
174	16	Luxé	16196
175	16	La Magdeleine	16197
176	16	Magnac-lès-Gardes	16198
177	16	Magnac-sur-Touvre	16199
178	16	Maine-de-Boixe	16200
179	16	Mainzac	16203
180	16	Bellevigne	16204
181	16	Manot	16205
182	16	Mansle-les-Fontaines	16206
183	16	Marcillac-Lanville	16207
184	16	Mareuil	16208
185	16	Marillac-le-Franc	16209
186	16	Marsac	16210
187	16	Marthon	16211
188	16	Massignac	16212
189	16	Mazerolles	16213
190	16	Médillac	16215
191	16	Mérignac	16216
192	16	Merpins	16217
193	16	Mesnac	16218
194	16	Les Métairies	16220
195	16	Mons	16221
196	16	Montboyer	16222
197	16	Montbron	16223
198	16	Montmérac	16224
199	16	Montembœuf	16225
200	16	Montignac-le-Coq	16227
201	16	Montjean	16229
202	16	Montmoreau	16230
203	16	Montrollet	16231
204	16	Mornac	16232
205	16	Mosnac-Saint-Simeux	16233
206	16	Moulidars	16234
207	16	Mouthiers-sur-Boëme	16236
208	16	Mouton	16237
209	16	Mouzon	16239
210	16	Nabinaud	16240
211	16	Nanclars	16241
212	16	Nanteuil-en-Vallée	16242
213	16	Nercillac	16243
214	16	Nersac	16244
215	16	Nieuil	16245
216	16	Nonac	16246
217	16	Oradour	16248
218	16	Oradour-Fanais	16249
219	16	Orgedeuil	16250
220	16	Oriolles	16251
221	16	Orival	16252
222	16	Paizay-Naudouin-Embourie	16253
223	16	Palluaud	16254
224	16	Parzac	16255
225	16	Passirac	16256
226	16	Pérignac	16258
227	16	Pillac	16260
228	16	Les Pins	16261
229	16	Plassac-Rouffiac	16263
230	16	Pleuville	16264
231	16	Poullignac	16267
232	16	Poursac	16268
233	16	Pranzac	16269
234	16	Pressignac	16270
235	16	Puymoyen	16271
236	16	Puyréaux	16272
237	16	Raix	16273
238	16	Ranville-Breuillaud	16275
239	16	Reignac	16276
240	16	Réparsac	16277
241	16	Rioux-Martin	16279
242	16	Rivières	16280
243	16	La Rochefoucauld-en-Angoumois	16281
244	16	La Rochette	16282
245	16	Ronsenac	16283
246	16	Rouffiac	16284
247	16	Rougnac	16285
248	16	Rouillac	16286
249	16	Roullet-Saint-Estèphe	16287
250	16	Roussines	16289
251	16	Rouzède	16290
252	16	Ruelle-sur-Touvre	16291
253	16	Ruffec	16292
254	16	Saint-Adjutory	16293
255	16	Saint-Amant-de-Boixe	16295
256	16	Graves-Saint-Amant	16297
257	16	Saint-Amant-de-Nouère	16298
258	16	Val-de-Bonnieure	16300
259	16	Saint-Aulais-la-Chapelle	16301
260	16	Saint-Avit	16302
261	16	Saint-Bonnet	16303
262	16	Saint-Brice	16304
263	16	Saint-Christophe	16306
264	16	Saint-Ciers-sur-Bonnieure	16307
265	16	Saint-Claud	16308
266	16	Saint-Coutant	16310
267	16	Saint-Cybardeaux	16312
268	16	Saint-Félix	16315
269	16	Saint-Fort-sur-le-Né	16316
270	16	Saint-Fraigne	16317
271	16	Saint-Front	16318
272	16	Saint-Genis-d'Hiersac	16320
273	16	Saint-Georges	16321
274	16	Saint-Germain-de-Montbron	16323
275	16	Saint-Gourson	16325
276	16	Saint-Groux	16326
277	16	Saint-Laurent-de-Céris	16329
278	16	Saint-Laurent-de-Cognac	16330
279	16	Saint-Laurent-des-Combes	16331
280	16	Saint-Martial	16334
281	16	Saint-Martin-du-Clocher	16335
282	16	Saint-Mary	16336
283	16	Saint-Maurice-des-Lions	16337
284	16	Saint-Médard	16338
285	16	Val-d'Auge	16339
286	16	Saint-Même-les-Carrières	16340
287	16	Saint-Michel	16341
288	16	Saint-Palais-du-Né	16342
289	16	Saint-Preuil	16343
290	16	Saint-Quentin-sur-Charente	16345
291	16	Saint-Quentin-de-Chalais	16346
292	16	Saint-Romain	16347
293	16	Saint-Saturnin	16348
294	16	Sainte-Sévère	16349
295	16	Saint-Séverin	16350
296	16	Saint-Simon	16352
297	16	Saint-Sornin	16353
298	16	Sainte-Souline	16354
299	16	Saint-Sulpice-de-Ruffec	16356
300	16	Saint-Vallier	16357
301	16	Saint-Yrieix-sur-Charente	16358
302	16	Salles-d'Angles	16359
303	16	Salles-de-Barbezieux	16360
304	16	Salles-de-Villefagnan	16361
305	16	Salles-Lavalette	16362
306	16	Saulgond	16363
307	16	Sauvagnac	16364
308	16	Sauvignac	16365
309	16	Segonzac	16366
310	16	Sers	16368
311	16	Sigogne	16369
312	16	Sireuil	16370
313	16	Souffrignac	16372
314	16	Souvigné	16373
315	16	Soyaux	16374
316	16	Suaux	16375
317	16	La Tâche	16377
318	16	Taizé-Aizie	16378
319	16	Taponnat-Fleurignac	16379
320	16	Le Tâtre	16380
321	16	Theil-Rabier	16381
322	16	Torsac	16382
323	16	Tourriers	16383
324	16	Touvérac	16384
325	16	Touvre	16385
326	16	Triac-Lautrait	16387
327	16	Trois-Palis	16388
328	16	Turgon	16389
329	16	Tusson	16390
330	16	Valence	16392
331	16	La Boixe	16393
332	16	Vaux-Lavalette	16394
333	16	Vaux-Rouillac	16395
334	16	Ventouse	16396
335	16	Verdille	16397
336	16	Verneuil	16398
337	16	Verrières	16399
338	16	Verteuil-sur-Charente	16400
339	16	Vervant	16401
340	16	Vibrac	16402
341	16	Le Vieux-Cérier	16403
342	16	Vieux-Ruffec	16404
343	16	Vignolles	16405
344	16	Moulins-sur-Tardoire	16406
345	16	Villebois-Lavalette	16408
346	16	Villefagnan	16409
347	16	Villejoubert	16412
348	16	Villiers-le-Roux	16413
349	16	Villognon	16414
350	16	Vindelle	16415
351	16	Vitrac-Saint-Vincent	16416
352	16	Vœuil-et-Giget	16418
353	16	Vouharte	16419
354	16	Voulgézac	16420
355	16	Vouthon	16421
356	16	Vouzan	16422
357	16	Xambes	16423
358	16	Yviers	16424
359	16	Yvrac-et-Malleyrand	16425
360	17	Agudelle	17002
361	17	Aigrefeuille-d'Aunis	17003
362	17	Île-d'Aix	17004
363	17	Allas-Bocage	17005
364	17	Allas-Champagne	17006
365	17	Anais	17007
366	17	Andilly	17008
367	17	Angliers	17009
368	17	Angoulins	17010
369	17	Annepont	17011
370	17	Annezay	17012
371	17	Antezant-la-Chapelle	17013
372	17	Arces	17015
373	17	Archiac	17016
374	17	Archingeay	17017
375	17	Ardillières	17018
376	17	Ars-en-Ré	17019
377	17	Arthenac	17020
378	17	Arvert	17021
379	17	Asnières-la-Giraud	17022
380	17	Aujac	17023
381	17	Aulnay	17024
382	17	Aumagne	17025
383	17	Authon-Ébéon	17026
384	17	Avy	17027
385	17	Aytré	17028
386	17	Bagnizeau	17029
387	17	Balanzac	17030
388	17	Ballans	17031
389	17	Ballon	17032
390	17	La Barde	17033
391	17	Barzan	17034
392	17	Bazauges	17035
393	17	Beaugeay	17036
394	17	Beauvais-sur-Matha	17037
395	17	Bedenac	17038
396	17	Belluire	17039
397	17	Benon	17041
398	17	Bercloux	17042
399	17	Bernay-Saint-Martin	17043
400	17	Berneuil	17044
401	17	Beurlay	17045
402	17	Bignay	17046
403	17	Biron	17047
404	17	Blanzac-lès-Matha	17048
405	17	Blanzay-sur-Boutonne	17049
406	17	Bois	17050
407	17	Le Bois-Plage-en-Ré	17051
408	17	Boisredon	17052
409	17	Bords	17053
410	17	Boresse-et-Martron	17054
411	17	Boscamnant	17055
412	17	Bougneau	17056
413	17	Bouhet	17057
414	17	Bourcefranc-le-Chapus	17058
415	17	Bourgneuf	17059
416	17	Boutenac-Touvent	17060
417	17	Bran	17061
418	17	Bresdon	17062
419	17	Breuil-la-Réorte	17063
420	17	Breuillet	17064
421	17	Breuil-Magné	17065
422	17	Brie-sous-Archiac	17066
423	17	Brie-sous-Matha	17067
424	17	Brie-sous-Mortagne	17068
425	17	Brives-sur-Charente	17069
426	17	Brizambourg	17070
427	17	La Brousse	17071
428	17	Burie	17072
429	17	Bussac-sur-Charente	17073
430	17	Bussac-Forêt	17074
431	17	Cabariot	17075
432	17	Celles	17076
433	17	Cercoux	17077
434	17	Chadenac	17078
435	17	Chaillevette	17079
436	17	Chambon	17080
437	17	Chamouillac	17081
438	17	Champagnac	17082
439	17	Champagne	17083
440	17	Champagnolles	17084
441	17	Champdolent	17085
442	17	Chaniers	17086
443	17	Chantemerle-sur-la-Soie	17087
444	17	La Chapelle-des-Pots	17089
445	17	Charron	17091
446	17	Chartuzac	17092
447	17	Le Château-d'Oléron	17093
448	17	Châtelaillon-Plage	17094
449	17	Chatenet	17095
450	17	Chaunac	17096
451	17	Le Chay	17097
452	17	Chenac-Saint-Seurin-d'Uzet	17098
453	17	Chepniers	17099
454	17	Chérac	17100
455	17	Cherbonnières	17101
456	17	Chermignac	17102
457	17	Chevanceaux	17104
458	17	Chives	17105
459	17	Cierzac	17106
460	17	Ciré-d'Aunis	17107
461	17	Clam	17108
462	17	Clavette	17109
463	17	Clérac	17110
464	17	Clion	17111
465	17	La Clisse	17112
466	17	La Clotte	17113
467	17	Coivert	17114
468	17	Colombiers	17115
469	17	Consac	17116
470	17	Contré	17117
471	17	Corignac	17118
472	17	Corme-Écluse	17119
473	17	Corme-Royal	17120
474	17	La Couarde-sur-Mer	17121
475	17	Coulonges	17122
476	17	Courant	17124
477	17	Courcelles	17125
478	17	Courcerac	17126
479	17	Courçon	17127
480	17	Courcoury	17128
481	17	Courpignac	17129
482	17	Coux	17130
483	17	Cozes	17131
484	17	Cram-Chaban	17132
485	17	Cravans	17133
486	17	Crazannes	17134
487	17	Cressé	17135
488	17	Croix-Chapeau	17136
489	17	La Croix-Comtesse	17137
490	17	Dampierre-sur-Boutonne	17138
491	17	Dœuil-sur-le-Mignon	17139
492	17	Dolus-d'Oléron	17140
493	17	Dompierre-sur-Charente	17141
494	17	Dompierre-sur-Mer	17142
495	17	Le Douhet	17143
496	17	Échebrune	17145
497	17	Échillais	17146
498	17	Écoyeux	17147
499	17	Écurat	17148
500	17	Les Éduts	17149
501	17	Les Églises-d'Argenteuil	17150
502	17	L'Éguille	17151
503	17	Épargnes	17152
504	17	Esnandes	17153
505	17	Les Essards	17154
506	17	Étaules	17155
507	17	Expiremont	17156
508	17	Fenioux	17157
509	17	Ferrières	17158
510	17	Fléac-sur-Seugne	17159
511	17	Floirac	17160
512	17	La Flotte	17161
513	17	Fontaine-Chalendray	17162
514	17	Fontaines-d'Ozillac	17163
515	17	Fontcouverte	17164
516	17	Fontenet	17165
517	17	Forges	17166
518	17	Le Fouilloux	17167
519	17	Fouras	17168
520	17	Geay	17171
521	17	Gémozac	17172
522	17	La Genétouze	17173
523	17	Genouillé	17174
524	17	Germignac	17175
525	17	Gibourne	17176
526	17	Le Gicq	17177
527	17	Givrezac	17178
528	17	Les Gonds	17179
529	17	Gourvillette	17180
530	17	Grandjean	17181
531	17	La Grève-sur-Mignon	17182
532	17	Grézac	17183
533	17	La Gripperie-Saint-Symphorien	17184
534	17	Le Gua	17185
535	17	Le Gué-d'Alleré	17186
536	17	Guitinières	17187
537	17	Haimps	17188
538	17	L'Houmeau	17190
539	17	La Jard	17191
540	17	Jarnac-Champagne	17192
541	17	La Jarne	17193
542	17	La Jarrie	17194
543	17	La Jarrie-Audouin	17195
544	17	Jazennes	17196
545	17	Jonzac	17197
546	17	Juicq	17198
547	17	Jussas	17199
548	17	Lagord	17200
549	17	La Laigne	17201
550	17	Landes	17202
551	17	Landrais	17203
552	17	Léoville	17204
553	17	Loire-les-Marais	17205
554	17	Loiré-sur-Nie	17206
555	17	Loix	17207
556	17	Longèves	17208
557	17	Lonzac	17209
558	17	Lorignac	17210
559	17	Loulay	17211
560	17	Louzignac	17212
561	17	Lozay	17213
562	17	Luchat	17214
563	17	Lussac	17215
564	17	Lussant	17216
565	17	Macqueville	17217
566	17	Marans	17218
567	17	Marennes-Hiers-Brouage	17219
568	17	Marignac	17220
569	17	Marsais	17221
570	17	Marsilly	17222
571	17	Massac	17223
572	17	Matha	17224
573	17	Les Mathes	17225
574	17	Mazeray	17226
575	17	Mazerolles	17227
576	17	Médis	17228
577	17	Mérignac	17229
578	17	Meschers-sur-Gironde	17230
579	17	Messac	17231
580	17	Meursac	17232
581	17	Meux	17233
582	17	Migré	17234
583	17	Migron	17235
584	17	Mirambeau	17236
585	17	Moëze	17237
586	17	Mons	17239
587	17	Montendre	17240
588	17	Montguyon	17241
589	17	Montils	17242
590	17	Montlieu-la-Garde	17243
591	17	Montpellier-de-Médillan	17244
592	17	Montroy	17245
593	17	Moragne	17246
594	17	Mornac-sur-Seudre	17247
595	17	Mortagne-sur-Gironde	17248
596	17	Mortiers	17249
597	17	Mosnac	17250
598	17	Le Mung	17252
599	17	Muron	17253
600	17	Nachamps	17254
601	17	Nancras	17255
602	17	Nantillé	17256
603	17	Néré	17257
604	17	Neuillac	17258
605	17	Neulles	17259
606	17	Neuvicq	17260
607	17	Neuvicq-le-Château	17261
608	17	Nieul-lès-Saintes	17262
609	17	Nieul-le-Virouil	17263
610	17	Nieul-sur-Mer	17264
611	17	Nieulle-sur-Seudre	17265
612	17	Les Nouillers	17266
613	17	Nuaillé-d'Aunis	17267
614	17	Rives-de-Boutonne	17268
615	17	Orignolles	17269
616	17	Ozillac	17270
617	17	Paillé	17271
618	17	Pérignac	17273
619	17	Périgny	17274
620	17	Pessines	17275
621	17	Le Pin	17276
622	17	Essouvert	17277
623	17	Pisany	17278
624	17	Plassac	17279
625	17	Plassay	17280
626	17	Polignac	17281
627	17	Pommiers-Moulons	17282
628	17	Pons	17283
629	17	Pont-l'Abbé-d'Arnoult	17284
630	17	Port-d'Envaux	17285
631	17	Les Portes-en-Ré	17286
632	17	Pouillac	17287
633	17	Poursay-Garnaud	17288
634	17	Préguillac	17289
635	17	Prignac	17290
636	17	Puilboreau	17291
637	17	Puy-du-Lac	17292
638	17	Puyravault	17293
639	17	Puyrolland	17294
640	17	Réaux sur Trèfle	17295
641	17	Rétaud	17296
642	17	Rivedoux-Plage	17297
643	17	Rioux	17298
644	17	Rochefort	17299
645	17	La Rochelle	17300
646	17	Romazières	17301
647	17	Romegoux	17302
648	17	La Ronde	17303
649	17	Rouffiac	17304
650	17	Rouffignac	17305
651	17	Royan	17306
652	17	Sablonceaux	17307
653	17	Saint-Agnant	17308
654	17	Saint-Aigulin	17309
655	17	Saint-André-de-Lidon	17310
656	17	Saint-Augustin	17311
657	17	Saint-Bonnet-sur-Gironde	17312
658	17	Saint-Bris-des-Bois	17313
659	17	Saint-Césaire	17314
660	17	Saint-Christophe	17315
661	17	Saint-Ciers-Champagne	17316
662	17	Saint-Ciers-du-Taillon	17317
663	17	Saint-Clément-des-Baleines	17318
664	17	Sainte-Colombe	17319
665	17	Saint-Coutant-le-Grand	17320
666	17	Saint-Crépin	17321
667	17	Saint-Cyr-du-Doret	17322
668	17	Saint-Denis-d'Oléron	17323
669	17	Saint-Dizant-du-Bois	17324
670	17	Saint-Dizant-du-Gua	17325
671	17	Saint-Eugène	17326
672	17	Saint-Félix	17327
673	17	Saint-Fort-sur-Gironde	17328
674	17	Saint-Froult	17329
675	17	Sainte-Gemme	17330
676	17	Saint-Genis-de-Saintonge	17331
677	17	Saint-Georges-Antignac	17332
678	17	Saint-Georges-de-Didonne	17333
679	17	Saint-Georges-des-Agoûts	17335
680	17	Saint-Georges-des-Coteaux	17336
681	17	Saint-Georges-d'Oléron	17337
682	17	Saint-Georges-du-Bois	17338
683	17	Saint-Germain-de-Lusignan	17339
684	17	Saint-Pierre-La-Noue	17340
685	17	Saint-Germain-de-Vibrac	17341
686	17	Saint-Germain-du-Seudre	17342
687	17	Saint-Grégoire-d'Ardennes	17343
688	17	Saint-Hilaire-de-Villefranche	17344
689	17	Saint-Hilaire-du-Bois	17345
690	17	Saint-Hippolyte	17346
691	17	Saint-Jean-d'Angély	17347
692	17	Saint-Jean-d'Angle	17348
693	17	Saint-Jean-de-Liversay	17349
694	17	Saint-Julien-de-l'Escap	17350
695	17	Saint-Just-Luzac	17351
696	17	Saint-Laurent-de-la-Prée	17353
697	17	Saint-Léger	17354
698	17	Sainte-Lheurine	17355
699	17	Saint-Loup	17356
700	17	Saint-Maigrin	17357
701	17	Saint-Mandé-sur-Brédoire	17358
702	17	Saint-Mard	17359
703	17	Sainte-Marie-de-Ré	17360
704	17	Saint-Martial	17361
705	17	Saint-Martial-de-Mirambeau	17362
706	17	Saint-Martial-de-Vitaterne	17363
707	17	Saint-Martial-sur-Né	17364
708	17	Saint-Martin-d'Ary	17365
709	17	Saint-Martin-de-Coux	17366
710	17	Saint-Martin-de-Juillers	17367
711	17	Saint-Martin-de-Ré	17369
712	17	Saint-Médard	17372
713	17	Saint-Médard-d'Aunis	17373
714	17	Sainte-Même	17374
715	17	Saint-Nazaire-sur-Charente	17375
716	17	Saint-Ouen-d'Aunis	17376
717	17	Saint-Ouen-la-Thène	17377
718	17	Saint-Palais-de-Négrignac	17378
719	17	Saint-Palais-de-Phiolin	17379
720	17	Saint-Palais-sur-Mer	17380
721	17	Saint-Pardoult	17381
722	17	Saint-Pierre-d'Amilly	17382
723	17	Saint-Pierre-de-Juillers	17383
724	17	Saint-Pierre-de-l'Isle	17384
725	17	Saint-Pierre-d'Oléron	17385
726	17	Saint-Pierre-du-Palais	17386
727	17	Saint-Porchaire	17387
728	17	Saint-Quantin-de-Rançanne	17388
729	17	Sainte-Radegonde	17389
730	17	Sainte-Ramée	17390
731	17	Saint-Rogatien	17391
732	17	Saint-Romain-de-Benet	17393
733	17	Saint-Saturnin-du-Bois	17394
734	17	Saint-Sauvant	17395
735	17	Saint-Sauveur-d'Aunis	17396
736	17	Saint-Savinien	17397
737	17	Saint-Seurin-de-Palenne	17398
738	17	Saint-Sever-de-Saintonge	17400
739	17	Saint-Séverin-sur-Boutonne	17401
740	17	Saint-Sigismond-de-Clermont	17402
741	17	Saint-Simon-de-Bordes	17403
742	17	Saint-Simon-de-Pellouaille	17404
743	17	Saint-Sorlin-de-Conac	17405
744	17	Saint-Sornin	17406
745	17	Sainte-Soulle	17407
746	17	Saint-Sulpice-d'Arnoult	17408
747	17	Saint-Sulpice-de-Royan	17409
748	17	Saint-Thomas-de-Conac	17410
749	17	Saint-Trojan-les-Bains	17411
750	17	Saint-Vaize	17412
751	17	Saint-Vivien	17413
752	17	Saint-Xandre	17414
753	17	Saintes	17415
754	17	Saleignes	17416
755	17	Salignac-de-Mirambeau	17417
756	17	Salignac-sur-Charente	17418
757	17	Salles-sur-Mer	17420
758	17	Saujon	17421
759	17	Seigné	17422
760	17	Semillac	17423
761	17	Semoussac	17424
762	17	Semussac	17425
763	17	Le Seure	17426
764	17	Siecq	17427
765	17	Sonnac	17428
766	17	Soubise	17429
767	17	Soubran	17430
768	17	Soulignonne	17431
769	17	Souméras	17432
770	17	Sousmoulins	17433
771	17	Surgères	17434
772	17	Taillant	17435
773	17	Taillebourg	17436
774	17	Talmont-sur-Gironde	17437
775	17	Tanzac	17438
776	17	Taugon	17439
777	17	Ternant	17440
778	17	Tesson	17441
779	17	Thaims	17442
780	17	Thairé	17443
781	17	Thénac	17444
782	17	Thézac	17445
783	17	Thors	17446
784	17	Le Thou	17447
785	17	Tonnay-Boutonne	17448
786	17	Tonnay-Charente	17449
787	17	Torxé	17450
788	17	Les Touches-de-Périgny	17451
789	17	La Tremblade	17452
790	17	Trizay	17453
791	17	Tugéras-Saint-Maurice	17454
792	17	La Vallée	17455
793	17	La Devise	17457
794	17	Vanzac	17458
795	17	Varaize	17459
796	17	Varzay	17460
797	17	Vaux-sur-Mer	17461
798	17	Vénérand	17462
799	17	Vergeroux	17463
800	17	Vergné	17464
801	17	La Vergne	17465
802	17	Vérines	17466
803	17	Vervant	17467
804	17	Vibrac	17468
805	17	Villars-en-Pons	17469
806	17	Villars-les-Bois	17470
807	17	La Villedieu	17471
808	17	Villedoux	17472
809	17	Villemorin	17473
810	17	Villeneuve-la-Comtesse	17474
811	17	Villexavier	17476
812	17	Villiers-Couture	17477
813	17	Vinax	17478
814	17	Virollet	17479
815	17	Virson	17480
816	17	Voissay	17481
817	17	Vouhé	17482
818	17	Yves	17483
819	17	Port-des-Barques	17484
820	17	Le Grand-Village-Plage	17485
821	17	La Brée-les-Bains	17486
822	19	Affieux	19001
823	19	Aix	19002
824	19	Albignac	19003
825	19	Albussac	19004
826	19	Allassac	19005
827	19	Alleyrat	19006
828	19	Altillac	19007
829	19	Ambrugeat	19008
830	19	Les Angles-sur-Corrèze	19009
831	19	Argentat-sur-Dordogne	19010
832	19	Arnac-Pompadour	19011
833	19	Astaillac	19012
834	19	Aubazines	19013
835	19	Auriac	19014
836	19	Ayen	19015
837	19	Bar	19016
838	19	Bassignac-le-Bas	19017
839	19	Bassignac-le-Haut	19018
840	19	Beaulieu-sur-Dordogne	19019
841	19	Beaumont	19020
842	19	Bellechassagne	19021
843	19	Benayes	19022
844	19	Beynat	19023
845	19	Beyssac	19024
846	19	Beyssenac	19025
847	19	Bilhac	19026
848	19	Bonnefond	19027
849	19	Bort-les-Orgues	19028
850	19	Branceilles	19029
851	19	Brignac-la-Plaine	19030
852	19	Brive-la-Gaillarde	19031
853	19	Bugeat	19033
854	19	Camps-Saint-Mathurin-Léobazel	19034
855	19	Chabrignac	19035
856	19	Chamberet	19036
857	19	Chamboulive	19037
858	19	Chameyrat	19038
859	19	Champagnac-la-Noaille	19039
860	19	Champagnac-la-Prune	19040
861	19	Chanac-les-Mines	19041
862	19	Chanteix	19042
863	19	La Chapelle-aux-Brocs	19043
864	19	La Chapelle-aux-Saints	19044
865	19	La Chapelle-Saint-Géraud	19045
866	19	Chapelle-Spinasse	19046
867	19	Chartrier-Ferrière	19047
868	19	Le Chastang	19048
869	19	Chasteaux	19049
870	19	Chauffour-sur-Vell	19050
871	19	Chaumeil	19051
872	19	Chavanac	19052
873	19	Chaveroche	19053
874	19	Chenailler-Mascheix	19054
875	19	Chirac-Bellevue	19055
876	19	Clergoux	19056
877	19	Collonges-la-Rouge	19057
878	19	Combressol	19058
879	19	Concèze	19059
880	19	Condat-sur-Ganaveix	19060
881	19	Cornil	19061
882	19	Corrèze	19062
883	19	Cosnac	19063
884	19	Couffy-sur-Sarsonne	19064
885	19	Courteix	19065
886	19	Cublac	19066
887	19	Curemonte	19067
888	19	Dampniat	19068
889	19	Darazac	19069
890	19	Darnets	19070
891	19	Davignac	19071
892	19	Donzenac	19072
893	19	Égletons	19073
894	19	L'Église-aux-Bois	19074
895	19	Espagnac	19075
896	19	Espartignac	19076
897	19	Estivals	19077
898	19	Estivaux	19078
899	19	Eyburie	19079
900	19	Eygurande	19080
901	19	Eyrein	19081
902	19	Favars	19082
903	19	Feyt	19083
904	19	Forgès	19084
905	19	Gimel-les-Cascades	19085
906	19	Goulles	19086
907	19	Gourdon-Murat	19087
908	19	Grandsaigne	19088
909	19	Gros-Chastang	19089
910	19	Gumond	19090
911	19	Hautefage	19091
912	19	Jugeals-Nazareth	19093
913	19	Juillac	19094
914	19	Lacelle	19095
915	19	Ladignac-sur-Rondelles	19096
916	19	Lafage-sur-Sombre	19097
917	19	Lagarde-Marc-la-Tour	19098
918	19	Lagleygeolle	19099
919	19	Lagraulière	19100
920	19	Laguenne-sur-Avalouze	19101
921	19	Lamazière-Basse	19102
922	19	Lamazière-Haute	19103
923	19	Lamongerie	19104
924	19	Lanteuil	19105
925	19	Lapleau	19106
926	19	Larche	19107
927	19	Laroche-près-Feyt	19108
928	19	Lascaux	19109
929	19	Latronche	19110
930	19	Laval-sur-Luzège	19111
931	19	Lestards	19112
932	19	Liginiac	19113
933	19	Lignareix	19114
934	19	Ligneyrac	19115
935	19	Liourdres	19116
936	19	Lissac-sur-Couze	19117
937	19	Le Lonzac	19118
938	19	Lostanges	19119
939	19	Louignac	19120
940	19	Lubersac	19121
941	19	Madranges	19122
942	19	Malemort	19123
943	19	Mansac	19124
944	19	Marcillac-la-Croisille	19125
945	19	Marcillac-la-Croze	19126
946	19	Margerides	19128
947	19	Masseret	19129
948	19	Maussac	19130
949	19	Meilhards	19131
950	19	Ménoire	19132
951	19	Mercœur	19133
952	19	Merlines	19134
953	19	Mestes	19135
954	19	Meymac	19136
955	19	Meyrignac-l'Église	19137
956	19	Meyssac	19138
957	19	Millevaches	19139
958	19	Monceaux-sur-Dordogne	19140
959	19	Monestier-Merlines	19141
960	19	Monestier-Port-Dieu	19142
961	19	Montaignac-sur-Doustre	19143
962	19	Montgibaud	19144
963	19	Moustier-Ventadour	19145
964	19	Naves	19146
965	19	Nespouls	19147
966	19	Neuvic	19148
967	19	Neuville	19149
968	19	Noailhac	19150
969	19	Noailles	19151
970	19	Nonards	19152
971	19	Objat	19153
972	19	Orgnac-sur-Vézère	19154
973	19	Orliac-de-Bar	19155
974	19	Palazinges	19156
975	19	Palisse	19157
976	19	Pandrignes	19158
977	19	Péret-Bel-Air	19159
978	19	Pérols-sur-Vézère	19160
979	19	Perpezac-le-Blanc	19161
980	19	Perpezac-le-Noir	19162
981	19	Le Pescher	19163
982	19	Peyrelevade	19164
983	19	Peyrissac	19165
984	19	Pierrefitte	19166
985	19	Confolent-Port-Dieu	19167
986	19	Pradines	19168
987	19	Puy-d'Arnac	19169
988	19	Queyssac-les-Vignes	19170
989	19	Reygade	19171
990	19	Rilhac-Treignac	19172
991	19	Rilhac-Xaintrie	19173
992	19	La Roche-Canillac	19174
993	19	Roche-le-Peyroux	19175
994	19	Rosiers-d'Égletons	19176
995	19	Rosiers-de-Juillac	19177
996	19	Sadroc	19178
997	19	Saillac	19179
998	19	Saint-Angel	19180
999	19	Saint-Augustin	19181
1000	19	Saint-Aulaire	19182
1001	19	Saint-Bazile-de-Meyssac	19184
1002	19	Saint-Bonnet-Elvert	19186
1003	19	Saint-Bonnet-la-Rivière	19187
1004	19	Saint-Bonnet-l'Enfantier	19188
1005	19	Saint-Bonnet-les-Tours-de-Merle	19189
1006	19	Saint-Bonnet-près-Bort	19190
1007	19	Saint-Cernin-de-Larche	19191
1008	19	Saint-Chamant	19192
1009	19	Saint-Cirgues-la-Loutre	19193
1010	19	Saint-Clément	19194
1011	19	Saint-Cyprien	19195
1012	19	Saint-Cyr-la-Roche	19196
1013	19	Saint-Éloy-les-Tuileries	19198
1014	19	Saint-Étienne-aux-Clos	19199
1015	19	Saint-Étienne-la-Geneste	19200
1016	19	Saint-Exupéry-les-Roches	19201
1017	19	Sainte-Féréole	19202
1018	19	Sainte-Fortunade	19203
1019	19	Saint-Fréjoux	19204
1020	19	Saint-Geniez-ô-Merle	19205
1021	19	Saint-Germain-Lavolps	19206
1022	19	Saint-Germain-les-Vergnes	19207
1023	19	Saint-Hilaire-Foissac	19208
1024	19	Saint-Hilaire-les-Courbes	19209
1025	19	Saint-Hilaire-Luc	19210
1026	19	Saint-Hilaire-Peyroux	19211
1027	19	Saint-Hilaire-Taurieux	19212
1028	19	Saint-Jal	19213
1029	19	Saint-Julien-aux-Bois	19214
1030	19	Saint-Julien-le-Pèlerin	19215
1031	19	Saint-Julien-le-Vendômois	19216
1032	19	Saint-Julien-Maumont	19217
1033	19	Sainte-Marie-Lapanouze	19219
1034	19	Saint-Martial-de-Gimel	19220
1035	19	Saint-Martial-Entraygues	19221
1036	19	Saint-Martin-la-Méanne	19222
1037	19	Saint-Merd-de-Lapleau	19225
1038	19	Saint-Merd-les-Oussines	19226
1039	19	Saint-Mexant	19227
1040	19	Saint-Pantaléon-de-Lapleau	19228
1041	19	Saint-Pantaléon-de-Larche	19229
1042	19	Saint-Pardoux-la-Croisille	19231
1043	19	Saint-Pardoux-le-Neuf	19232
1044	19	Saint-Pardoux-le-Vieux	19233
1045	19	Saint-Pardoux-l'Ortigier	19234
1046	19	Saint-Paul	19235
1047	19	Saint-Priest-de-Gimel	19236
1048	19	Saint-Privat	19237
1049	19	Saint-Rémy	19238
1050	19	Saint-Robert	19239
1051	19	Saint-Salvadour	19240
1052	19	Saint-Setiers	19241
1053	19	Saint-Solve	19242
1054	19	Saint-Sornin-Lavolps	19243
1055	19	Saint-Sulpice-les-Bois	19244
1056	19	Saint-Sylvain	19245
1057	19	Saint-Viance	19246
1058	19	Saint-Victour	19247
1059	19	Les Trois-Saints	19248
1060	19	Saint-Yrieix-le-Déjalat	19249
1061	19	Salon-la-Tour	19250
1062	19	Sarran	19251
1063	19	Sarroux - Saint Julien	19252
1064	19	Segonzac	19253
1065	19	Ségur-le-Château	19254
1066	19	Seilhac	19255
1067	19	Sérandon	19256
1068	19	Sérilhac	19257
1069	19	Servières-le-Château	19258
1070	19	Sexcles	19259
1071	19	Sioniac	19260
1072	19	Sornac	19261
1073	19	Soudaine-Lavinadière	19262
1074	19	Soudeilles	19263
1075	19	Soursac	19264
1076	19	Tarnac	19265
1077	19	Thalamy	19266
1078	19	Toy-Viam	19268
1079	19	Treignac	19269
1080	19	Troche	19270
1081	19	Tudeils	19271
1082	19	Tulle	19272
1083	19	Turenne	19273
1084	19	Ussac	19274
1085	19	Ussel	19275
1086	19	Uzerche	19276
1087	19	Valiergues	19277
1088	19	Varetz	19278
1089	19	Vars-sur-Roseix	19279
1090	19	Végennes	19280
1091	19	Veix	19281
1092	19	Veyrières	19283
1093	19	Viam	19284
1094	19	Vigeois	19285
1095	19	Vignols	19286
1096	19	Vitrac-sur-Montane	19287
1097	19	Voutezac	19288
1098	19	Yssandon	19289
1099	23	Ahun	23001
1100	23	Ajain	23002
1101	23	Alleyrat	23003
1102	23	Anzême	23004
1103	23	Arfeuille-Châtain	23005
1104	23	Arrènes	23006
1105	23	Ars	23007
1106	23	Aubusson	23008
1107	23	Auge	23009
1108	23	Augères	23010
1109	23	Aulon	23011
1110	23	Auriat	23012
1111	23	Auzances	23013
1112	23	Azat-Châtenet	23014
1113	23	Azerables	23015
1114	23	Banize	23016
1115	23	Basville	23017
1116	23	Bazelat	23018
1117	23	Beissat	23019
1118	23	Bellegarde-en-Marche	23020
1119	23	Bénévent-l'Abbaye	23021
1120	23	Bétête	23022
1121	23	Blessac	23024
1122	23	Bonnat	23025
1123	23	Bord-Saint-Georges	23026
1124	23	Bosmoreau-les-Mines	23027
1125	23	Bosroger	23028
1126	23	Le Bourg-d'Hem	23029
1127	23	Bourganeuf	23030
1128	23	Boussac	23031
1129	23	Boussac-Bourg	23032
1130	23	La Brionne	23033
1131	23	Brousse	23034
1132	23	Budelière	23035
1133	23	Bussière-Dunoise	23036
1134	23	Bussière-Nouvelle	23037
1135	23	Bussière-Saint-Georges	23038
1136	23	La Celle-Dunoise	23039
1137	23	La Celle-sous-Gouzon	23040
1138	23	La Cellette	23041
1139	23	Ceyroux	23042
1140	23	Chamberaud	23043
1141	23	Chambon-Sainte-Croix	23044
1142	23	Chambon-sur-Voueize	23045
1143	23	Chambonchard	23046
1144	23	Chamborand	23047
1145	23	Champagnat	23048
1146	23	Champsanglard	23049
1147	23	La Chapelle-Baloue	23050
1148	23	La Chapelle-Saint-Martial	23051
1149	23	La Chapelle-Taillefert	23052
1150	23	Chard	23053
1151	23	Charron	23054
1152	23	Châtelard	23055
1153	23	Châtelus-le-Marcheix	23056
1154	23	Châtelus-Malvaleix	23057
1155	23	Le Chauchet	23058
1156	23	La Chaussade	23059
1157	23	Chavanat	23060
1158	23	Chénérailles	23061
1159	23	Chéniers	23062
1160	23	Clairavaux	23063
1161	23	Clugnat	23064
1162	23	Colondannes	23065
1163	23	Le Compas	23066
1164	23	La Courtine	23067
1165	23	Cressat	23068
1166	23	Crocq	23069
1167	23	Crozant	23070
1168	23	Croze	23071
1169	23	Domeyrot	23072
1170	23	Dontreix	23073
1171	23	Le Donzeil	23074
1172	23	Dun-le-Palestel	23075
1173	23	Évaux-les-Bains	23076
1174	23	Faux-la-Montagne	23077
1175	23	Faux-Mazuras	23078
1176	23	Felletin	23079
1177	23	Féniers	23080
1178	23	Flayat	23081
1179	23	Fleurat	23082
1180	23	Fontanières	23083
1181	23	La Forêt-du-Temple	23084
1182	23	Fransèches	23086
1183	23	Fresselines	23087
1184	23	Gartempe	23088
1185	23	Genouillac	23089
1186	23	Gentioux-Pigerolles	23090
1187	23	Gioux	23091
1188	23	Glénic	23092
1189	23	Gouzon	23093
1190	23	Le Grand-Bourg	23095
1191	23	Guéret	23096
1192	23	Issoudun-Létrieix	23097
1193	23	Jalesches	23098
1194	23	Janaillat	23099
1195	23	Jarnages	23100
1196	23	Jouillat	23101
1197	23	Ladapeyre	23102
1198	23	Lafat	23103
1199	23	Lavaufranche	23104
1200	23	Lavaveix-les-Mines	23105
1201	23	Lépaud	23106
1202	23	Lépinas	23107
1203	23	Leyrat	23108
1204	23	Linard-Malval	23109
1205	23	Lioux-les-Monges	23110
1206	23	Lizières	23111
1207	23	Lourdoueix-Saint-Pierre	23112
1208	23	Lupersat	23113
1209	23	Lussat	23114
1210	23	Magnat-l'Étrange	23115
1211	23	Mainsat	23116
1212	23	Maison-Feyne	23117
1213	23	Maisonnisses	23118
1214	23	Malleret	23119
1215	23	Malleret-Boussac	23120
1216	23	Mansat-la-Courrière	23122
1217	23	Les Mars	23123
1218	23	Marsac	23124
1219	23	Le Mas-d'Artige	23125
1220	23	Mautes	23127
1221	23	Mazeirat	23128
1222	23	La Mazière-aux-Bons-Hommes	23129
1223	23	Méasnes	23130
1224	23	Mérinchal	23131
1225	23	Montaigut-le-Blanc	23132
1226	23	Montboucher	23133
1227	23	Le Monteil-au-Vicomte	23134
1228	23	Mortroux	23136
1229	23	Mourioux-Vieilleville	23137
1230	23	Moutier-d'Ahun	23138
1231	23	Moutier-Malcard	23139
1232	23	Moutier-Rozeille	23140
1233	23	Naillat	23141
1234	23	Néoux	23142
1235	23	Noth	23143
1236	23	La Nouaille	23144
1237	23	Nouhant	23145
1238	23	Nouzerines	23146
1239	23	Nouzerolles	23147
1240	23	Nouziers	23148
1241	23	Parsac	23149
1242	23	Peyrabout	23150
1243	23	Peyrat-la-Nonière	23151
1244	23	Pierrefitte	23152
1245	23	Pionnat	23154
1246	23	Pontarion	23155
1247	23	Pontcharraud	23156
1248	23	La Pouge	23157
1249	23	Poussanges	23158
1250	23	Puy-Malsignat	23159
1251	23	Reterre	23160
1252	23	Roches	23162
1253	23	Rougnat	23164
1254	23	Royère-de-Vassivière	23165
1255	23	Sagnat	23166
1256	23	Sannat	23167
1257	23	Sardent	23168
1258	23	La Saunière	23169
1259	23	Savennes	23170
1260	23	Sermur	23171
1261	23	La Serre-Bussière-Vieille	23172
1262	23	Soubrebost	23173
1263	23	Soumans	23174
1264	23	Sous-Parsat	23175
1265	23	La Souterraine	23176
1266	23	Saint-Agnant-de-Versillat	23177
1267	23	Saint-Agnant-près-Crocq	23178
1268	23	Saint-Alpinien	23179
1269	23	Saint-Amand	23180
1270	23	Saint-Amand-Jartoudeix	23181
1271	23	Saint-Avit-de-Tardes	23182
1272	23	Saint-Avit-le-Pauvre	23183
1273	23	Saint-Bard	23184
1274	23	Saint-Chabrais	23185
1275	23	Saint-Christophe	23186
1276	23	Saint-Dizier-la-Tour	23187
1277	23	Saint-Dizier-les-Domaines	23188
1278	23	Saint-Dizier-Masbaraud	23189
1279	23	Saint-Domet	23190
1280	23	Saint-Éloi	23191
1281	23	Fursac	23192
1282	23	Sainte-Feyre	23193
1283	23	Sainte-Feyre-la-Montagne	23194
1284	23	Saint-Fiel	23195
1285	23	Saint-Frion	23196
1286	23	Saint-Georges-la-Pouge	23197
1287	23	Saint-Georges-Nigremont	23198
1288	23	Saint-Germain-Beaupré	23199
1289	23	Saint-Goussaud	23200
1290	23	Saint-Hilaire-la-Plaine	23201
1291	23	Saint-Hilaire-le-Château	23202
1292	23	Saint-Julien-la-Genête	23203
1293	23	Saint-Julien-le-Châtel	23204
1294	23	Saint-Junien-la-Bregère	23205
1295	23	Saint-Laurent	23206
1296	23	Saint-Léger-Bridereix	23207
1297	23	Saint-Léger-le-Guérétois	23208
1298	23	Saint-Loup	23209
1299	23	Saint-Maixant	23210
1300	23	Saint-Marc-à-Frongier	23211
1301	23	Saint-Marc-à-Loubaud	23212
1302	23	Saint-Marien	23213
1303	23	Saint-Martial-le-Mont	23214
1304	23	Saint-Martial-le-Vieux	23215
1305	23	Saint-Martin-Château	23216
1306	23	Saint-Martin-Sainte-Catherine	23217
1307	23	Saint-Maurice-près-Crocq	23218
1308	23	Saint-Maurice-la-Souterraine	23219
1309	23	Saint-Médard-la-Rochette	23220
1310	23	Saint-Merd-la-Breuille	23221
1311	23	Saint-Michel-de-Veisse	23222
1312	23	Saint-Moreil	23223
1313	23	Saint-Oradoux-de-Chirouze	23224
1314	23	Saint-Oradoux-près-Crocq	23225
1315	23	Saint-Pardoux-d'Arnet	23226
1316	23	Saint-Pardoux-Morterolles	23227
1317	23	Saint-Pardoux-le-Neuf	23228
1318	23	Saint-Pardoux-les-Cards	23229
1319	23	Saint-Pierre-Chérignat	23230
1320	23	Saint-Pierre-Bellevue	23232
1321	23	Saint-Pierre-le-Bost	23233
1322	23	Saint-Priest	23234
1323	23	Saint-Priest-la-Feuille	23235
1324	23	Saint-Priest-la-Plaine	23236
1325	23	Saint-Priest-Palus	23237
1326	23	Saint-Quentin-la-Chabanne	23238
1327	23	Saint-Sébastien	23239
1328	23	Saint-Silvain-Bas-le-Roc	23240
1329	23	Saint-Silvain-Bellegarde	23241
1330	23	Saint-Silvain-Montaigut	23242
1331	23	Saint-Silvain-sous-Toulx	23243
1332	23	Saint-Sulpice-le-Dunois	23244
1333	23	Saint-Sulpice-le-Guérétois	23245
1334	23	Saint-Sulpice-les-Champs	23246
1335	23	Saint-Vaury	23247
1336	23	Saint-Victor-en-Marche	23248
1337	23	Saint-Yrieix-la-Montagne	23249
1338	23	Saint-Yrieix-les-Bois	23250
1339	23	Tardes	23251
1340	23	Tercillat	23252
1341	23	Thauron	23253
1342	23	Toulx-Sainte-Croix	23254
1343	23	Trois-Fonds	23255
1344	23	Vallière	23257
1345	23	Vareilles	23258
1346	23	Verneiges	23259
1347	23	Vidaillat	23260
1348	23	Viersat	23261
1349	23	Vigeville	23262
1350	23	Villard	23263
1351	23	La Villedieu	23264
1352	23	La Villeneuve	23265
1353	23	La Villetelle	23266
1354	24	Abjat-sur-Bandiat	24001
1355	24	Agonac	24002
1356	24	Ajat	24004
1357	24	Alles-sur-Dordogne	24005
1358	24	Allas-les-Mines	24006
1359	24	Allemans	24007
1360	24	Angoisse	24008
1361	24	Anlhiac	24009
1362	24	Annesse-et-Beaulieu	24010
1363	24	Antonne-et-Trigonant	24011
1364	24	Archignac	24012
1365	24	Aubas	24014
1366	24	Audrix	24015
1367	24	Augignac	24016
1368	24	Auriac-du-Périgord	24018
1369	24	Azerat	24019
1370	24	La Bachellerie	24020
1371	24	Badefols-d'Ans	24021
1372	24	Badefols-sur-Dordogne	24022
1373	24	Baneuil	24023
1374	24	Bardou	24024
1375	24	Bars	24025
1376	24	Bassillac et Auberoche	24026
1377	24	Bayac	24027
1378	24	Beaumontois en Périgord	24028
1379	24	Beaupouyet	24029
1380	24	Beauregard-de-Terrasson	24030
1381	24	Beauregard-et-Bassac	24031
1382	24	Beauronne	24032
1383	24	Beleymas	24034
1384	24	Pays de Belvès	24035
1385	24	Berbiguières	24036
1386	24	Bergerac	24037
1387	24	Bertric-Burée	24038
1388	24	Besse	24039
1389	24	Beynac-et-Cazenac	24040
1390	24	Biras	24042
1391	24	Biron	24043
1392	24	Boisse	24045
1393	24	Boisseuilh	24046
1394	24	Bonneville-et-Saint-Avit-de-Fumadières	24048
1395	24	Borrèze	24050
1396	24	Bosset	24051
1397	24	Bouillac	24052
1398	24	Boulazac Isle Manoire	24053
1399	24	Bouniagues	24054
1400	24	Bourdeilles	24055
1401	24	Le Bourdeix	24056
1402	24	Bourg-des-Maisons	24057
1403	24	Bourg-du-Bost	24058
1404	24	Bourgnac	24059
1405	24	Bourniquel	24060
1406	24	Bourrou	24061
1407	24	Bouteilles-Saint-Sébastien	24062
1408	24	Bouzic	24063
1409	24	Brantôme en Périgord	24064
1410	24	Brouchaud	24066
1411	24	Le Bugue	24067
1412	24	Le Buisson-de-Cadouin	24068
1413	24	Bussac	24069
1414	24	Busserolles	24070
1415	24	Bussière-Badil	24071
1416	24	Calès	24073
1417	24	Calviac-en-Périgord	24074
1418	24	Campagnac-lès-Quercy	24075
1419	24	Campagne	24076
1420	24	Campsegret	24077
1421	24	Capdrot	24080
1422	24	Carlux	24081
1423	24	Carsac-Aillac	24082
1424	24	Carsac-de-Gurson	24083
1425	24	Carves	24084
1426	24	La Cassagne	24085
1427	24	Castelnaud-la-Chapelle	24086
1428	24	Castels et Bézenac	24087
1429	24	Cause-de-Clérans	24088
1430	24	Celles	24090
1431	24	Cénac-et-Saint-Julien	24091
1432	24	Chalagnac	24094
1433	24	Chalais	24095
1434	24	Champagnac-de-Belair	24096
1435	24	Champagne-et-Fontaine	24097
1436	24	Champcevinel	24098
1437	24	Champniers-et-Reilhac	24100
1438	24	Champs-Romain	24101
1439	24	Chancelade	24102
1440	24	Chantérac	24104
1441	24	Chapdeuil	24105
1442	24	La Chapelle-Aubareil	24106
1443	24	La Chapelle-Faucher	24107
1444	24	La Chapelle-Gonaguet	24108
1445	24	La Chapelle-Grésignac	24109
1446	24	La Chapelle-Montabourlet	24110
1447	24	La Chapelle-Montmoreau	24111
1448	24	La Chapelle-Saint-Jean	24113
1449	24	Chassaignes	24114
1450	24	Château-l'Évêque	24115
1451	24	Châtres	24116
1452	24	Les Coteaux Périgourdins	24117
1453	24	Cherval	24119
1454	24	Cherveix-Cubas	24120
1455	24	Chourgnac	24121
1456	24	Cladech	24122
1457	24	Clermont-de-Beauregard	24123
1458	24	Clermont-d'Excideuil	24124
1459	24	Colombier	24126
1460	24	Comberanche-et-Épeluche	24128
1461	24	Condat-sur-Trincou	24129
1462	24	Condat-sur-Vézère	24130
1463	24	Connezac	24131
1464	24	Conne-de-Labarde	24132
1465	24	La Coquille	24133
1466	24	Corgnac-sur-l'Isle	24134
1467	24	Cornille	24135
1468	24	Coubjours	24136
1469	24	Coulaures	24137
1470	24	Coulounieix-Chamiers	24138
1471	24	Coursac	24139
1472	24	Cours-de-Pile	24140
1473	24	Coutures	24141
1474	24	Coux et Bigaroque-Mouzens	24142
1475	24	Couze-et-Saint-Front	24143
1476	24	Creyssac	24144
1477	24	Creysse	24145
1478	24	Creyssensac-et-Pissot	24146
1479	24	Cubjac-Auvézère-Val d'Ans	24147
1480	24	Cunèges	24148
1481	24	Daglan	24150
1482	24	Doissat	24151
1483	24	Domme	24152
1484	24	La Dornac	24153
1485	24	Douchapt	24154
1486	24	Douville	24155
1487	24	La Douze	24156
1488	24	Douzillac	24157
1489	24	Dussac	24158
1490	24	Échourgnac	24159
1491	24	Église-Neuve-de-Vergt	24160
1492	24	Église-Neuve-d'Issac	24161
1493	24	Escoire	24162
1494	24	Étouars	24163
1495	24	Excideuil	24164
1496	24	Eygurande-et-Gardedeuil	24165
1497	24	Eymet	24167
1498	24	Plaisance	24168
1499	24	Eyzerac	24171
1500	24	Les Eyzies	24172
1501	24	Fanlac	24174
1502	24	Les Farges	24175
1503	24	Faurilles	24176
1504	24	Faux-en-Périgord	24177
1505	24	La Feuillade	24179
1506	24	Firbeix	24180
1507	24	Le Fleix	24182
1508	24	Fleurac	24183
1509	24	Florimont-Gaumier	24184
1510	24	Fonroque	24186
1511	24	Fossemagne	24188
1512	24	Fougueyrolles	24189
1513	24	Fouleix	24190
1514	24	Fraisse	24191
1515	24	Gabillou	24192
1516	24	Gageac-et-Rouillac	24193
1517	24	Gardonne	24194
1518	24	Gaugeac	24195
1519	24	Génis	24196
1520	24	Ginestet	24197
1521	24	Gout-Rossignol	24199
1522	24	Grand-Brassac	24200
1523	24	Granges-d'Ans	24202
1524	24	Grignols	24205
1525	24	Grives	24206
1526	24	Groléjac	24207
1527	24	Grun-Bordas	24208
1528	24	Hautefaye	24209
1529	24	Hautefort	24210
1530	24	Issac	24211
1531	24	Issigeac	24212
1532	24	Jaure	24213
1533	24	Javerlhac-et-la-Chapelle-Saint-Robert	24214
1534	24	Jayac	24215
1535	24	La Jemaye-Ponteyraud	24216
1536	24	Journiac	24217
1537	24	Jumilhac-le-Grand	24218
1538	24	Lacropte	24220
1539	24	Rudeau-Ladosse	24221
1540	24	La Force	24222
1541	24	Lalinde	24223
1542	24	Lamonzie-Montastruc	24224
1543	24	Lamonzie-Saint-Martin	24225
1544	24	Lamothe-Montravel	24226
1545	24	Lanouaille	24227
1546	24	Lanquais	24228
1547	24	Le Lardin-Saint-Lazare	24229
1548	24	Larzac	24230
1549	24	Lavalade	24231
1550	24	Lavaur	24232
1551	24	Les Lèches	24234
1552	24	Léguillac-de-l'Auche	24236
1553	24	Lembras	24237
1554	24	Lempzours	24238
1555	24	Limeuil	24240
1556	24	Limeyrat	24241
1557	24	Liorac-sur-Louyre	24242
1558	24	Lisle	24243
1559	24	Lolme	24244
1560	24	Loubejac	24245
1561	24	Lunas	24246
1562	24	Lusignac	24247
1563	24	Lussas-et-Nontronneau	24248
1564	24	Manzac-sur-Vern	24251
1565	24	Marcillac-Saint-Quentin	24252
1566	24	Mareuil en Périgord	24253
1567	24	Marnac	24254
1568	24	Marquay	24255
1569	24	Marsac-sur-l'Isle	24256
1570	24	Marsalès	24257
1571	24	Eyraud-Crempse-Maurens	24259
1572	24	Mauzac-et-Grand-Castang	24260
1573	24	Mauzens-et-Miremont	24261
1574	24	Mayac	24262
1575	24	Mazeyrolles	24263
1576	24	Ménesplet	24264
1577	24	Mensignac	24266
1578	24	Mescoules	24267
1579	24	Meyrals	24268
1580	24	Mialet	24269
1581	24	Milhac-de-Nontron	24271
1582	24	Minzac	24272
1583	24	Molières	24273
1584	24	Monbazillac	24274
1585	24	Monestier	24276
1586	24	Monfaucon	24277
1587	24	Monmadalès	24278
1588	24	Monmarvès	24279
1589	24	Monpazier	24280
1590	24	Monsac	24281
1591	24	Monsaguel	24282
1592	24	Montagnac-d'Auberoche	24284
1593	24	Montagnac-la-Crempse	24285
1594	24	Montagrier	24286
1595	24	Montaut	24287
1596	24	Montazeau	24288
1597	24	Montcaret	24289
1598	24	Montferrand-du-Périgord	24290
1599	24	Montignac-Lascaux	24291
1600	24	Montpeyroux	24292
1601	24	Monplaisant	24293
1602	24	Montpon-Ménestérol	24294
1603	24	Montrem	24295
1604	24	Mouleydier	24296
1605	24	Moulin-Neuf	24297
1606	24	Mussidan	24299
1607	24	Nabirat	24300
1608	24	Nadaillac	24301
1609	24	Nailhac	24302
1610	24	Nanteuil-Auriac-de-Bourzac	24303
1611	24	Nantheuil	24304
1612	24	Nanthiat	24305
1613	24	Nastringues	24306
1614	24	Naussannes	24307
1615	24	Négrondes	24308
1616	24	Neuvic	24309
1617	24	Nontron	24311
1618	24	Sanilhac	24312
1619	24	Orliac	24313
1620	24	Parcoul-Chenaud	24316
1621	24	Paulin	24317
1622	24	Paunat	24318
1623	24	Paussac-et-Saint-Vivien	24319
1624	24	Payzac	24320
1625	24	Pazayac	24321
1626	24	Périgueux	24322
1627	24	Petit-Bersac	24323
1628	24	Peyrignac	24324
1629	24	Pechs-de-l'Espérance	24325
1630	24	Peyzac-le-Moustier	24326
1631	24	Pezuls	24327
1632	24	Piégut-Pluviers	24328
1633	24	Le Pizou	24329
1634	24	Plazac	24330
1635	24	Pomport	24331
1636	24	Pontours	24334
1637	24	Port-Sainte-Foy-et-Ponchapt	24335
1638	24	Prats-de-Carlux	24336
1639	24	Prats-du-Périgord	24337
1640	24	Pressignac-Vicq	24338
1641	24	Preyssac-d'Excideuil	24339
1642	24	Prigonrieux	24340
1643	24	Proissans	24341
1644	24	Queyssac	24345
1645	24	Quinsac	24346
1646	24	Rampieux	24347
1647	24	Razac-d'Eymet	24348
1648	24	Razac-de-Saussignac	24349
1649	24	Razac-sur-l'Isle	24350
1650	24	Ribagnac	24351
1651	24	Ribérac	24352
1652	24	La Rochebeaucourt-et-Argentine	24353
1653	24	La Roche-Chalais	24354
1654	24	La Roque-Gageac	24355
1655	24	Rouffignac-Saint-Cernin-de-Reilhac	24356
1656	24	Rouffignac-de-Sigoulès	24357
1657	24	Sadillac	24359
1658	24	Sagelat	24360
1659	24	Saint-Agne	24361
1660	24	Val de Louyre et Caudeau	24362
1661	24	Coly-Saint-Amand	24364
1662	24	Saint-Amand-de-Vergt	24365
1663	24	Saint-André-d'Allas	24366
1664	24	Saint-André-de-Double	24367
1665	24	Saint-Antoine-de-Breuilh	24370
1666	24	Saint-Aquilin	24371
1667	24	Saint-Astier	24372
1668	24	Saint-Aubin-de-Cadelech	24373
1669	24	Saint-Aubin-de-Lanquais	24374
1670	24	Saint-Aubin-de-Nabirat	24375
1671	24	Saint Aulaye-Puymangou	24376
1672	24	Saint-Avit-de-Vialard	24377
1673	24	Saint-Avit-Rivière	24378
1674	24	Saint-Avit-Sénieur	24379
1675	24	Saint-Barthélemy-de-Bellegarde	24380
1676	24	Saint-Barthélemy-de-Bussière	24381
1677	24	Saint-Capraise-de-Lalinde	24382
1678	24	Saint-Capraise-d'Eymet	24383
1679	24	Saint-Cassien	24384
1680	24	Saint-Cernin-de-Labarde	24385
1681	24	Saint-Cernin-de-l'Herm	24386
1682	24	Saint-Chamassy	24388
1683	24	Saint-Crépin-d'Auberoche	24390
1684	24	Saint-Crépin-et-Carlucet	24392
1685	24	Sainte-Croix	24393
1686	24	Sainte-Croix-de-Mareuil	24394
1687	24	Saint-Cybranet	24395
1688	24	Saint-Cyprien	24396
1689	24	Saint-Cyr-les-Champagnes	24397
1690	24	Saint-Estèphe	24398
1691	24	Saint-Étienne-de-Puycorbier	24399
1692	24	Sainte-Eulalie-d'Ans	24401
1693	24	Saint-Félix-de-Bourdeilles	24403
1694	24	Saint-Félix-de-Reillac-et-Mortemart	24404
1695	24	Saint-Félix-de-Villadeix	24405
1696	24	Sainte-Foy-de-Belvès	24406
1697	24	Sainte-Foy-de-Longas	24407
1698	24	Saint-Front-d'Alemps	24408
1699	24	Saint-Front-de-Pradoux	24409
1700	24	Saint-Front-la-Rivière	24410
1701	24	Saint-Front-sur-Nizonne	24411
1702	24	Saint-Geniès	24412
1703	24	Saint-Georges-Blancaneix	24413
1704	24	Saint-Georges-de-Montclard	24414
1705	24	Saint-Géraud-de-Corps	24415
1706	24	Saint-Germain-de-Belvès	24416
1707	24	Saint-Germain-des-Prés	24417
1708	24	Saint-Germain-du-Salembre	24418
1709	24	Saint-Germain-et-Mons	24419
1710	24	Saint-Géry	24420
1711	24	Saint-Geyrac	24421
1712	24	Saint-Hilaire-d'Estissac	24422
1713	24	Saint-Julien-Innocence-Eulalie	24423
1714	24	Saint-Jean-d'Ataux	24424
1715	24	Saint-Jean-de-Côle	24425
1716	24	Saint-Jean-d'Estissac	24426
1717	24	Saint-Jory-de-Chalais	24428
1718	24	Saint-Jory-las-Bloux	24429
1719	24	Saint-Julien-de-Lampon	24432
1720	24	Saint-Just	24434
1721	24	Saint-Laurent-des-Hommes	24436
1722	24	Saint-Laurent-des-Vignes	24437
1723	24	Saint-Laurent-la-Vallée	24438
1724	24	Saint-Léon-d'Issigeac	24441
1725	24	Saint-Léon-sur-l'Isle	24442
1726	24	Saint-Léon-sur-Vézère	24443
1727	24	Saint-Louis-en-l'Isle	24444
1728	24	Saint-Marcel-du-Périgord	24445
1729	24	Saint-Marcory	24446
1730	24	Saint-Martial-d'Albarède	24448
1731	24	Saint-Martial-d'Artenset	24449
1732	24	Saint-Martial-de-Nabirat	24450
1733	24	Saint-Martial-de-Valette	24451
1734	24	Saint-Martial-Viveyrol	24452
1735	24	Saint-Martin-de-Fressengeas	24453
1736	24	Saint-Martin-de-Gurson	24454
1737	24	Saint-Martin-de-Ribérac	24455
1738	24	Saint-Martin-des-Combes	24456
1739	24	Saint-Martin-l'Astier	24457
1740	24	Saint-Martin-le-Pin	24458
1741	24	Saint-Mayme-de-Péreyrol	24459
1742	24	Saint-Méard-de-Drône	24460
1743	24	Saint-Méard-de-Gurçon	24461
1744	24	Saint-Médard-de-Mussidan	24462
1745	24	Saint-Médard-d'Excideuil	24463
1746	24	Saint-Mesmin	24464
1747	24	Saint-Michel-de-Double	24465
1748	24	Saint-Michel-de-Montaigne	24466
1749	24	Saint-Michel-de-Villadeix	24468
1750	24	Sainte-Mondane	24470
1751	24	Sainte-Nathalène	24471
1752	24	Saint-Nexans	24472
1753	24	Sainte-Orse	24473
1754	24	Saint-Pancrace	24474
1755	24	Saint-Pantaly-d'Excideuil	24476
1756	24	Saint-Pardoux-de-Drône	24477
1757	24	Saint-Pardoux-et-Vielvic	24478
1758	24	Saint-Pardoux-la-Rivière	24479
1759	24	Saint-Paul-de-Serre	24480
1760	24	Saint-Paul-la-Roche	24481
1761	24	Saint-Paul-Lizonne	24482
1762	24	Saint-Perdoux	24483
1763	24	Saint-Pierre-de-Chignac	24484
1764	24	Saint-Pierre-de-Côle	24485
1765	24	Saint-Pierre-de-Frugie	24486
1766	24	Saint-Pierre-d'Eyraud	24487
1767	24	Saint-Pompon	24488
1768	24	Saint-Priest-les-Fougères	24489
1769	24	Saint Privat en Périgord	24490
1770	24	Saint-Rabier	24491
1771	24	Sainte-Radegonde	24492
1772	24	Saint-Raphaël	24493
1773	24	Saint-Rémy	24494
1774	24	Saint-Romain-de-Monpazier	24495
1775	24	Saint-Romain-et-Saint-Clément	24496
1776	24	Saint-Saud-Lacoussière	24498
1777	24	Saint-Sauveur	24499
1778	24	Saint-Sauveur-Lalande	24500
1779	24	Saint-Seurin-de-Prats	24501
1780	24	Saint-Séverin-d'Estissac	24502
1781	24	Saint-Sulpice-de-Roumagnac	24504
1782	24	Saint-Sulpice-d'Excideuil	24505
1783	24	Sainte-Trie	24507
1784	24	Saint-Victor	24508
1785	24	Saint-Vincent-de-Connezac	24509
1786	24	Saint-Vincent-de-Cosse	24510
1787	24	Saint-Vincent-Jalmoutiers	24511
1788	24	Saint-Vincent-le-Paluel	24512
1789	24	Saint-Vincent-sur-l'Isle	24513
1790	24	Saint-Vivien	24514
1791	24	Salagnac	24515
1792	24	Salignac-Eyvigues	24516
1793	24	Salles-de-Belvès	24517
1794	24	Salon	24518
1795	24	Sarlande	24519
1796	24	Sarlat-la-Canéda	24520
1797	24	Sarliac-sur-l'Isle	24521
1798	24	Sarrazac	24522
1799	24	Saussignac	24523
1800	24	Savignac-de-Miremont	24524
1801	24	Savignac-de-Nontron	24525
1802	24	Savignac-Lédrier	24526
1803	24	Savignac-les-Églises	24527
1804	24	Sceau-Saint-Angel	24528
1805	24	Segonzac	24529
1806	24	Sergeac	24531
1807	24	Serres-et-Montguyard	24532
1808	24	Servanches	24533
1809	24	Sigoulès-et-Flaugeac	24534
1810	24	Simeyrols	24535
1811	24	Singleyrac	24536
1812	24	Siorac-de-Ribérac	24537
1813	24	Siorac-en-Périgord	24538
1814	24	Sorges et Ligueux en Périgord	24540
1815	24	Soudat	24541
1816	24	Soulaures	24542
1817	24	Sourzac	24543
1818	24	Tamniès	24544
1819	24	Teillots	24545
1820	24	Temple-Laguyon	24546
1821	24	Terrasson-Lavilledieu	24547
1822	24	Teyjat	24548
1823	24	Thénac	24549
1824	24	Thenon	24550
1825	24	Thiviers	24551
1826	24	Thonac	24552
1827	24	Tocane-Saint-Apre	24553
1828	24	La Tour-Blanche-Cercles	24554
1829	24	Tourtoirac	24555
1830	24	Trélissac	24557
1831	24	Trémolat	24558
1832	24	Tursac	24559
1833	24	Urval	24560
1834	24	Vallereuil	24562
1835	24	Valojoulx	24563
1836	24	Vanxains	24564
1837	24	Varaignes	24565
1838	24	Varennes	24566
1839	24	Vaunac	24567
1840	24	Vélines	24568
1841	24	Vendoire	24569
1842	24	Verdon	24570
1843	24	Vergt	24571
1844	24	Vergt-de-Biron	24572
1845	24	Verteillac	24573
1846	24	Veyrignac	24574
1847	24	Veyrines-de-Domme	24575
1848	24	Veyrines-de-Vergt	24576
1849	24	Vézac	24577
1850	24	Villac	24580
1851	24	Villamblard	24581
1852	24	Villars	24582
1853	24	Villefranche-de-Lonchat	24584
1854	24	Villefranche-du-Périgord	24585
1855	24	Villetoureix	24586
1856	24	Vitrac	24587
1857	33	Abzac	33001
1858	33	Aillas	33002
1859	33	Ambarès-et-Lagrave	33003
1860	33	Ambès	33004
1861	33	Andernos-les-Bains	33005
1862	33	Anglade	33006
1863	33	Arbanats	33007
1864	33	Porte-de-Benauge	33008
1865	33	Arcachon	33009
1866	33	Arcins	33010
1867	33	Arès	33011
1868	33	Arsac	33012
1869	33	Artigues-près-Bordeaux	33013
1870	33	Les Artigues-de-Lussac	33014
1871	33	Arveyres	33015
1872	33	Asques	33016
1873	33	Aubiac	33017
1874	33	Val de Virvée	33018
1875	33	Audenge	33019
1876	33	Auriolles	33020
1877	33	Auros	33021
1878	33	Avensan	33022
1879	33	Ayguemorte-les-Graves	33023
1880	33	Bagas	33024
1881	33	Baigneaux	33025
1882	33	Balizac	33026
1883	33	Barie	33027
1884	33	Baron	33028
1885	33	Le Barp	33029
1886	33	Barsac	33030
1887	33	Bassanne	33031
1888	33	Bassens	33032
1889	33	Baurech	33033
1890	33	Bayas	33034
1891	33	Bayon-sur-Gironde	33035
1892	33	Bazas	33036
1893	33	Beautiran	33037
1894	33	Bégadan	33038
1895	33	Bègles	33039
1896	33	Béguey	33040
1897	33	Belin-Béliet	33042
1898	33	Bellebat	33043
1899	33	Bellefond	33044
1900	33	Belvès-de-Castillon	33045
1901	33	Bernos-Beaulac	33046
1902	33	Berson	33047
1903	33	Berthez	33048
1904	33	Beychac-et-Caillau	33049
1905	33	Bieujac	33050
1906	33	Biganos	33051
1907	33	Les Billaux	33052
1908	33	Birac	33053
1909	33	Blaignac	33054
1910	33	Blaignan-Prignac	33055
1911	33	Blanquefort	33056
1912	33	Blasimon	33057
1913	33	Blaye	33058
1914	33	Blésignac	33059
1915	33	Bommes	33060
1916	33	Bonnetan	33061
1917	33	Bonzac	33062
1918	33	Bordeaux	33063
1919	33	Bossugan	33064
1920	33	Bouliac	33065
1921	33	Bourdelles	33066
1922	33	Bourg	33067
1923	33	Bourideys	33068
1924	33	Le Bouscat	33069
1925	33	Brach	33070
1926	33	Branne	33071
1927	33	Brannens	33072
1928	33	Braud-et-Saint-Louis	33073
1929	33	Brouqueyran	33074
1930	33	Bruges	33075
1931	33	Budos	33076
1932	33	Cabanac-et-Villagrains	33077
1933	33	Cabara	33078
1934	33	Cadarsac	33079
1935	33	Cadaujac	33080
1936	33	Cadillac-sur-Garonne	33081
1937	33	Cadillac-en-Fronsadais	33082
1938	33	Camarsac	33083
1939	33	Cambes	33084
1940	33	Camblanes-et-Meynac	33085
1941	33	Camiac-et-Saint-Denis	33086
1942	33	Camiran	33087
1943	33	Camps-sur-l'Isle	33088
1944	33	Campugnan	33089
1945	33	Canéjan	33090
1946	33	Capian	33093
1947	33	Caplong	33094
1948	33	Captieux	33095
1949	33	Carbon-Blanc	33096
1950	33	Carcans	33097
1951	33	Cardan	33098
1952	33	Carignan-de-Bordeaux	33099
1953	33	Cars	33100
1954	33	Cartelègue	33101
1955	33	Casseuil	33102
1956	33	Castelmoron-d'Albret	33103
1957	33	Castelnau-de-Médoc	33104
1958	33	Castelviel	33105
1959	33	Castets et Castillon	33106
1960	33	Castillon-la-Bataille	33108
1961	33	Castres-Gironde	33109
1962	33	Caudrot	33111
1963	33	Caumont	33112
1964	33	Cauvignac	33113
1965	33	Cavignac	33114
1966	33	Cazalis	33115
1967	33	Cazats	33116
1968	33	Cazaugitat	33117
1969	33	Cénac	33118
1970	33	Cenon	33119
1971	33	Cérons	33120
1972	33	Cessac	33121
1973	33	Cestas	33122
1974	33	Cézac	33123
1975	33	Chamadelle	33124
1976	33	Cissac-Médoc	33125
1977	33	Civrac-de-Blaye	33126
1978	33	Civrac-sur-Dordogne	33127
1979	33	Civrac-en-Médoc	33128
1980	33	Cleyrac	33129
1981	33	Coimères	33130
1982	33	Coirac	33131
1983	33	Comps	33132
1984	33	Coubeyrac	33133
1985	33	Couquèques	33134
1986	33	Courpiac	33135
1987	33	Cours-de-Monségur	33136
1988	33	Cours-les-Bains	33137
1989	33	Coutras	33138
1990	33	Coutures	33139
1991	33	Créon	33140
1992	33	Croignon	33141
1993	33	Cubnezais	33142
1994	33	Cubzac-les-Ponts	33143
1995	33	Cudos	33144
1996	33	Cursan	33145
1997	33	Cussac-Fort-Médoc	33146
1998	33	Daignac	33147
1999	33	Dardenac	33148
2000	33	Daubèze	33149
2001	33	Dieulivol	33150
2002	33	Donnezac	33151
2003	33	Donzac	33152
2004	33	Doulezon	33153
2005	33	Les Églisottes-et-Chalaures	33154
2006	33	Escaudes	33155
2007	33	Escoussans	33156
2008	33	Espiet	33157
2009	33	Les Esseintes	33158
2010	33	Étauliers	33159
2011	33	Eynesse	33160
2012	33	Eyrans	33161
2013	33	Eysines	33162
2014	33	Faleyras	33163
2015	33	Fargues	33164
2016	33	Fargues-Saint-Hilaire	33165
2017	33	Le Fieu	33166
2018	33	Floirac	33167
2019	33	Flaujagues	33168
2020	33	Floudès	33169
2021	33	Fontet	33170
2022	33	Fossès-et-Baleyssac	33171
2023	33	Fours	33172
2024	33	Francs	33173
2025	33	Fronsac	33174
2026	33	Frontenac	33175
2027	33	Gabarnac	33176
2028	33	Gaillan-en-Médoc	33177
2029	33	Gajac	33178
2030	33	Galgon	33179
2031	33	Gans	33180
2032	33	Gardegan-et-Tourtirac	33181
2033	33	Gauriac	33182
2034	33	Gauriaguet	33183
2035	33	Générac	33184
2036	33	Génissac	33185
2037	33	Gensac	33186
2038	33	Gironde-sur-Dropt	33187
2039	33	Giscos	33188
2040	33	Gornac	33189
2041	33	Goualade	33190
2042	33	Gours	33191
2043	33	Gradignan	33192
2044	33	Grayan-et-l'Hôpital	33193
2045	33	Grézillac	33194
2046	33	Grignols	33195
2047	33	Guillac	33196
2048	33	Guillos	33197
2049	33	Guîtres	33198
2050	33	Gujan-Mestras	33199
2051	33	Le Haillan	33200
2052	33	Haux	33201
2053	33	Hostens	33202
2054	33	Hourtin	33203
2055	33	Hure	33204
2056	33	Illats	33205
2057	33	Isle-Saint-Georges	33206
2058	33	Izon	33207
2059	33	Jau-Dignac-et-Loirac	33208
2060	33	Jugazan	33209
2061	33	Juillac	33210
2062	33	Labarde	33211
2063	33	Labescau	33212
2064	33	La Brède	33213
2065	33	Lacanau	33214
2066	33	Ladaux	33215
2067	33	Lados	33216
2068	33	Lagorce	33218
2069	33	La Lande-de-Fronsac	33219
2070	33	Lamarque	33220
2071	33	Lamothe-Landerron	33221
2072	33	Lalande-de-Pomerol	33222
2073	33	Landerrouat	33223
2074	33	Landerrouet-sur-Ségur	33224
2075	33	Landiras	33225
2076	33	Langoiran	33226
2077	33	Langon	33227
2078	33	Lansac	33228
2079	33	Lanton	33229
2080	33	Lapouyade	33230
2081	33	Laroque	33231
2082	33	Lartigue	33232
2083	33	Laruscade	33233
2084	33	Latresne	33234
2085	33	Lavazan	33235
2086	33	Lège-Cap-Ferret	33236
2087	33	Léogeats	33237
2088	33	Léognan	33238
2089	33	Lerm-et-Musset	33239
2090	33	Lesparre-Médoc	33240
2091	33	Lestiac-sur-Garonne	33241
2092	33	Les Lèves-et-Thoumeyragues	33242
2093	33	Libourne	33243
2094	33	Lignan-de-Bazas	33244
2095	33	Lignan-de-Bordeaux	33245
2096	33	Ligueux	33246
2097	33	Listrac-de-Durèze	33247
2098	33	Listrac-Médoc	33248
2099	33	Lormont	33249
2100	33	Loubens	33250
2101	33	Louchats	33251
2102	33	Loupes	33252
2103	33	Loupiac	33253
2104	33	Loupiac-de-la-Réole	33254
2105	33	Lucmau	33255
2106	33	Ludon-Médoc	33256
2107	33	Lugaignac	33257
2108	33	Lugasson	33258
2109	33	Lugon-et-l'Île-du-Carnay	33259
2110	33	Lugos	33260
2111	33	Lussac	33261
2112	33	Macau	33262
2113	33	Madirac	33263
2114	33	Maransin	33264
2115	33	Marcenais	33266
2116	33	Margaux-Cantenac	33268
2117	33	Margueron	33269
2118	33	Marimbault	33270
2119	33	Marions	33271
2120	33	Marsas	33272
2121	33	Martignas-sur-Jalle	33273
2122	33	Martillac	33274
2123	33	Martres	33275
2124	33	Masseilles	33276
2125	33	Massugas	33277
2126	33	Mauriac	33278
2127	33	Mazères	33279
2128	33	Mazion	33280
2129	33	Mérignac	33281
2130	33	Mérignas	33282
2131	33	Mesterrieux	33283
2132	33	Mios	33284
2133	33	Mombrier	33285
2134	33	Mongauzy	33287
2135	33	Monprimblanc	33288
2136	33	Monségur	33289
2137	33	Montagne	33290
2138	33	Montagoudin	33291
2139	33	Montignac	33292
2140	33	Montussan	33293
2141	33	Morizès	33294
2142	33	Mouillac	33295
2143	33	Mouliets-et-Villemartin	33296
2144	33	Moulis-en-Médoc	33297
2145	33	Moulon	33298
2146	33	Mourens	33299
2147	33	Naujac-sur-Mer	33300
2148	33	Naujan-et-Postiac	33301
2149	33	Néac	33302
2150	33	Nérigean	33303
2151	33	Neuffons	33304
2152	33	Le Nizan	33305
2153	33	Noaillac	33306
2154	33	Noaillan	33307
2155	33	Omet	33308
2156	33	Ordonnac	33309
2157	33	Origne	33310
2158	33	Paillet	33311
2159	33	Parempuyre	33312
2160	33	Pauillac	33314
2161	33	Les Peintures	33315
2162	33	Pellegrue	33316
2163	33	Périssac	33317
2164	33	Pessac	33318
2165	33	Pessac-sur-Dordogne	33319
2166	33	Petit-Palais-et-Cornemps	33320
2167	33	Peujard	33321
2168	33	Le Pian-Médoc	33322
2169	33	Le Pian-sur-Garonne	33323
2170	33	Pineuilh	33324
2171	33	Plassac	33325
2172	33	Pleine-Selve	33326
2173	33	Podensac	33327
2174	33	Pomerol	33328
2175	33	Pompéjac	33329
2176	33	Pompignac	33330
2177	33	Pondaurat	33331
2178	33	Porchères	33332
2179	33	Le Porge	33333
2180	33	Portets	33334
2181	33	Le Pout	33335
2182	33	Préchac	33336
2183	33	Preignac	33337
2184	33	Prignac-et-Marcamps	33339
2185	33	Pugnac	33341
2186	33	Puisseguin	33342
2187	33	Pujols-sur-Ciron	33343
2188	33	Pujols	33344
2189	33	Le Puy	33345
2190	33	Puybarban	33346
2191	33	Puynormand	33347
2192	33	Queyrac	33348
2193	33	Quinsac	33349
2194	33	Rauzan	33350
2195	33	Reignac	33351
2196	33	La Réole	33352
2197	33	Rimons	33353
2198	33	Riocaud	33354
2199	33	Rions	33355
2200	33	La Rivière	33356
2201	33	Roaillan	33357
2202	33	Romagne	33358
2203	33	Roquebrune	33359
2204	33	La Roquille	33360
2205	33	Ruch	33361
2206	33	Sablons	33362
2207	33	Sadirac	33363
2208	33	Saillans	33364
2209	33	Saint-Aignan	33365
2210	33	Saint-André-de-Cubzac	33366
2211	33	Saint-André-du-Bois	33367
2212	33	Saint-André-et-Appelles	33369
2213	33	Saint-Androny	33370
2214	33	Saint-Antoine-du-Queyret	33372
2215	33	Saint-Antoine-sur-l'Isle	33373
2216	33	Saint-Aubin-de-Blaye	33374
2217	33	Saint-Aubin-de-Branne	33375
2218	33	Saint-Aubin-de-Médoc	33376
2219	33	Saint-Avit-de-Soulège	33377
2220	33	Saint-Avit-Saint-Nazaire	33378
2221	33	Saint-Brice	33379
2222	33	Val-de-Livenne	33380
2223	33	Saint-Caprais-de-Bordeaux	33381
2224	33	Saint-Christoly-de-Blaye	33382
2225	33	Saint-Christoly-Médoc	33383
2226	33	Saint-Christophe-des-Bardes	33384
2227	33	Saint-Christophe-de-Double	33385
2228	33	Saint-Cibard	33386
2229	33	Saint-Ciers-d'Abzac	33387
2230	33	Saint-Ciers-de-Canesse	33388
2231	33	Saint-Ciers-sur-Gironde	33389
2232	33	Sainte-Colombe	33390
2233	33	Saint-Côme	33391
2234	33	Sainte-Croix-du-Mont	33392
2235	33	Saint-Denis-de-Pile	33393
2236	33	Saint-Émilion	33394
2237	33	Saint-Estèphe	33395
2238	33	Saint-Étienne-de-Lisse	33396
2239	33	Sainte-Eulalie	33397
2240	33	Saint-Exupéry	33398
2241	33	Saint-Félix-de-Foncaude	33399
2242	33	Saint-Ferme	33400
2243	33	Sainte-Florence	33401
2244	33	Sainte-Foy-la-Grande	33402
2245	33	Sainte-Foy-la-Longue	33403
2246	33	Sainte-Gemme	33404
2247	33	Saint-Genès-de-Blaye	33405
2248	33	Saint-Genès-de-Castillon	33406
2249	33	Saint-Genès-de-Fronsac	33407
2250	33	Saint-Genès-de-Lombaud	33408
2251	33	Saint-Germain-de-Grave	33411
2252	33	Saint-Germain-d'Esteuil	33412
2253	33	Saint-Germain-du-Puch	33413
2254	33	Saint-Germain-de-la-Rivière	33414
2255	33	Saint-Gervais	33415
2256	33	Saint-Girons-d'Aiguevives	33416
2257	33	Sainte-Hélène	33417
2258	33	Saint-Hilaire-de-la-Noaille	33418
2259	33	Saint-Hilaire-du-Bois	33419
2260	33	Saint-Hippolyte	33420
2261	33	Saint-Jean-de-Blaignac	33421
2262	33	Saint-Jean-d'Illac	33422
2263	33	Saint-Julien-Beychevelle	33423
2264	33	Saint-Laurent-Médoc	33424
2265	33	Saint-Laurent-d'Arce	33425
2266	33	Saint-Laurent-des-Combes	33426
2267	33	Saint-Laurent-du-Bois	33427
2268	33	Saint-Laurent-du-Plan	33428
2269	33	Saint-Léger-de-Balson	33429
2270	33	Saint-Léon	33431
2271	33	Saint-Loubert	33432
2272	33	Saint-Loubès	33433
2273	33	Saint-Louis-de-Montferrand	33434
2274	33	Saint-Macaire	33435
2275	33	Saint-Magne	33436
2276	33	Saint-Magne-de-Castillon	33437
2277	33	Saint-Maixant	33438
2278	33	Saint-Mariens	33439
2279	33	Saint-Martial	33440
2280	33	Saint-Martin-Lacaussade	33441
2281	33	Saint-Martin-de-Laye	33442
2282	33	Saint-Martin-de-Lerm	33443
2283	33	Saint-Martin-de-Sescas	33444
2284	33	Saint-Martin-du-Bois	33445
2285	33	Saint-Martin-du-Puy	33446
2286	33	Saint-Médard-de-Guizières	33447
2287	33	Saint-Médard-d'Eyrans	33448
2288	33	Saint-Médard-en-Jalles	33449
2289	33	Saint-Michel-de-Castelnau	33450
2290	33	Saint-Michel-de-Fronsac	33451
2291	33	Saint-Michel-de-Rieufret	33452
2292	33	Saint-Michel-de-Lapujade	33453
2293	33	Saint-Morillon	33454
2294	33	Saint-Palais	33456
2295	33	Saint-Pardon-de-Conques	33457
2296	33	Saint-Paul	33458
2297	33	Saint-Pey-d'Armens	33459
2298	33	Saint-Pey-de-Castets	33460
2299	33	Saint-Philippe-d'Aiguilhe	33461
2300	33	Saint-Philippe-du-Seignal	33462
2301	33	Saint-Pierre-d'Aurillac	33463
2302	33	Saint-Pierre-de-Bat	33464
2303	33	Saint-Pierre-de-Mons	33465
2304	33	Saint-Quentin-de-Baron	33466
2305	33	Saint-Quentin-de-Caplong	33467
2306	33	Sainte-Radegonde	33468
2307	33	Saint-Romain-la-Virvée	33470
2308	33	Saint-Sauveur	33471
2309	33	Saint-Sauveur-de-Puynormand	33472
2310	33	Saint-Savin	33473
2311	33	Saint-Selve	33474
2312	33	Saint-Seurin-de-Bourg	33475
2313	33	Saint-Seurin-de-Cadourne	33476
2314	33	Saint-Seurin-de-Cursac	33477
2315	33	Saint-Seurin-sur-l'Isle	33478
2316	33	Saint-Sève	33479
2317	33	Saint-Sulpice-de-Faleyrens	33480
2318	33	Saint-Sulpice-de-Guilleragues	33481
2319	33	Saint-Sulpice-de-Pommiers	33482
2320	33	Saint-Sulpice-et-Cameyrac	33483
2321	33	Saint-Symphorien	33484
2322	33	Sainte-Terre	33485
2323	33	Saint-Trojan	33486
2324	33	Saint-Vincent-de-Paul	33487
2325	33	Saint-Vincent-de-Pertignas	33488
2326	33	Saint-Vivien-de-Blaye	33489
2327	33	Saint-Vivien-de-Médoc	33490
2328	33	Saint-Vivien-de-Monségur	33491
2329	33	Saint-Yzan-de-Soudiac	33492
2330	33	Saint-Yzans-de-Médoc	33493
2331	33	Salaunes	33494
2332	33	Sallebœuf	33496
2333	33	Salles	33498
2334	33	Les Salles-de-Castillon	33499
2335	33	Samonac	33500
2336	33	Saucats	33501
2337	33	Saugon	33502
2338	33	Saumos	33503
2339	33	Sauternes	33504
2340	33	La Sauve	33505
2341	33	Sauveterre-de-Guyenne	33506
2342	33	Sauviac	33507
2343	33	Savignac	33508
2344	33	Savignac-de-l'Isle	33509
2345	33	Semens	33510
2346	33	Sendets	33511
2347	33	Sigalens	33512
2348	33	Sillas	33513
2349	33	Soulac-sur-Mer	33514
2350	33	Soulignac	33515
2351	33	Soussac	33516
2352	33	Soussans	33517
2353	33	Tabanac	33518
2354	33	Le Taillan-Médoc	33519
2355	33	Taillecavat	33520
2356	33	Talais	33521
2357	33	Talence	33522
2358	33	Targon	33523
2359	33	Tarnès	33524
2360	33	Tauriac	33525
2361	33	Tayac	33526
2362	33	Le Teich	33527
2363	33	Le Temple	33528
2364	33	La Teste-de-Buch	33529
2365	33	Teuillac	33530
2366	33	Tizac-de-Curton	33531
2367	33	Tizac-de-Lapouyade	33532
2368	33	Toulenne	33533
2369	33	Le Tourne	33534
2370	33	Tresses	33535
2371	33	Le Tuzan	33536
2372	33	Uzeste	33537
2373	33	Valeyrac	33538
2374	33	Vayres	33539
2375	33	Vendays-Montalivet	33540
2376	33	Vensac	33541
2377	33	Vérac	33542
2378	33	Verdelais	33543
2379	33	Le Verdon-sur-Mer	33544
2380	33	Vertheuil	33545
2381	33	Vignonet	33546
2382	33	Villandraut	33547
2383	33	Villegouge	33548
2384	33	Villenave-de-Rions	33549
2385	33	Villenave-d'Ornon	33550
2386	33	Villeneuve	33551
2387	33	Virelade	33552
2388	33	Virsac	33553
2389	33	Yvrac	33554
2390	33	Marcheprime	33555
2391	40	Aire-sur-l'Adour	40001
2392	40	Amou	40002
2393	40	Angoumé	40003
2394	40	Angresse	40004
2395	40	Arboucave	40005
2396	40	Arengosse	40006
2397	40	Argelos	40007
2398	40	Argelouse	40008
2399	40	Arsague	40011
2400	40	Artassenx	40012
2401	40	Arthez-d'Armagnac	40013
2402	40	Arue	40014
2403	40	Arx	40015
2404	40	Aubagnan	40016
2405	40	Audignon	40017
2406	40	Audon	40018
2407	40	Aureilhan	40019
2408	40	Aurice	40020
2409	40	Azur	40021
2410	40	Bahus-Soubiran	40022
2411	40	Baigts	40023
2412	40	Banos	40024
2413	40	Bascons	40025
2414	40	Bas-Mauco	40026
2415	40	Bassercles	40027
2416	40	Bastennes	40028
2417	40	Bats	40029
2418	40	Baudignan	40030
2419	40	Bégaar	40031
2420	40	Belhade	40032
2421	40	Bélis	40033
2422	40	Bélus	40034
2423	40	Bénesse-lès-Dax	40035
2424	40	Bénesse-Maremne	40036
2425	40	Benquet	40037
2426	40	Bergouey	40038
2427	40	Betbezer-d'Armagnac	40039
2428	40	Beylongue	40040
2429	40	Beyries	40041
2430	40	Biarrotte	40042
2431	40	Bias	40043
2432	40	Biaudos	40044
2433	40	Biscarrosse	40046
2434	40	Bonnegarde	40047
2435	40	Bordères-et-Lamensans	40049
2436	40	Bostens	40050
2437	40	Bougue	40051
2438	40	Bourdalat	40052
2439	40	Bourriot-Bergonce	40053
2440	40	Brassempouy	40054
2441	40	Bretagne-de-Marsan	40055
2442	40	Brocas	40056
2443	40	Buanes	40057
2444	40	Cachen	40058
2445	40	Cagnotte	40059
2446	40	Callen	40060
2447	40	Campagne	40061
2448	40	Campet-et-Lamolère	40062
2449	40	Candresse	40063
2450	40	Canenx-et-Réaut	40064
2451	40	Capbreton	40065
2452	40	Carcarès-Sainte-Croix	40066
2453	40	Carcen-Ponson	40067
2454	40	Cassen	40068
2455	40	Castaignos-Souslens	40069
2456	40	Castandet	40070
2457	40	Castelnau-Chalosse	40071
2458	40	Castelnau-Tursan	40072
2459	40	Castelner	40073
2460	40	Castel-Sarrazin	40074
2461	40	Castets	40075
2462	40	Cauna	40076
2463	40	Cauneille	40077
2464	40	Caupenne	40078
2465	40	Cazalis	40079
2466	40	Cazères-sur-l'Adour	40080
2467	40	Cère	40081
2468	40	Classun	40082
2469	40	Clèdes	40083
2470	40	Clermont	40084
2471	40	Commensacq	40085
2472	40	Coudures	40086
2473	40	Créon-d'Armagnac	40087
2474	40	Dax	40088
2475	40	Doazit	40089
2476	40	Donzacq	40090
2477	40	Duhort-Bachen	40091
2478	40	Dumes	40092
2479	40	Escalans	40093
2480	40	Escource	40094
2481	40	Estibeaux	40095
2482	40	Estigarde	40096
2483	40	Eugénie-les-Bains	40097
2484	40	Eyres-Moncube	40098
2485	40	Fargues	40099
2486	40	Le Frêche	40100
2487	40	Gaas	40101
2488	40	Gabarret	40102
2489	40	Gaillères	40103
2490	40	Gamarde-les-Bains	40104
2491	40	Garein	40105
2492	40	Garrey	40106
2493	40	Gastes	40108
2494	40	Gaujacq	40109
2495	40	Geaune	40110
2496	40	Geloux	40111
2497	40	Gibret	40112
2498	40	Goos	40113
2499	40	Gourbera	40114
2500	40	Gousse	40115
2501	40	Gouts	40116
2502	40	Grenade-sur-l'Adour	40117
2503	40	Habas	40118
2504	40	Hagetmau	40119
2505	40	Hastingues	40120
2506	40	Hauriet	40121
2507	40	Haut-Mauco	40122
2508	40	Herm	40123
2509	40	Herré	40124
2510	40	Heugas	40125
2511	40	Hinx	40126
2512	40	Hontanx	40127
2513	40	Horsarrieu	40128
2514	40	Josse	40129
2515	40	Labastide-Chalosse	40130
2516	40	Labastide-d'Armagnac	40131
2517	40	Labatut	40132
2518	40	Labenne	40133
2519	40	Labouheyre	40134
2520	40	Labrit	40135
2521	40	Lacajunte	40136
2522	40	Lacquy	40137
2523	40	Lacrabe	40138
2524	40	Laglorieuse	40139
2525	40	Lagrange	40140
2526	40	Lahosse	40141
2527	40	Laluque	40142
2528	40	Lamothe	40143
2529	40	Larbey	40144
2530	40	Larrivière-Saint-Savin	40145
2531	40	Latrille	40146
2532	40	Laurède	40147
2533	40	Lauret	40148
2534	40	Lencouacq	40149
2535	40	Léon	40150
2536	40	Lesgor	40151
2537	40	Lesperon	40152
2538	40	Le Leuy	40153
2539	40	Lévignacq	40154
2540	40	Linxe	40155
2541	40	Liposthey	40156
2542	40	Lit-et-Mixe	40157
2543	40	Losse	40158
2544	40	Louer	40159
2545	40	Lourquen	40160
2546	40	Lubbon	40161
2547	40	Lucbardez-et-Bargues	40162
2548	40	Lüe	40163
2549	40	Retjons	40164
2550	40	Luglon	40165
2551	40	Lussagnet	40166
2552	40	Luxey	40167
2553	40	Magescq	40168
2554	40	Maillas	40169
2555	40	Maillères	40170
2556	40	Mano	40171
2557	40	Mant	40172
2558	40	Marpaps	40173
2559	40	Mauries	40174
2560	40	Maurrin	40175
2561	40	Mauvezin-d'Armagnac	40176
2562	40	Maylis	40177
2563	40	Mazerolles	40178
2564	40	Mées	40179
2565	40	Meilhan	40180
2566	40	Messanges	40181
2567	40	Mézos	40182
2568	40	Mimbaste	40183
2569	40	Mimizan	40184
2570	40	Miramont-Sensacq	40185
2571	40	Misson	40186
2572	40	Moliets-et-Maa	40187
2573	40	Momuy	40188
2574	40	Monget	40189
2575	40	Monségur	40190
2576	40	Montaut	40191
2577	40	Mont-de-Marsan	40192
2578	40	Montégut	40193
2579	40	Montfort-en-Chalosse	40194
2580	40	Montgaillard	40195
2581	40	Montsoué	40196
2582	40	Morcenx-la-Nouvelle	40197
2583	40	Morganx	40198
2584	40	Mouscardès	40199
2585	40	Moustey	40200
2586	40	Mugron	40201
2587	40	Narrosse	40202
2588	40	Nassiet	40203
2589	40	Nerbis	40204
2590	40	Nousse	40205
2591	40	Oeyregave	40206
2592	40	Oeyreluy	40207
2593	40	Onard	40208
2594	40	Ondres	40209
2595	40	Onesse-Laharie	40210
2596	40	Orist	40211
2597	40	Orthevielle	40212
2598	40	Orx	40213
2599	40	Ossages	40214
2600	40	Ousse-Suzan	40215
2601	40	Ozourt	40216
2602	40	Parentis-en-Born	40217
2603	40	Parleboscq	40218
2604	40	Payros-Cazautets	40219
2605	40	Pécorade	40220
2606	40	Perquie	40221
2607	40	Pey	40222
2608	40	Peyre	40223
2609	40	Peyrehorade	40224
2610	40	Philondenx	40225
2611	40	Pimbo	40226
2612	40	Pissos	40227
2613	40	Pomarez	40228
2614	40	Pontenx-les-Forges	40229
2615	40	Pontonx-sur-l'Adour	40230
2616	40	Port-de-Lanne	40231
2617	40	Poudenx	40232
2618	40	Pouillon	40233
2619	40	Pouydesseaux	40234
2620	40	Poyanne	40235
2621	40	Poyartin	40236
2622	40	Préchacq-les-Bains	40237
2623	40	Pujo-le-Plan	40238
2624	40	Puyol-Cazalet	40239
2625	40	Renung	40240
2626	40	Rimbez-et-Baudiets	40242
2627	40	Rion-des-Landes	40243
2628	40	Rivière-Saas-et-Gourby	40244
2629	40	Roquefort	40245
2630	40	Sabres	40246
2631	40	Saint-Agnet	40247
2632	40	Saint-André-de-Seignanx	40248
2633	40	Saint-Aubin	40249
2634	40	Saint-Avit	40250
2635	40	Saint-Barthélemy	40251
2636	40	Sainte-Colombe	40252
2637	40	Saint-Cricq-Chalosse	40253
2638	40	Saint-Cricq-du-Gave	40254
2639	40	Saint-Cricq-Villeneuve	40255
2640	40	Saint-Étienne-d'Orthe	40256
2641	40	Sainte-Eulalie-en-Born	40257
2642	40	Sainte-Foy	40258
2643	40	Saint-Gein	40259
2644	40	Saint-Geours-d'Auribat	40260
2645	40	Saint-Geours-de-Maremne	40261
2646	40	Saint-Gor	40262
2647	40	Saint-Jean-de-Lier	40263
2648	40	Saint-Jean-de-Marsacq	40264
2649	40	Saint-Julien-d'Armagnac	40265
2650	40	Saint-Julien-en-Born	40266
2651	40	Saint-Justin	40267
2652	40	Saint-Laurent-de-Gosse	40268
2653	40	Saint-Lon-les-Mines	40269
2654	40	Saint-Loubouer	40270
2655	40	Sainte-Marie-de-Gosse	40271
2656	40	Saint-Martin-de-Hinx	40272
2657	40	Saint-Martin-de-Seignanx	40273
2658	40	Saint-Martin-d'Oney	40274
2659	40	Saint-Maurice-sur-Adour	40275
2660	40	Saint-Michel-Escalus	40276
2661	40	Saint-Pandelon	40277
2662	40	Saint-Paul-en-Born	40278
2663	40	Saint-Paul-lès-Dax	40279
2664	40	Saint-Perdon	40280
2665	40	Saint-Pierre-du-Mont	40281
2666	40	Saint-Sever	40282
2667	40	Saint-Vincent-de-Paul	40283
2668	40	Saint-Vincent-de-Tyrosse	40284
2669	40	Saint-Yaguen	40285
2670	40	Samadet	40286
2671	40	Sanguinet	40287
2672	40	Sarbazan	40288
2673	40	Sarraziet	40289
2674	40	Sarron	40290
2675	40	Saubion	40291
2676	40	Saubrigues	40292
2677	40	Saubusse	40293
2678	40	Saugnac-et-Cambran	40294
2679	40	Saugnac-et-Muret	40295
2680	40	Seignosse	40296
2681	40	Le Sen	40297
2682	40	Serres-Gaston	40298
2683	40	Serreslous-et-Arribans	40299
2684	40	Seyresse	40300
2685	40	Siest	40301
2686	40	Solférino	40303
2687	40	Soorts-Hossegor	40304
2688	40	Sorbets	40305
2689	40	Sorde-l'Abbaye	40306
2690	40	Sore	40307
2691	40	Sort-en-Chalosse	40308
2692	40	Souprosse	40309
2693	40	Soustons	40310
2694	40	Taller	40311
2695	40	Tarnos	40312
2696	40	Tartas	40313
2697	40	Tercis-les-Bains	40314
2698	40	Téthieu	40315
2699	40	Tilh	40316
2700	40	Tosse	40317
2701	40	Toulouzette	40318
2702	40	Trensacq	40319
2703	40	Uchacq-et-Parentis	40320
2704	40	Urgons	40321
2705	40	Uza	40322
2706	40	Vert	40323
2707	40	Vicq-d'Auribat	40324
2708	40	Vielle-Tursan	40325
2709	40	Vielle-Saint-Girons	40326
2710	40	Vielle-Soubiran	40327
2711	40	Vieux-Boucau-les-Bains	40328
2712	40	Le Vignau	40329
2713	40	Villenave	40330
2714	40	Villeneuve-de-Marsan	40331
2715	40	Ychoux	40332
2716	40	Ygos-Saint-Saturnin	40333
2717	40	Yzosse	40334
2718	47	Agen	47001
2719	47	Agmé	47002
2720	47	Agnac	47003
2721	47	Aiguillon	47004
2722	47	Allemans-du-Dropt	47005
2723	47	Allez-et-Cazeneuve	47006
2724	47	Allons	47007
2725	47	Ambrus	47008
2726	47	Andiran	47009
2727	47	Antagnac	47010
2728	47	Anthé	47011
2729	47	Anzex	47012
2730	47	Argenton	47013
2731	47	Armillac	47014
2732	47	Astaffort	47015
2733	47	Aubiac	47016
2734	47	Auradou	47017
2735	47	Auriac-sur-Dropt	47018
2736	47	Bajamont	47019
2737	47	Baleyssagues	47020
2738	47	Barbaste	47021
2739	47	Bazens	47022
2740	47	Beaugas	47023
2741	47	Beaupuy	47024
2742	47	Beauville	47025
2743	47	Beauziac	47026
2744	47	Bias	47027
2745	47	Birac-sur-Trec	47028
2746	47	Blanquefort-sur-Briolance	47029
2747	47	Blaymont	47030
2748	47	Boé	47031
2749	47	Bon-Encontre	47032
2750	47	Boudy-de-Beauregard	47033
2751	47	Bouglon	47034
2752	47	Bourgougnague	47035
2753	47	Bourlens	47036
2754	47	Bournel	47037
2755	47	Bourran	47038
2756	47	Boussès	47039
2757	47	Brax	47040
2758	47	Bruch	47041
2759	47	Brugnac	47042
2760	47	Buzet-sur-Baïse	47043
2761	47	Cahuzac	47044
2762	47	Calignac	47045
2763	47	Calonges	47046
2764	47	Cambes	47047
2765	47	Cancon	47048
2766	47	Casseneuil	47049
2767	47	Cassignas	47050
2768	47	Castelculier	47051
2769	47	Casteljaloux	47052
2770	47	Castella	47053
2771	47	Castelmoron-sur-Lot	47054
2772	47	Castelnaud-de-Gratecambe	47055
2773	47	Castelnau-sur-Gupie	47056
2774	47	Castillonnès	47057
2775	47	Caubeyres	47058
2776	47	Caubon-Saint-Sauveur	47059
2777	47	Caudecoste	47060
2778	47	Caumont-sur-Garonne	47061
2779	47	Cauzac	47062
2780	47	Cavarc	47063
2781	47	Cazideroque	47064
2782	47	Clairac	47065
2783	47	Clermont-Dessous	47066
2784	47	Clermont-Soubiran	47067
2785	47	Cocumont	47068
2786	47	Colayrac-Saint-Cirq	47069
2787	47	Condezaygues	47070
2788	47	Coulx	47071
2789	47	Courbiac	47072
2790	47	Cours	47073
2791	47	Couthures-sur-Garonne	47074
2792	47	La Croix-Blanche	47075
2793	47	Cuq	47076
2794	47	Cuzorn	47077
2795	47	Damazan	47078
2796	47	Dausse	47079
2797	47	Dévillac	47080
2798	47	Dolmayrac	47081
2799	47	Dondas	47082
2800	47	Doudrac	47083
2801	47	Douzains	47084
2802	47	Durance	47085
2803	47	Duras	47086
2804	47	Engayrac	47087
2805	47	Escassefort	47088
2806	47	Esclottes	47089
2807	47	Espiens	47090
2808	47	Estillac	47091
2809	47	Fals	47092
2810	47	Fargues-sur-Ourbise	47093
2811	47	Fauguerolles	47094
2812	47	Fauillet	47095
2813	47	Ferrensac	47096
2814	47	Feugarolles	47097
2815	47	Fieux	47098
2816	47	Fongrave	47099
2817	47	Foulayronnes	47100
2818	47	Fourques-sur-Garonne	47101
2819	47	Francescas	47102
2820	47	Fréchou	47103
2821	47	Frégimont	47104
2822	47	Frespech	47105
2823	47	Fumel	47106
2824	47	Galapian	47107
2825	47	Gaujac	47108
2826	47	Gavaudun	47109
2827	47	Gontaud-de-Nogaret	47110
2828	47	Granges-sur-Lot	47111
2829	47	Grateloup-Saint-Gayrand	47112
2830	47	Grayssas	47113
2831	47	Grézet-Cavagnan	47114
2832	47	Guérin	47115
2833	47	Hautefage-la-Tour	47117
2834	47	Hautesvignes	47118
2835	47	Houeillès	47119
2836	47	Jusix	47120
2837	47	Labastide-Castel-Amouroux	47121
2838	47	Labretonie	47122
2839	47	Lacapelle-Biron	47123
2840	47	Lacaussade	47124
2841	47	Lacépède	47125
2842	47	Lachapelle	47126
2843	47	Lafitte-sur-Lot	47127
2844	47	Lafox	47128
2845	47	Lagarrigue	47129
2846	47	Lagruère	47130
2847	47	Lagupie	47131
2848	47	Lalandusse	47132
2849	47	Lamontjoie	47133
2850	47	Lannes	47134
2851	47	Laparade	47135
2852	47	Laperche	47136
2853	47	Laplume	47137
2854	47	Laroque-Timbaut	47138
2855	47	Lasserre	47139
2856	47	Laugnac	47140
2857	47	Laussou	47141
2858	47	Lauzun	47142
2859	47	Lavardac	47143
2860	47	Lavergne	47144
2861	47	Layrac	47145
2862	47	Lédat	47146
2863	47	Lévignac-de-Guyenne	47147
2864	47	Leyritz-Moncassin	47148
2865	47	Longueville	47150
2866	47	Loubès-Bernac	47151
2867	47	Lougratte	47152
2868	47	Lusignan-Petit	47154
2869	47	Madaillan	47155
2870	47	Marcellus	47156
2871	47	Marmande	47157
2872	47	Marmont-Pachas	47158
2873	47	Le Mas-d'Agenais	47159
2874	47	Masquières	47160
2875	47	Massels	47161
2876	47	Massoulès	47162
2877	47	Mauvezin-sur-Gupie	47163
2878	47	Mazières-Naresse	47164
2879	47	Meilhan-sur-Garonne	47165
2880	47	Mézin	47167
2881	47	Miramont-de-Guyenne	47168
2882	47	Moirax	47169
2883	47	Monbahus	47170
2884	47	Monbalen	47171
2885	47	Moncaut	47172
2886	47	Monclar	47173
2887	47	Moncrabeau	47174
2888	47	Monflanquin	47175
2889	47	Montgaillard-en-Albret	47176
2890	47	Monheurt	47177
2891	47	Monségur	47178
2892	47	Monsempron-Libos	47179
2893	47	Montagnac-sur-Auvignon	47180
2894	47	Montagnac-sur-Lède	47181
2895	47	Montastruc	47182
2896	47	Montauriol	47183
2897	47	Montaut	47184
2898	47	Montayral	47185
2899	47	Montesquieu	47186
2900	47	Monteton	47187
2901	47	Montignac-de-Lauzun	47188
2902	47	Montignac-Toupinerie	47189
2903	47	Montpezat	47190
2904	47	Montpouillan	47191
2905	47	Monviel	47192
2906	47	Moulinet	47193
2907	47	Moustier	47194
2908	47	Nérac	47195
2909	47	Nicole	47196
2910	47	Nomdieu	47197
2911	47	Pailloles	47198
2912	47	Pardaillan	47199
2913	47	Parranquet	47200
2914	47	Le Passage	47201
2915	47	Paulhiac	47202
2916	47	Penne-d'Agenais	47203
2917	47	Peyrière	47204
2918	47	Pindères	47205
2919	47	Pinel-Hauterive	47206
2920	47	Pompiey	47207
2921	47	Pompogne	47208
2922	47	Pont-du-Casse	47209
2923	47	Port-Sainte-Marie	47210
2924	47	Poudenas	47211
2925	47	Poussignac	47212
2926	47	Prayssas	47213
2927	47	Puch-d'Agenais	47214
2928	47	Pujols	47215
2929	47	Puymiclan	47216
2930	47	Puymirol	47217
2931	47	Puysserampion	47218
2932	47	Rayet	47219
2933	47	Razimet	47220
2934	47	Réaup-Lisse	47221
2935	47	La Réunion	47222
2936	47	Rives	47223
2937	47	Romestaing	47224
2938	47	Roquefort	47225
2939	47	Roumagne	47226
2940	47	Ruffiac	47227
2941	47	Saint-Antoine-de-Ficalba	47228
2942	47	Saint-Astier	47229
2943	47	Saint-Aubin	47230
2944	47	Saint-Avit	47231
2945	47	Saint-Barthélemy-d'Agenais	47232
2946	47	Sainte-Bazeille	47233
2947	47	Saint-Caprais-de-Lerm	47234
2948	47	Saint-Colomb-de-Lauzun	47235
2949	47	Sainte-Colombe-de-Duras	47236
2950	47	Sainte-Colombe-de-Villeneuve	47237
2951	47	Sainte-Colombe-en-Bruilhois	47238
2952	47	Saint-Étienne-de-Fougères	47239
2953	47	Saint-Étienne-de-Villeréal	47240
2954	47	Saint-Eutrope-de-Born	47241
2955	47	Saint-Front-sur-Lémance	47242
2956	47	Sainte-Gemme-Martaillac	47244
2957	47	Saint-Géraud	47245
2958	47	Saint-Hilaire-de-Lusignan	47246
2959	47	Saint-Jean-de-Duras	47247
2960	47	Saint-Jean-de-Thurac	47248
2961	47	Saint-Laurent	47249
2962	47	Saint-Léger	47250
2963	47	Saint-Léon	47251
2964	47	Sainte-Livrade-sur-Lot	47252
2965	47	Sainte-Marthe	47253
2966	47	Saint-Martin-Curton	47254
2967	47	Saint-Martin-de-Beauville	47255
2968	47	Saint-Martin-de-Villeréal	47256
2969	47	Saint-Martin-Petit	47257
2970	47	Sainte-Maure-de-Peyriac	47258
2971	47	Saint-Maurice-de-Lestapel	47259
2972	47	Saint-Maurin	47260
2973	47	Saint-Nicolas-de-la-Balerme	47262
2974	47	Saint-Pardoux-du-Breuil	47263
2975	47	Saint-Pardoux-Isaac	47264
2976	47	Saint-Pastour	47265
2977	47	Saint-Pé-Saint-Simon	47266
2978	47	Saint-Pierre-de-Buzet	47267
2979	47	Saint-Pierre-de-Clairac	47269
2980	47	Saint-Pierre-sur-Dropt	47271
2981	47	Saint-Quentin-du-Dropt	47272
2982	47	Saint-Robert	47273
2983	47	Saint-Romain-le-Noble	47274
2984	47	Saint-Salvy	47275
2985	47	Saint-Sardos	47276
2986	47	Saint-Sauveur-de-Meilhan	47277
2987	47	Saint-Sernin	47278
2988	47	Saint-Sixte	47279
2989	47	Saint-Sylvestre-sur-Lot	47280
2990	47	Saint-Urcisse	47281
2991	47	Saint-Vincent-de-Lamontjoie	47282
2992	47	Saint-Vite	47283
2993	47	Salles	47284
2994	47	Samazan	47285
2995	47	Sauméjan	47286
2996	47	Saumont	47287
2997	47	Sauvagnas	47288
2998	47	La Sauvetat-de-Savères	47289
2999	47	La Sauvetat-du-Dropt	47290
3000	47	La Sauvetat-sur-Lède	47291
3001	47	Sauveterre-la-Lémance	47292
3002	47	Sauveterre-Saint-Denis	47293
3003	47	Savignac-de-Duras	47294
3004	47	Savignac-sur-Leyze	47295
3005	47	Ségalas	47296
3006	47	Sembas	47297
3007	47	Sénestis	47298
3008	47	Sérignac-Péboudou	47299
3009	47	Sérignac-sur-Garonne	47300
3010	47	Seyches	47301
3011	47	Sos	47302
3012	47	Soumensac	47303
3013	47	Taillebourg	47304
3014	47	Tayrac	47305
3015	47	Le Temple-sur-Lot	47306
3016	47	Thézac	47307
3017	47	Thouars-sur-Garonne	47308
3018	47	Tombebœuf	47309
3019	47	Tonneins	47310
3020	47	Tourliac	47311
3021	47	Tournon-d'Agenais	47312
3022	47	Tourtrès	47313
3023	47	Trémons	47314
3024	47	Trentels	47315
3025	47	Varès	47316
3026	47	Verteuil-d'Agenais	47317
3027	47	Vianne	47318
3028	47	Villebramar	47319
3029	47	Villefranche-du-Queyran	47320
3030	47	Villeneuve-de-Duras	47321
3031	47	Villeneuve-sur-Lot	47323
3032	47	Villeréal	47324
3033	47	Villeton	47325
3034	47	Virazeil	47326
3035	47	Xaintrailles	47327
3036	47	Saint-Georges	47328
3037	64	Aast	64001
3038	64	Abère	64002
3039	64	Abidos	64003
3040	64	Abitain	64004
3041	64	Abos	64005
3042	64	Accous	64006
3043	64	Agnos	64007
3044	64	Ahaxe-Alciette-Bascassan	64008
3045	64	Ahetze	64009
3046	64	Aïcirits-Camou-Suhast	64010
3047	64	Aincille	64011
3048	64	Ainharp	64012
3049	64	Ainhice-Mongelos	64013
3050	64	Ainhoa	64014
3051	64	Alçay-Alçabéhéty-Sunharette	64015
3052	64	Aldudes	64016
3053	64	Alos-Sibas-Abense	64017
3054	64	Amendeuix-Oneix	64018
3055	64	Amorots-Succos	64019
3056	64	Andoins	64021
3057	64	Andrein	64022
3058	64	Angaïs	64023
3059	64	Anglet	64024
3060	64	Angous	64025
3061	64	Anhaux	64026
3062	64	Anos	64027
3063	64	Anoye	64028
3064	64	Aramits	64029
3065	64	Arancou	64031
3066	64	Araujuzon	64032
3067	64	Araux	64033
3068	64	Arbérats-Sillègue	64034
3069	64	Arbonne	64035
3070	64	Arbouet-Sussaute	64036
3071	64	Arbus	64037
3072	64	Arcangues	64038
3073	64	Aren	64039
3074	64	Arette	64040
3075	64	Aressy	64041
3076	64	Argagnon	64042
3077	64	Argelos	64043
3078	64	Arget	64044
3079	64	Arhansus	64045
3080	64	Armendarits	64046
3081	64	Arnéguy	64047
3082	64	Arnos	64048
3083	64	Aroue-Ithorots-Olhaïby	64049
3084	64	Arrast-Larrebieu	64050
3085	64	Arraute-Charritte	64051
3086	64	Arricau-Bordes	64052
3087	64	Arrien	64053
3088	64	Arros-de-Nay	64054
3089	64	Arrosès	64056
3090	64	Arthez-de-Béarn	64057
3091	64	Arthez-d'Asson	64058
3092	64	Artigueloutan	64059
3093	64	Artiguelouve	64060
3094	64	Artix	64061
3095	64	Arudy	64062
3096	64	Arzacq-Arraziguet	64063
3097	64	Asasp-Arros	64064
3098	64	Ascain	64065
3099	64	Ascarat	64066
3100	64	Assat	64067
3101	64	Asson	64068
3102	64	Aste-Béon	64069
3103	64	Astis	64070
3104	64	Athos-Aspis	64071
3105	64	Aubertin	64072
3106	64	Aubin	64073
3107	64	Aubous	64074
3108	64	Audaux	64075
3109	64	Auga	64077
3110	64	Auriac	64078
3111	64	Aurions-Idernes	64079
3112	64	Aussevielle	64080
3113	64	Aussurucq	64081
3114	64	Auterrive	64082
3115	64	Autevielle-Saint-Martin-Bideren	64083
3116	64	Aydie	64084
3117	64	Aydius	64085
3118	64	Ayherre	64086
3119	64	Baigts-de-Béarn	64087
3120	64	Balansun	64088
3121	64	Baleix	64089
3122	64	Baliracq-Maumusson	64090
3123	64	Baliros	64091
3124	64	Banca	64092
3125	64	Barcus	64093
3126	64	Bardos	64094
3127	64	Barinque	64095
3128	64	Barraute-Camu	64096
3129	64	Barzun	64097
3130	64	Bassillon-Vauzé	64098
3131	64	Bastanès	64099
3132	64	Bassussarry	64100
3133	64	Baudreix	64101
3134	64	Bayonne	64102
3135	64	Bédeille	64103
3136	64	Bedous	64104
3137	64	Béguios	64105
3138	64	Béhasque-Lapiste	64106
3139	64	Béhorléguy	64107
3140	64	Bellocq	64108
3141	64	Bénéjacq	64109
3142	64	Béost	64110
3143	64	Bentayou-Sérée	64111
3144	64	Bérenx	64112
3145	64	Bergouey-Viellenave	64113
3146	64	Bernadets	64114
3147	64	Berrogain-Laruns	64115
3148	64	Bescat	64116
3149	64	Bésingrand	64117
3150	64	Bétracq	64118
3151	64	Beuste	64119
3152	64	Beyrie-sur-Joyeuse	64120
3153	64	Beyrie-en-Béarn	64121
3154	64	Biarritz	64122
3155	64	Bidache	64123
3156	64	Bidarray	64124
3157	64	Bidart	64125
3158	64	Bidos	64126
3159	64	Bielle	64127
3160	64	Bilhères	64128
3161	64	Billère	64129
3162	64	Biriatou	64130
3163	64	Biron	64131
3164	64	Bizanos	64132
3165	64	Boeil-Bezing	64133
3166	64	Bonloc	64134
3167	64	Bonnut	64135
3168	64	Borce	64136
3169	64	Bordères	64137
3170	64	Bordes	64138
3171	64	Bosdarros	64139
3172	64	Boucau	64140
3173	64	Boueilh-Boueilho-Lasque	64141
3174	64	Bougarber	64142
3175	64	Bouillon	64143
3176	64	Boumourt	64144
3177	64	Bourdettes	64145
3178	64	Bournos	64146
3179	64	Briscous	64147
3180	64	Bruges-Capbis-Mifaget	64148
3181	64	Bugnein	64149
3182	64	Bunus	64150
3183	64	Burgaronne	64151
3184	64	Buros	64152
3185	64	Burosse-Mendousse	64153
3186	64	Bussunarits-Sarrasquette	64154
3187	64	Bustince-Iriberry	64155
3188	64	Buziet	64156
3189	64	Buzy	64157
3190	64	Cabidos	64158
3191	64	Cadillon	64159
3192	64	Cambo-les-Bains	64160
3193	64	Came	64161
3194	64	Camou-Cihigue	64162
3195	64	Cardesse	64165
3196	64	Caro	64166
3197	64	Carrère	64167
3198	64	Carresse-Cassaber	64168
3199	64	Castagnède	64170
3200	64	Casteide-Cami	64171
3201	64	Casteide-Candau	64172
3202	64	Casteide-Doat	64173
3203	64	Castéra-Loubix	64174
3204	64	Castet	64175
3205	64	Castetbon	64176
3206	64	Castétis	64177
3207	64	Castetnau-Camblong	64178
3208	64	Castetner	64179
3209	64	Castetpugon	64180
3210	64	Castillon (Canton d'Arthez-de-Béarn)	64181
3211	64	Castillon (Canton de Lembeye)	64182
3212	64	Caubios-Loos	64183
3213	64	Cescau	64184
3214	64	Cette-Eygun	64185
3215	64	Charre	64186
3216	64	Charritte-de-Bas	64187
3217	64	Chéraute	64188
3218	64	Ciboure	64189
3219	64	Claracq	64190
3220	64	Coarraze	64191
3221	64	Conchez-de-Béarn	64192
3222	64	Corbère-Abères	64193
3223	64	Coslédaà-Lube-Boast	64194
3224	64	Coublucq	64195
3225	64	Crouseilles	64196
3226	64	Cuqueron	64197
3227	64	Denguin	64198
3228	64	Diusse	64199
3229	64	Doazon	64200
3230	64	Dognen	64201
3231	64	Domezain-Berraute	64202
3232	64	Doumy	64203
3233	64	Eaux-Bonnes	64204
3234	64	Escos	64205
3235	64	Escot	64206
3236	64	Escou	64207
3237	64	Escoubès	64208
3238	64	Escout	64209
3239	64	Escurès	64210
3240	64	Eslourenties-Daban	64211
3241	64	Espéchède	64212
3242	64	Espelette	64213
3243	64	Espès-Undurein	64214
3244	64	Espiute	64215
3245	64	Espoey	64216
3246	64	Esquiule	64217
3247	64	Estérençuby	64218
3248	64	Estialescq	64219
3249	64	Estos	64220
3250	64	Etcharry	64221
3251	64	Etchebar	64222
3252	64	Etsaut	64223
3253	64	Eysus	64224
3254	64	Ance Féas	64225
3255	64	Fichous-Riumayou	64226
3256	64	Gabaston	64227
3257	64	Gabat	64228
3258	64	Gamarthe	64229
3259	64	Gan	64230
3260	64	Garindein	64231
3261	64	Garlède-Mondebat	64232
3262	64	Garlin	64233
3263	64	Garos	64234
3264	64	Garris	64235
3265	64	Gayon	64236
3266	64	Gelos	64237
3267	64	Ger	64238
3268	64	Gerderest	64239
3269	64	Gère-Bélesten	64240
3270	64	Géronce	64241
3271	64	Gestas	64242
3272	64	Géus-d'Arzacq	64243
3273	64	Geüs-d'Oloron	64244
3274	64	Goès	64245
3275	64	Gomer	64246
3276	64	Gotein-Libarrenx	64247
3277	64	Guéthary	64249
3278	64	Guiche	64250
3279	64	Guinarthe-Parenties	64251
3280	64	Gurmençon	64252
3281	64	Gurs	64253
3282	64	Hagetaubin	64254
3283	64	Halsou	64255
3284	64	Hasparren	64256
3285	64	Haut-de-Bosdarros	64257
3286	64	Haux	64258
3287	64	Hélette	64259
3288	64	Hendaye	64260
3289	64	Herrère	64261
3290	64	Higuères-Souye	64262
3291	64	L'Hôpital-d'Orion	64263
3292	64	L'Hôpital-Saint-Blaise	64264
3293	64	Hosta	64265
3294	64	Hours	64266
3295	64	Ibarrolle	64267
3296	64	Idaux-Mendy	64268
3297	64	Idron	64269
3298	64	Igon	64270
3299	64	Iholdy	64271
3300	64	Ilharre	64272
3301	64	Irissarry	64273
3302	64	Irouléguy	64274
3303	64	Ispoure	64275
3304	64	Issor	64276
3305	64	Isturits	64277
3306	64	Itxassou	64279
3307	64	Izeste	64280
3308	64	Jasses	64281
3309	64	Jatxou	64282
3310	64	Jaxu	64283
3311	64	Jurançon	64284
3312	64	Juxue	64285
3313	64	Laà-Mondrans	64286
3314	64	Laàs	64287
3315	64	Labastide-Cézéracq	64288
3316	64	La Bastide-Clairence	64289
3317	64	Labastide-Monréjeau	64290
3318	64	Labastide-Villefranche	64291
3319	64	Labatmale	64292
3320	64	Labatut-Figuières	64293
3321	64	Labets-Biscay	64294
3322	64	Labeyrie	64295
3323	64	Lacadée	64296
3324	64	Lacarre	64297
3325	64	Lacarry-Arhan-Charritte-de-Haut	64298
3326	64	Lacommande	64299
3327	64	Lacq	64300
3328	64	Lagor	64301
3329	64	Lagos	64302
3330	64	Laguinge-Restoue	64303
3331	64	Lahonce	64304
3332	64	Lahontan	64305
3333	64	Lahourcade	64306
3334	64	Lalongue	64307
3335	64	Lalonquette	64308
3336	64	Lamayou	64309
3337	64	Lanne-en-Barétous	64310
3338	64	Lannecaube	64311
3339	64	Lanneplaà	64312
3340	64	Lantabat	64313
3341	64	Larceveau-Arros-Cibits	64314
3342	64	Laroin	64315
3343	64	Larrau	64316
3344	64	Larressore	64317
3345	64	Larreule	64318
3346	64	Larribar-Sorhapuru	64319
3347	64	Laruns	64320
3348	64	Lasclaveries	64321
3349	64	Lasse	64322
3350	64	Lasserre	64323
3351	64	Lasseube	64324
3352	64	Lasseubetat	64325
3353	64	Lay-Lamidou	64326
3354	64	Lecumberry	64327
3355	64	Ledeuix	64328
3356	64	Lée	64329
3357	64	Lées-Athas	64330
3358	64	Lembeye	64331
3359	64	Lème	64332
3360	64	Léren	64334
3361	64	Lescar	64335
3362	64	Lescun	64336
3363	64	Lespielle	64337
3364	64	Lespourcy	64338
3365	64	Lestelle-Bétharram	64339
3366	64	Lichans-Sunhar	64340
3367	64	Lichos	64341
3368	64	Licq-Athérey	64342
3369	64	Limendous	64343
3370	64	Livron	64344
3371	64	Lohitzun-Oyhercq	64345
3372	64	Lombia	64346
3373	64	Lonçon	64347
3374	64	Lons	64348
3375	64	Loubieng	64349
3376	64	Louhossoa	64350
3377	64	Lourdios-Ichère	64351
3378	64	Lourenties	64352
3379	64	Louvie-Juzon	64353
3380	64	Louvie-Soubiron	64354
3381	64	Louvigny	64355
3382	64	Luc-Armau	64356
3383	64	Lucarré	64357
3384	64	Lucgarier	64358
3385	64	Lucq-de-Béarn	64359
3386	64	Lurbe-Saint-Christau	64360
3387	64	Lussagnet-Lusson	64361
3388	64	Luxe-Sumberraute	64362
3389	64	Lys	64363
3390	64	Macaye	64364
3391	64	Malaussanne	64365
3392	64	Mascaraàs-Haron	64366
3393	64	Maslacq	64367
3394	64	Masparraute	64368
3395	64	Maspie-Lalonquère-Juillacq	64369
3396	64	Maucor	64370
3397	64	Mauléon-Licharre	64371
3398	64	Maure	64372
3399	64	Mazères-Lezons	64373
3400	64	Mazerolles	64374
3401	64	Méharin	64375
3402	64	Meillon	64376
3403	64	Mendionde	64377
3404	64	Menditte	64378
3405	64	Mendive	64379
3406	64	Méracq	64380
3407	64	Méritein	64381
3408	64	Mesplède	64382
3409	64	Mialos	64383
3410	64	Miossens-Lanusse	64385
3411	64	Mirepeix	64386
3412	64	Momas	64387
3413	64	Momy	64388
3414	64	Monassut-Audiracq	64389
3415	64	Moncaup	64390
3416	64	Moncayolle-Larrory-Mendibieu	64391
3417	64	Moncla	64392
3418	64	Monein	64393
3419	64	Monpezat	64394
3420	64	Monségur	64395
3421	64	Mont	64396
3422	64	Montagut	64397
3423	64	Montaner	64398
3424	64	Montardon	64399
3425	64	Montaut	64400
3426	64	Mont-Disse	64401
3427	64	Montfort	64403
3428	64	Montory	64404
3429	64	Morlaàs	64405
3430	64	Morlanne	64406
3431	64	Mouguerre	64407
3432	64	Mouhous	64408
3433	64	Moumour	64409
3434	64	Mourenx	64410
3435	64	Musculdy	64411
3436	64	Nabas	64412
3437	64	Narcastet	64413
3438	64	Narp	64414
3439	64	Navailles-Angos	64415
3440	64	Navarrenx	64416
3441	64	Nay	64417
3442	64	Noguères	64418
3443	64	Nousty	64419
3444	64	Ogenne-Camptort	64420
3445	64	Ogeu-les-Bains	64421
3446	64	Oloron-Sainte-Marie	64422
3447	64	Oraàs	64423
3448	64	Ordiarp	64424
3449	64	Orègue	64425
3450	64	Orin	64426
3451	64	Orion	64427
3452	64	Orriule	64428
3453	64	Orsanco	64429
3454	64	Orthez	64430
3455	64	Os-Marsillon	64431
3456	64	Ossas-Suhare	64432
3457	64	Osse-en-Aspe	64433
3458	64	Ossenx	64434
3459	64	Osserain-Rivareyte	64435
3460	64	Ossès	64436
3461	64	Ostabat-Asme	64437
3462	64	Ouillon	64438
3463	64	Ousse	64439
3464	64	Ozenx-Montestrucq	64440
3465	64	Pagolle	64441
3466	64	Parbayse	64442
3467	64	Pardies	64443
3468	64	Pardies-Piétat	64444
3469	64	Pau	64445
3470	64	Peyrelongue-Abos	64446
3471	64	Piets-Plasence-Moustrou	64447
3472	64	Poey-de-Lescar	64448
3473	64	Poey-d'Oloron	64449
3474	64	Pomps	64450
3475	64	Ponson-Debat-Pouts	64451
3476	64	Ponson-Dessus	64452
3477	64	Pontacq	64453
3478	64	Pontiacq-Viellepinte	64454
3479	64	Portet	64455
3480	64	Pouliacq	64456
3481	64	Poursiugues-Boucoue	64457
3482	64	Préchacq-Josbaig	64458
3483	64	Préchacq-Navarrenx	64459
3484	64	Précilhon	64460
3485	64	Puyoô	64461
3486	64	Ramous	64462
3487	64	Rébénacq	64463
3488	64	Ribarrouy	64464
3489	64	Riupeyrous	64465
3490	64	Rivehaute	64466
3491	64	Rontignon	64467
3492	64	Roquiague	64468
3493	64	Saint-Abit	64469
3494	64	Saint-Armou	64470
3495	64	Saint-Boès	64471
3496	64	Saint-Castin	64472
3497	64	Sainte-Colome	64473
3498	64	Saint-Dos	64474
3499	64	Sainte-Engrâce	64475
3500	64	Saint-Esteben	64476
3501	64	Saint-Étienne-de-Baïgorry	64477
3502	64	Saint-Faust	64478
3503	64	Saint-Girons-en-Béarn	64479
3504	64	Saint-Gladie-Arrive-Munein	64480
3505	64	Saint-Goin	64481
3506	64	Saint-Jammes	64482
3507	64	Saint-Jean-de-Luz	64483
3508	64	Saint-Jean-le-Vieux	64484
3509	64	Saint-Jean-Pied-de-Port	64485
3510	64	Saint-Jean-Poudge	64486
3511	64	Saint-Just-Ibarre	64487
3512	64	Saint-Laurent-Bretagne	64488
3513	64	Saint-Martin-d'Arberoue	64489
3514	64	Saint-Martin-d'Arrossa	64490
3515	64	Saint-Médard	64491
3516	64	Saint-Michel	64492
3517	64	Saint-Palais	64493
3518	64	Saint-Pé-de-Léren	64494
3519	64	Saint-Pée-sur-Nivelle	64495
3520	64	Saint-Pierre-d'Irube	64496
3521	64	Saint-Vincent	64498
3522	64	Salies-de-Béarn	64499
3523	64	Salles-Mongiscard	64500
3524	64	Sallespisse	64501
3525	64	Sames	64502
3526	64	Samsons-Lion	64503
3527	64	Sare	64504
3528	64	Sarpourenx	64505
3529	64	Sarrance	64506
3530	64	Saubole	64507
3531	64	Saucède	64508
3532	64	Sauguis-Saint-Étienne	64509
3533	64	Sault-de-Navailles	64510
3534	64	Sauvagnon	64511
3535	64	Sauvelade	64512
3536	64	Sauveterre-de-Béarn	64513
3537	64	Séby	64514
3538	64	Sedze-Maubecq	64515
3539	64	Sedzère	64516
3540	64	Séméacq-Blachon	64517
3541	64	Sendets	64518
3542	64	Serres-Castet	64519
3543	64	Serres-Morlaàs	64520
3544	64	Serres-Sainte-Marie	64521
3545	64	Sévignacq-Meyracq	64522
3546	64	Sévignacq	64523
3547	64	Simacourbe	64524
3548	64	Siros	64525
3549	64	Soumoulou	64526
3550	64	Souraïde	64527
3551	64	Suhescun	64528
3552	64	Sus	64529
3553	64	Susmiou	64530
3554	64	Tabaille-Usquain	64531
3555	64	Tadousse-Ussau	64532
3556	64	Tardets-Sorholus	64533
3557	64	Taron-Sadirac-Viellenave	64534
3558	64	Tarsacq	64535
3559	64	Thèze	64536
3560	64	Trois-Villes	64537
3561	64	Uhart-Cize	64538
3562	64	Uhart-Mixe	64539
3563	64	Urcuit	64540
3564	64	Urdos	64542
3565	64	Urepel	64543
3566	64	Urost	64544
3567	64	Urrugne	64545
3568	64	Urt	64546
3569	64	Ustaritz	64547
3570	64	Uzan	64548
3571	64	Uzein	64549
3572	64	Uzos	64550
3573	64	Verdets	64551
3574	64	Vialer	64552
3575	64	Viellenave-d'Arthez	64554
3576	64	Viellenave-de-Navarrenx	64555
3577	64	Vielleségure	64556
3578	64	Vignes	64557
3579	64	Villefranque	64558
3580	64	Viodos-Abense-de-Bas	64559
3581	64	Viven	64560
3582	79	L'Absie	79001
3583	79	Adilly	79002
3584	79	Aiffres	79003
3585	79	Airvault	79005
3586	79	Allonne	79007
3587	79	Amailloux	79008
3588	79	Amuré	79009
3589	79	Arçais	79010
3590	79	Ardin	79012
3591	79	Argentonnay	79013
3592	79	Loretz-d'Argenton	79014
3593	79	Asnières-en-Poitou	79015
3594	79	Assais-les-Jumeaux	79016
3595	79	Aubigné	79018
3596	79	Aubigny	79019
3597	79	Augé	79020
3598	79	Availles-Thouarsais	79022
3599	79	Avon	79023
3600	79	Azay-le-Brûlé	79024
3601	79	Azay-sur-Thouet	79025
3602	79	Beaulieu-sous-Parthenay	79029
3603	79	Beaussais-Vitré	79030
3604	79	Beauvoir-sur-Niort	79031
3605	79	Béceleuf	79032
3606	79	Bessines	79034
3607	79	Boismé	79038
3608	79	La Boissière-en-Gâtine	79040
3609	79	Bougon	79042
3610	79	Le Bourdet	79046
3611	79	Boussais	79047
3612	79	La Crèche	79048
3613	79	Bressuire	79049
3614	79	Bretignolles	79050
3615	79	Brieuil-sur-Chizé	79055
3616	79	Brion-près-Thouet	79056
3617	79	Brioux-sur-Boutonne	79057
3618	79	Brûlain	79058
3619	79	Le Busseau	79059
3620	79	Celles-sur-Belle	79061
3621	79	Cerizay	79062
3622	79	Val en Vignes	79063
3623	79	Fontivillié	79064
3624	79	Champdeniers	79066
3625	79	Chanteloup	79069
3626	79	La Chapelle-Bâton	79070
3627	79	La Chapelle-Bertrand	79071
3628	79	La Chapelle-Pouilloux	79074
3629	79	La Chapelle-Saint-Laurent	79076
3630	79	Beugnon-Thireuil	79077
3631	79	Plaine-d'Argenson	79078
3632	79	Mauléon	79079
3633	79	Châtillon-sur-Thouet	79080
3634	79	Chauray	79081
3635	79	Chef-Boutonne	79083
3636	79	Chenay	79084
3637	79	Chérigné	79085
3638	79	Cherveux	79086
3639	79	Chey	79087
3640	79	Chiché	79088
3641	79	Le Chillou	79089
3642	79	Chizé	79090
3643	79	Cirières	79091
3644	79	Clavé	79092
3645	79	Clessé	79094
3646	79	Clussais-la-Pommeraie	79095
3647	79	Combrand	79096
3648	79	Coulon	79100
3649	79	Coulonges-sur-l'Autize	79101
3650	79	Coulonges-Thouarsais	79102
3651	79	Courlay	79103
3652	79	Cours	79104
3653	79	Les Châteliers	79105
3654	79	Couture-d'Argenson	79106
3655	79	Doux	79108
3656	79	Échiré	79109
3657	79	Ensigné	79111
3658	79	Épannes	79112
3659	79	Exireuil	79114
3660	79	Exoudun	79115
3661	79	Faye-l'Abbesse	79116
3662	79	Faye-sur-Ardin	79117
3663	79	Fénery	79118
3664	79	Fenioux	79119
3665	79	La Ferrière-en-Parthenay	79120
3666	79	Fomperron	79121
3667	79	Fontenille-Saint-Martin-d'Entraigues	79122
3668	79	La Forêt-sur-Sèvre	79123
3669	79	Les Forges	79124
3670	79	Fors	79125
3671	79	Les Fosses	79126
3672	79	La Foye-Monjault	79127
3673	79	François	79128
3674	79	Fressines	79129
3675	79	Frontenay-Rohan-Rohan	79130
3676	79	Geay	79131
3677	79	Genneton	79132
3678	79	Germond-Rouvre	79133
3679	79	Glénay	79134
3680	79	Gourgé	79135
3681	79	Alloinay	79136
3682	79	Granzay-Gript	79137
3683	79	Les Groseillers	79139
3684	79	Valdelaume	79140
3685	79	Irais	79141
3686	79	Juillé	79142
3687	79	Juscorps	79144
3688	79	Lageon	79145
3689	79	Largeasse	79147
3690	79	Lezay	79148
3691	79	Lhoumois	79149
3692	79	Limalonges	79150
3693	79	Lorigné	79152
3694	79	Loubigné	79153
3695	79	Loubillé	79154
3696	79	Louin	79156
3697	79	Louzy	79157
3698	79	Luché-sur-Brioux	79158
3699	79	Luché-Thouarsais	79159
3700	79	Lusseray	79160
3701	79	Luzay	79161
3702	79	Magné	79162
3703	79	Mairé-Levescault	79163
3704	79	Maisonnay	79164
3705	79	Maisontiers	79165
3706	79	Marigny	79166
3707	79	Marnes	79167
3708	79	Mauzé-sur-le-Mignon	79170
3709	79	Mazières-en-Gâtine	79172
3710	79	Melle	79174
3711	79	Melleran	79175
3712	79	Ménigoute	79176
3713	79	Messé	79177
3714	79	Moncoutant-sur-Sèvre	79179
3715	79	Montravers	79183
3716	79	La Mothe-Saint-Héray	79184
3717	79	Aigondigné	79185
3718	79	Nanteuil	79189
3719	79	Neuvy-Bouin	79190
3720	79	Niort	79191
3721	79	Nueil-les-Aubiers	79195
3722	79	Plaine-et-Vallées	79196
3723	79	Oroux	79197
3724	79	Paizay-le-Chapt	79198
3725	79	Pamplie	79200
3726	79	Pamproux	79201
3727	79	Parthenay	79202
3728	79	Pas-de-Jeu	79203
3729	79	Périgné	79204
3730	79	La Petite-Boissière	79207
3731	79	La Peyratte	79208
3732	79	Pierrefitte	79209
3733	79	Le Pin	79210
3734	79	Pompaire	79213
3735	79	Pougne-Hérisson	79215
3736	79	Prahecq	79216
3737	79	Prailles-La Couarde	79217
3738	79	Pressigny	79218
3739	79	Prin-Deyrançon	79220
3740	79	Puihardy	79223
3741	79	Reffannes	79225
3742	79	Le Retail	79226
3743	79	La Rochénard	79229
3744	79	Rom	79230
3745	79	Romans	79231
3746	79	Saint-Amand-sur-Sèvre	79235
3747	79	Saint-André-sur-Sèvre	79236
3748	79	Saint-Aubin-du-Plain	79238
3749	79	Saint-Aubin-le-Cloud	79239
3750	79	Saint-Christophe-sur-Roc	79241
3751	79	Voulmentin	79242
3752	79	Saint-Coutant	79243
3753	79	Saint-Cyr-la-Lande	79244
3754	79	Sainte-Eanne	79246
3755	79	Saint-Gelais	79249
3756	79	Sainte-Gemme	79250
3757	79	Marcillé	79251
3758	79	Saint-Généroux	79252
3759	79	Saint-Georges-de-Noisné	79253
3760	79	Saint-Georges-de-Rex	79254
3761	79	Saint-Germain-de-Longue-Chaume	79255
3762	79	Saint-Germier	79256
3763	79	Saint-Hilaire-la-Palud	79257
3764	79	Saint-Jacques-de-Thouars	79258
3765	79	Saint-Jean-de-Thouars	79259
3766	79	Saint-Laurs	79263
3767	79	Saint-Léger-de-Montbrun	79265
3768	79	Saint-Lin	79267
3769	79	Saint-Loup-Lamairé	79268
3770	79	Saint-Maixent-de-Beugné	79269
3771	79	Saint-Maixent-l'École	79270
3772	79	Saint-Marc-la-Lande	79271
3773	79	Saint-Martin-de-Bernegoue	79273
3774	79	Saint-Martin-de-Mâcon	79274
3775	79	Saint-Martin-de-Saint-Maixent	79276
3776	79	Saint-Martin-de-Sanzay	79277
3777	79	Saint-Martin-du-Fouilloux	79278
3778	79	Saint Maurice Étusson	79280
3779	79	Saint-Maxire	79281
3780	79	Sainte-Néomaye	79283
3781	79	Sainte-Ouenne	79284
3782	79	Saint-Pardoux-Soutiers	79285
3783	79	Saint-Paul-en-Gâtine	79286
3784	79	Saint-Pierre-des-Échaubrognes	79289
3785	79	Saint-Pompain	79290
3786	79	Saint-Rémy	79293
3787	79	Saint-Romans-des-Champs	79294
3788	79	Saint-Romans-lès-Melle	79295
3789	79	Sainte-Soline	79297
3790	79	Saint-Symphorien	79298
3791	79	Saint-Varent	79299
3792	79	Sainte-Verge	79300
3793	79	Saint-Vincent-la-Châtre	79301
3794	79	Saivres	79302
3795	79	Salles	79303
3796	79	Sansais	79304
3797	79	Saurais	79306
3798	79	Sauzé-entre-Bois	79307
3799	79	Sciecq	79308
3800	79	Scillé	79309
3801	79	Secondigné-sur-Belle	79310
3802	79	Secondigny	79311
3803	79	Séligné	79312
3804	79	Sepvret	79313
3805	79	Soudan	79316
3806	79	Souvigné	79319
3807	79	Surin	79320
3808	79	Le Tallud	79322
3809	79	Thénezay	79326
3810	79	Thouars	79329
3811	79	Tourtenay	79331
3812	79	Trayes	79332
3813	79	Val-du-Mignon	79334
3814	79	Vallans	79335
3815	79	Vançais	79336
3816	79	Le Vanneau-Irleau	79337
3817	79	Vanzay	79338
3818	79	Vasles	79339
3819	79	Vausseroux	79340
3820	79	Vautebis	79341
3821	79	Vernoux-en-Gâtine	79342
3822	79	Vernoux-sur-Boutonne	79343
3823	79	Verruyes	79345
3824	79	Le Vert	79346
3825	79	Viennay	79347
3826	79	Villefollet	79348
3827	79	Villemain	79349
3828	79	Villiers-en-Bois	79350
3829	79	Villiers-en-Plaine	79351
3830	79	Villiers-sur-Chizé	79352
3831	79	Vouhé	79354
3832	79	Vouillé	79355
3833	79	Xaintray	79357
3834	86	Adriers	86001
3835	86	Amberre	86002
3836	86	Anché	86003
3837	86	Angles-sur-l'Anglin	86004
3838	86	Angliers	86005
3839	86	Antigny	86006
3840	86	Antran	86007
3841	86	Arçay	86008
3842	86	Archigny	86009
3843	86	Aslonnes	86010
3844	86	Asnières-sur-Blour	86011
3845	86	Asnois	86012
3846	86	Aulnay	86013
3847	86	Availles-en-Châtellerault	86014
3848	86	Availles-Limouzine	86015
3849	86	Avanton	86016
3850	86	Ayron	86017
3851	86	Basses	86018
3852	86	Beaumont Saint-Cyr	86019
3853	86	Bellefonds	86020
3854	86	Berrie	86022
3855	86	Berthegon	86023
3856	86	Béruges	86024
3857	86	Béthines	86025
3858	86	Beuxes	86026
3859	86	Biard	86027
3860	86	Bignoux	86028
3861	86	Blanzay	86029
3862	86	Bonnes	86031
3863	86	Bonneuil-Matours	86032
3864	86	Bouresse	86034
3865	86	Bourg-Archambault	86035
3866	86	Bournand	86036
3867	86	Brigueil-le-Chantre	86037
3868	86	Brion	86038
3869	86	Brux	86039
3870	86	La Bussière	86040
3871	86	Buxerolles	86041
3872	86	Buxeuil	86042
3873	86	Ceaux-en-Loudun	86044
3874	86	Celle-Lévescault	86045
3875	86	Cenon-sur-Vienne	86046
3876	86	Cernay	86047
3877	86	Chabournay	86048
3878	86	Chalais	86049
3879	86	Chalandray	86050
3880	86	Champagné-le-Sec	86051
3881	86	Champagné-Saint-Hilaire	86052
3882	86	Champigny en Rochereau	86053
3883	86	Champniers	86054
3884	86	La Chapelle-Bâton	86055
3885	86	La Chapelle-Moulière	86058
3886	86	Chapelle-Viviers	86059
3887	86	Charroux	86061
3888	86	Chasseneuil-du-Poitou	86062
3889	86	Chatain	86063
3890	86	Château-Garnier	86064
3891	86	Château-Larcher	86065
3892	86	Châtellerault	86066
3893	86	Chaunay	86068
3894	86	La Chaussée	86069
3895	86	Chauvigny	86070
3896	86	Chenevelles	86072
3897	86	Cherves	86073
3898	86	Chiré-en-Montreuil	86074
3899	86	Chouppes	86075
3900	86	Cissé	86076
3901	86	Civaux	86077
3902	86	Civray	86078
3903	86	La Roche-Rigault	86079
3904	86	Cloué	86080
3905	86	Colombiers	86081
3906	86	Valence-en-Poitou	86082
3907	86	Coulombiers	86083
3908	86	Coulonges-les-Hérolles	86084
3909	86	Coussay	86085
3910	86	Coussay-les-Bois	86086
3911	86	Craon	86087
3912	86	Croutelle	86088
3913	86	Cuhon	86089
3914	86	Curçay-sur-Dive	86090
3915	86	Curzay-sur-Vonne	86091
3916	86	Dangé-Saint-Romain	86092
3917	86	Dercé	86093
3918	86	Dienné	86094
3919	86	Dissay	86095
3920	86	Doussay	86096
3921	86	La Ferrière-Airoux	86097
3922	86	Fleix	86098
3923	86	Fleuré	86099
3924	86	Fontaine-le-Comte	86100
3925	86	Frozes	86102
3926	86	Gençay	86103
3927	86	Genouillé	86104
3928	86	Gizay	86105
3929	86	Glénouze	86106
3930	86	Gouex	86107
3931	86	La Grimaudière	86108
3932	86	Guesnes	86109
3933	86	Haims	86110
3934	86	Ingrandes	86111
3935	86	L'Isle-Jourdain	86112
3936	86	Iteuil	86113
3937	86	Jardres	86114
3938	86	Jaunay-Marigny	86115
3939	86	Jazeneuil	86116
3940	86	Jouhet	86117
3941	86	Journet	86118
3942	86	Joussé	86119
3943	86	Lathus-Saint-Rémy	86120
3944	86	Latillé	86121
3945	86	Lauthiers	86122
3946	86	Boivre-la-Vallée	86123
3947	86	Lavoux	86124
3948	86	Leigné-les-Bois	86125
3949	86	Leignes-sur-Fontaine	86126
3950	86	Leigné-sur-Usseau	86127
3951	86	Lencloître	86128
3952	86	Lésigny	86129
3953	86	Leugny	86130
3954	86	Lhommaizé	86131
3955	86	Liglet	86132
3956	86	Ligugé	86133
3957	86	Linazay	86134
3958	86	Liniers	86135
3959	86	Lizant	86136
3960	86	Loudun	86137
3961	86	Luchapt	86138
3962	86	Lusignan	86139
3963	86	Lussac-les-Châteaux	86140
3964	86	Magné	86141
3965	86	Maillé	86142
3966	86	Mairé	86143
3967	86	Maisonneuve	86144
3968	86	Marçay	86145
3969	86	Marigny-Chemereau	86147
3970	86	Marnay	86148
3971	86	Martaizé	86149
3972	86	Massognes	86150
3973	86	Maulay	86151
3974	86	Mauprévoir	86152
3975	86	Mazerolles	86153
3976	86	Mazeuil	86154
3977	86	Messemé	86156
3978	86	Mignaloux-Beauvoir	86157
3979	86	Migné-Auxances	86158
3980	86	Millac	86159
3981	86	Mirebeau	86160
3982	86	Moncontour	86161
3983	86	Mondion	86162
3984	86	Montamisé	86163
3985	86	Monthoiron	86164
3986	86	Montmorillon	86165
3987	86	Monts-sur-Guesnes	86167
3988	86	Morton	86169
3989	86	Moulismes	86170
3990	86	Moussac	86171
3991	86	Mouterre-sur-Blourde	86172
3992	86	Mouterre-Silly	86173
3993	86	Naintré	86174
3994	86	Nalliers	86175
3995	86	Nérignac	86176
3996	86	Neuville-de-Poitou	86177
3997	86	Nieuil-l'Espoir	86178
3998	86	Nouaillé-Maupertuis	86180
3999	86	Nueil-sous-Faye	86181
4000	86	Orches	86182
4001	86	Les Ormes	86183
4002	86	Ouzilly	86184
4003	86	Oyré	86186
4004	86	Paizay-le-Sec	86187
4005	86	Payroux	86189
4006	86	Persac	86190
4007	86	Pindray	86191
4008	86	Plaisance	86192
4009	86	Pleumartin	86193
4010	86	Poitiers	86194
4011	86	Port-de-Piles	86195
4012	86	Pouançay	86196
4013	86	Pouant	86197
4014	86	Pouillé	86198
4015	86	Pressac	86200
4016	86	Prinçay	86201
4017	86	La Puye	86202
4018	86	Queaux	86203
4019	86	Quinçay	86204
4020	86	Ranton	86205
4021	86	Raslay	86206
4022	86	La Roche-Posay	86207
4023	86	Roches-Prémarie-Andillé	86209
4024	86	Roiffé	86210
4025	86	Romagne	86211
4026	86	Rouillé	86213
4027	86	Saint-Benoît	86214
4028	86	Saint-Christophe	86217
4029	86	Saint-Clair	86218
4030	86	Saint-Gaudent	86220
4031	86	Saint-Genest-d'Ambière	86221
4032	86	Saint-Georges-lès-Baillargeaux	86222
4033	86	Saint-Germain	86223
4034	86	Saint-Gervais-les-Trois-Clochers	86224
4035	86	Saint-Jean-de-Sauves	86225
4036	86	Saint-Julien-l'Ars	86226
4037	86	Saint-Laon	86227
4038	86	Saint-Laurent-de-Jourdes	86228
4039	86	Saint-Léger-de-Montbrillais	86229
4040	86	Saint-Léomer	86230
4041	86	Valdivienne	86233
4042	86	Saint-Martin-l'Ars	86234
4043	86	Saint-Maurice-la-Clouère	86235
4044	86	Saint-Pierre-de-Maillé	86236
4045	86	Saint-Pierre-d'Exideuil	86237
4046	86	Sainte-Radégonde	86239
4047	86	Saint-Rémy-sur-Creuse	86241
4048	86	Saint-Romain	86242
4049	86	Saint-Sauvant	86244
4050	86	Senillé-Saint-Sauveur	86245
4051	86	Saint-Savin	86246
4052	86	Val-de-Comporté	86247
4053	86	Saint-Secondin	86248
4054	86	Saires	86249
4055	86	Saix	86250
4056	86	Sammarçolles	86252
4057	86	Sanxay	86253
4058	86	Saulgé	86254
4059	86	Savigné	86255
4060	86	Savigny-Lévescault	86256
4061	86	Savigny-sous-Faye	86257
4062	86	Scorbé-Clairvaux	86258
4063	86	Sérigny	86260
4064	86	Sèvres-Anxaumont	86261
4065	86	Sillars	86262
4066	86	Smarves	86263
4067	86	Sommières-du-Clain	86264
4068	86	Sossais	86265
4069	86	Surin	86266
4070	86	Tercé	86268
4071	86	Ternay	86269
4072	86	Thollet	86270
4073	86	Thurageau	86271
4074	86	Thuré	86272
4075	86	La Trimouille	86273
4076	86	Les Trois-Moutiers	86274
4077	86	Usseau	86275
4078	86	Usson-du-Poitou	86276
4079	86	Vaux-sur-Vienne	86279
4080	86	Vellèches	86280
4081	86	Saint-Martin-la-Pallu	86281
4082	86	Vernon	86284
4083	86	Verrières	86285
4084	86	Verrue	86286
4085	86	Vézières	86287
4086	86	Vicq-sur-Gartempe	86288
4087	86	Le Vigeant	86289
4088	86	La Villedieu-du-Clain	86290
4089	86	Villemort	86291
4090	86	Villiers	86292
4091	86	Vivonne	86293
4092	86	Vouillé	86294
4093	86	Voulême	86295
4094	86	Voulon	86296
4095	86	Vouneuil-sous-Biard	86297
4096	86	Vouneuil-sur-Vienne	86298
4097	86	Vouzailles	86299
4098	86	Yversay	86300
4099	87	Aixe-sur-Vienne	87001
4100	87	Ambazac	87002
4101	87	Arnac-la-Poste	87003
4102	87	Augne	87004
4103	87	Aureil	87005
4104	87	Azat-le-Ris	87006
4105	87	Balledent	87007
4106	87	La Bazeuge	87008
4107	87	Beaumont-du-Lac	87009
4108	87	Bellac	87011
4109	87	Berneuil	87012
4110	87	Bersac-sur-Rivalier	87013
4111	87	Bessines-sur-Gartempe	87014
4112	87	Beynac	87015
4113	87	Les Billanges	87016
4114	87	Blanzac	87017
4115	87	Blond	87018
4116	87	Boisseuil	87019
4117	87	Bonnac-la-Côte	87020
4118	87	Bosmie-l'Aiguille	87021
4119	87	Breuilaufa	87022
4120	87	Le Buis	87023
4121	87	Bujaleuf	87024
4122	87	Burgnac	87025
4123	87	Bussière-Galant	87027
4124	87	Val-d'Oire-et-Gartempe	87028
4125	87	Les Cars	87029
4126	87	Chaillac-sur-Vienne	87030
4127	87	Le Chalard	87031
4128	87	Châlus	87032
4129	87	Chamboret	87033
4130	87	Champagnac-la-Rivière	87034
4131	87	Champnétery	87035
4132	87	Champsac	87036
4133	87	La Chapelle-Montbrandeix	87037
4134	87	Chaptelat	87038
4135	87	Château-Chervix	87039
4136	87	Châteauneuf-la-Forêt	87040
4137	87	Châteauponsac	87041
4138	87	Le Châtenet-en-Dognon	87042
4139	87	Cheissoux	87043
4140	87	Chéronnac	87044
4141	87	Cieux	87045
4142	87	Cognac-la-Forêt	87046
4143	87	Compreignac	87047
4144	87	Condat-sur-Vienne	87048
4145	87	Coussac-Bonneval	87049
4146	87	Couzeix	87050
4147	87	La Croisille-sur-Briance	87051
4148	87	La Croix-sur-Gartempe	87052
4149	87	Cromac	87053
4150	87	Cussac	87054
4151	87	Dinsac	87056
4152	87	Dompierre-les-Églises	87057
4153	87	Domps	87058
4154	87	Le Dorat	87059
4155	87	Dournazac	87060
4156	87	Droux	87061
4157	87	Eybouleuf	87062
4158	87	Eyjeaux	87063
4159	87	Eymoutiers	87064
4160	87	Feytiat	87065
4161	87	Flavignac	87066
4162	87	Folles	87067
4163	87	Fromental	87068
4164	87	Gajoubert	87069
4165	87	La Geneytouse	87070
4166	87	Glandon	87071
4167	87	Glanges	87072
4168	87	Gorre	87073
4169	87	Les Grands-Chézeaux	87074
4170	87	Isle	87075
4171	87	Jabreilles-les-Bordes	87076
4172	87	Janailhac	87077
4173	87	Javerdat	87078
4174	87	La Jonchère-Saint-Maurice	87079
4175	87	Jouac	87080
4176	87	Jourgnac	87081
4177	87	Ladignac-le-Long	87082
4178	87	Laurière	87083
4179	87	Lavignac	87084
4180	87	Limoges	87085
4181	87	Linards	87086
4182	87	Lussac-les-Églises	87087
4183	87	Magnac-Bourg	87088
4184	87	Magnac-Laval	87089
4185	87	Mailhac-sur-Benaize	87090
4186	87	Maisonnais-sur-Tardoire	87091
4187	87	Marval	87092
4188	87	Masléon	87093
4189	87	Meilhac	87094
4190	87	Meuzac	87095
4191	87	La Meyze	87096
4192	87	Val d'Issoire	87097
4193	87	Moissannes	87099
4194	87	Montrol-Sénard	87100
4195	87	Mortemart	87101
4196	87	Nantiat	87103
4197	87	Nedde	87104
4198	87	Neuvic-Entier	87105
4199	87	Nexon	87106
4200	87	Nieul	87107
4201	87	Nouic	87108
4202	87	Oradour-Saint-Genest	87109
4203	87	Oradour-sur-Glane	87110
4204	87	Oradour-sur-Vayres	87111
4205	87	Pageas	87112
4206	87	Le Palais-sur-Vienne	87113
4207	87	Panazol	87114
4208	87	Pensol	87115
4209	87	Peyrat-de-Bellac	87116
4210	87	Peyrat-le-Château	87117
4211	87	Peyrilhac	87118
4212	87	Pierre-Buffière	87119
4213	87	La Porcherie	87120
4214	87	Rancon	87121
4215	87	Razès	87122
4216	87	Rempnat	87123
4217	87	Rilhac-Lastours	87124
4218	87	Rilhac-Rancon	87125
4219	87	Rochechouart	87126
4220	87	La Roche-l'Abeille	87127
4221	87	Saint-Pardoux-le-Lac	87128
4222	87	Royères	87129
4223	87	Roziers-Saint-Georges	87130
4224	87	Saillat-sur-Vienne	87131
4225	87	Saint-Amand-le-Petit	87132
4226	87	Saint-Amand-Magnazeix	87133
4227	87	Sainte-Anne-Saint-Priest	87134
4228	87	Saint-Auvent	87135
4229	87	Saint-Bazile	87137
4230	87	Saint-Bonnet-Briance	87138
4231	87	Saint-Bonnet-de-Bellac	87139
4232	87	Saint-Brice-sur-Vienne	87140
4233	87	Saint-Cyr	87141
4234	87	Saint-Denis-des-Murs	87142
4235	87	Saint-Gence	87143
4236	87	Saint-Genest-sur-Roselle	87144
4237	87	Saint-Georges-les-Landes	87145
4238	87	Saint-Germain-les-Belles	87146
4239	87	Saint-Gilles-les-Forêts	87147
4240	87	Saint-Hilaire-Bonneval	87148
4241	87	Saint-Hilaire-la-Treille	87149
4242	87	Saint-Hilaire-les-Places	87150
4243	87	Saint-Jean-Ligoure	87151
4244	87	Saint-Jouvent	87152
4245	87	Saint-Julien-le-Petit	87153
4246	87	Saint-Junien	87154
4247	87	Saint-Junien-les-Combes	87155
4248	87	Saint-Just-le-Martel	87156
4249	87	Saint-Laurent-les-Églises	87157
4250	87	Saint-Laurent-sur-Gorre	87158
4251	87	Saint-Léger-la-Montagne	87159
4252	87	Saint-Léger-Magnazeix	87160
4253	87	Saint-Léonard-de-Noblat	87161
4254	87	Sainte-Marie-de-Vaux	87162
4255	87	Saint-Martial-sur-Isop	87163
4256	87	Saint-Martin-de-Jussac	87164
4257	87	Saint-Martin-le-Mault	87165
4258	87	Saint-Martin-le-Vieux	87166
4259	87	Saint-Martin-Terressus	87167
4260	87	Saint-Mathieu	87168
4261	87	Saint-Maurice-les-Brousses	87169
4262	87	Saint-Méard	87170
4263	87	Saint-Ouen-sur-Gartempe	87172
4264	87	Saint-Paul	87174
4265	87	Saint-Priest-Ligoure	87176
4266	87	Saint-Priest-sous-Aixe	87177
4267	87	Saint-Priest-Taurion	87178
4268	87	Saint-Sornin-la-Marche	87179
4269	87	Saint-Sornin-Leulac	87180
4270	87	Saint-Sulpice-Laurière	87181
4271	87	Saint-Sulpice-les-Feuilles	87182
4272	87	Saint-Sylvestre	87183
4273	87	Saint-Victurnien	87185
4274	87	Saint-Vitte-sur-Briance	87186
4275	87	Saint-Yrieix-la-Perche	87187
4276	87	Saint-Yrieix-sous-Aixe	87188
4277	87	Les Salles-Lavauguyon	87189
4278	87	Sauviat-sur-Vige	87190
4279	87	Séreilhac	87191
4280	87	Solignac	87192
4281	87	Surdoux	87193
4282	87	Sussac	87194
4283	87	Tersannes	87195
4284	87	Thouron	87197
4285	87	Vaulry	87198
4286	87	Vayres	87199
4287	87	Verneuil-Moustiers	87200
4288	87	Verneuil-sur-Vienne	87201
4289	87	Veyrac	87202
4290	87	Vicq-sur-Breuilh	87203
4291	87	Videix	87204
4292	87	Le Vigen	87205
4293	87	Villefavard	87206
\.

COPY public.valstat (idc, idl, annedebut, valeur ) FROM stdin;
1	1	2022	513
1	1	1990	523
1	3	1990	74
1	3	2022	73.9839408076982
2	1	2022	532
2	1	1990	448
2	3	1990	17
2	3	2022	18
3	1	2022	875
3	1	1990	732
3	3	1990	30
3	3	2022	44.1237497481263
4	1	2022	1600
4	1	1990	1726
4	3	1990	91
4	3	2022	125
5	1	2022	481
5	1	1990	599
5	3	1990	50
5	3	2022	59.7998992443327
6	1	2022	312
6	1	1990	338
6	3	1990	22
6	3	2022	15.2345679012346
7	1	2022	377
7	1	1990	430
7	3	1990	31
7	3	2022	31.3447324414713
8	1	2022	566
8	1	1990	446
8	3	1990	31
8	3	2022	32.7697594501719
9	1	2022	496
9	1	1990	473
9	3	1990	20
9	3	2022	19.5749559082892
10	1	2022	296
10	1	1990	387
10	3	1990	17
10	3	2022	21.9607843137255
11	1	2022	143
11	1	1990	105
11	3	1990	2
11	3	2022	8
12	1	2022	41423
12	1	1990	42876
12	3	1990	2383
12	3	2022	2418.94156095649
13	1	2022	816
13	1	1990	936
13	3	1990	23
13	3	2022	46
14	1	2022	689
14	1	1990	750
14	3	1990	10
14	3	2022	18.5964912280702
15	1	2022	1278
15	1	1990	1015
15	3	1990	21
15	3	2022	47.5756865983633
16	1	2022	318
16	1	1990	388
16	3	1990	36
16	3	2022	22.1712062256809
17	1	2022	662
17	1	1990	715
17	3	1990	40
17	3	2022	50.7945804195805
18	1	2022	549
18	1	1990	387
18	3	1990	31
18	3	2022	20.636101284677
19	1	2022	1241
19	1	1990	1191
19	3	1990	74
19	3	2022	96.6146720805938
20	1	2022	1401
20	1	1990	1185
20	3	1990	16
20	3	2022	37.8618012422361
21	1	2022	137
21	1	1990	157
21	3	1990	11
21	3	2022	9.28271728271728
22	1	2022	4738
22	1	1990	4774
22	3	1990	214
22	3	2022	354.973445143255
23	1	2022	217
23	1	1990	207
23	3	1990	12
23	3	2022	22
24	1	2022	1092
24	1	1990	951
24	3	1990	15
24	3	2022	39.144554463291
25	1	2022	410
25	1	1990	258
25	3	1990	9
25	3	2022	18.0746887966805
26	1	2022	522
26	1	1990	464
26	3	1990	43
26	3	2022	22.4244450636204
27	1	2022	147
27	1	1990	159
27	3	1990	20
27	3	2022	19
28	1	2022	222
28	1	1990	300
28	3	1990	29
28	3	2022	26.5441383161016
29	1	2022	292
29	1	1990	217
29	3	1990	9
29	3	2022	6
30	1	2022	136
30	1	1990	156
30	3	1990	9
30	3	2022	10.2051442257628
31	1	2022	307
31	1	1990	425
31	3	1990	32
31	3	2022	37.988665543702
32	1	2022	463
32	1	1990	433
32	3	1990	10
32	3	2022	14.3960863697705
33	1	2022	321
33	1	1990	326
33	3	1990	7
33	3	2022	23
34	1	2022	119
34	1	1990	139
34	3	1990	18
34	3	2022	13.0967741935484
35	1	2022	113
35	1	1990	132
35	3	1990	13
35	3	2022	16.9393939393939
36	1	2022	208
36	1	1990	244
36	3	1990	15
36	3	2022	24.4210526315789
37	1	2022	368
37	1	1990	234
37	3	1990	13
37	3	2022	10
38	1	2022	1000
38	1	1990	1087
38	3	1990	52
38	3	2022	127.32987168634
39	1	2022	273
39	1	1990	223
39	3	1990	19
39	3	2022	13
40	1	2022	128
40	1	1990	148
40	3	1990	25
40	3	2022	12.9907827566647
41	1	2022	360
41	1	1990	341
41	3	1990	15
41	3	2022	3.01977240398294
42	1	2022	248
42	1	1990	245
42	3	1990	13
42	3	2022	18.3396226415094
43	1	2022	227
43	1	1990	283
43	3	1990	21
43	3	2022	16.9065934065934
44	1	2022	118
44	1	1990	167
44	3	1990	14
44	3	2022	17.003470095938
45	1	2022	177
45	1	1990	197
45	3	1990	19
45	3	2022	23.7538461538462
46	1	2022	845
46	1	1990	747
46	3	1990	24
46	3	2022	26.1449362244417
47	1	2022	885
47	1	1990	722
47	3	1990	45
47	3	2022	30.2958579881656
48	1	2022	330
48	1	1990	398
48	3	1990	22
48	3	2022	42.6395939086295
49	1	2022	1393
49	1	1990	1478
49	3	1990	33
49	3	2022	52.6921435707149
50	1	2022	163
50	1	1990	197
50	3	1990	27
50	3	2022	24
51	1	2022	440
51	1	1990	495
51	3	1990	30
51	3	2022	14.4366197183099
52	1	2022	4157
52	1	1990	2728
52	3	1990	48
52	3	2022	101.648646650163
53	1	2022	111
53	1	1990	145
53	3	1990	8
53	3	2022	15
54	1	2022	158
54	1	1990	160
54	3	1990	24
54	3	2022	7
55	1	2022	1101
55	1	1990	995
55	3	1990	74
55	3	2022	106
56	1	2022	607
56	1	1990	613
56	3	1990	77
56	3	2022	93.5777012995337
57	1	2022	453
57	1	1990	593
57	3	1990	41
57	3	2022	76.356807511737
58	1	2022	453
58	1	1990	332
58	3	1990	8
58	3	2022	23.9669916679215
59	1	2022	579
59	1	1990	563
59	3	1990	29
59	3	2022	74.0613297009833
60	1	2022	388
60	1	1990	346
60	3	1990	20
60	3	2022	23.7455300291545
61	1	2022	1564
61	1	1990	2107
61	3	1990	140
61	3	2022	234.598958418122
62	1	2022	614
62	1	1990	494
62	3	1990	11
62	3	2022	29.6128531653659
63	1	2022	509
63	1	1990	474
63	3	1990	30
63	3	2022	17.2357120790856
64	1	2022	1799
64	1	1990	2172
64	3	1990	131
64	3	2022	232.670139216651
65	1	2022	340
65	1	1990	327
65	3	1990	21
65	3	2022	17.1910832025119
66	1	2022	235
66	1	1990	193
66	3	1990	7
66	3	2022	14
67	1	2022	877
67	1	1990	1012
67	3	1990	46
67	3	2022	48.3091779448102
68	1	2022	525
68	1	1990	449
68	3	1990	16
68	3	2022	13.5450773293097
69	1	2022	5237
69	1	1990	4358
69	3	1990	98
69	3	2022	172.034070692803
70	1	2022	372
70	1	1990	319
70	3	1990	32
70	3	2022	27
71	1	2022	191
71	1	1990	148
71	3	1990	3
71	3	2022	16.6274509803922
72	1	2022	661
72	1	1990	632
72	3	1990	32
72	3	2022	29.0768772702609
73	1	2022	340
73	1	1990	411
73	3	1990	15
73	3	2022	25.4366812227075
74	1	2022	346
74	1	1990	328
74	3	1990	21
74	3	2022	24
75	1	2022	3103
75	1	1990	2791
75	3	1990	91
75	3	2022	163.02018548827
76	1	2022	843
76	1	1990	964
76	3	1990	70
76	3	2022	56.197879858657
77	1	2022	148
77	1	1990	172
77	3	1990	28
77	3	2022	18
78	1	2022	1103
78	1	1990	1105
78	3	1990	33
78	3	2022	50.6756571061877
79	1	2022	3793
79	1	1990	3769
79	3	1990	67
79	3	2022	151.311889727375
80	1	2022	3562
80	1	1990	3522
80	3	1990	122
80	3	2022	178
81	1	2022	166
81	1	1990	143
81	3	1990	11
81	3	2022	22.5142834288228
82	1	2022	1550
82	1	1990	1428
82	3	1990	58
82	3	2022	60
83	1	2022	125
83	1	1990	143
83	3	1990	10
83	3	2022	17
84	1	2022	416
84	1	1990	520
84	3	1990	26
84	3	2022	29.0646919098708
85	1	2022	3455
85	1	1990	3734
85	3	1990	116
85	3	2022	174.157288453787
86	1	2022	137
86	1	1990	149
86	3	1990	11
86	3	2022	9
87	1	2022	225
87	1	1990	165
87	3	1990	26
87	3	2022	24.9375
88	1	2022	779
88	1	1990	767
88	3	1990	45
88	3	2022	50.5038277957484
89	1	2022	1058
89	1	1990	816
89	3	1990	21
89	3	2022	20.213857064921
90	1	2022	18466
90	1	1990	19528
90	3	1990	1120
90	3	2022	1171.88283893025
91	1	2022	126
91	1	1990	127
91	3	1990	22
91	3	2022	8.82567835383001
92	1	2022	460
92	1	1990	429
92	3	1990	11
92	3	2022	35.5298063775653
93	1	2022	609
93	1	1990	553
93	3	1990	39
93	3	2022	35
94	1	2022	2726
94	1	1990	3013
94	3	1990	185
94	3	2022	409.419280348266
95	1	2022	557
95	1	1990	389
95	3	1990	16
95	3	2022	35.8774172823641
96	1	2022	121
96	1	1990	135
96	3	1990	4
96	3	2022	4.07407407407407
97	1	2022	729
97	1	1990	473
97	3	1990	13
97	3	2022	22
98	1	2022	801
98	1	1990	749
98	3	1990	48
98	3	2022	38.0218576968918
99	1	2022	170
99	1	1990	174
99	3	1990	11
99	3	2022	6.80534759358291
100	1	2022	58
100	1	1990	64
100	3	1990	8
100	3	2022	3
101	1	2022	7759
101	1	1990	6295
101	3	1990	116
101	3	2022	363.558380597433
102	1	2022	173
102	1	1990	177
102	3	1990	13
102	3	2022	11.347160218254
103	1	2022	403
103	1	1990	506
103	3	1990	29
103	3	2022	34.9284856507878
104	1	2022	116
104	1	1990	112
104	3	1990	7
104	3	2022	16.225352112676
105	1	2022	134
105	1	1990	156
105	3	1990	13
105	3	2022	9.75
106	1	2022	1373
106	1	1990	1230
106	3	1990	47
106	3	2022	69.7735307515246
107	1	2022	1509
107	1	1990	1260
107	3	1990	16
107	3	2022	45.6040215186525
108	1	2022	432
108	1	1990	367
108	3	1990	17
108	3	2022	18.3930131004367
109	1	2022	139
109	1	1990	174
109	3	1990	8
109	3	2022	20.3809523809524
110	1	2022	481
110	1	1990	426
110	3	1990	27
110	3	2022	14.1728395061728
111	1	2022	542
111	1	1990	628
111	3	1990	52
111	3	2022	69.9922843581437
112	1	2022	272
112	1	1990	306
112	3	1990	22
112	3	2022	16.1632653061224
113	1	2022	96
113	1	1990	113
113	3	1990	13
113	3	2022	10.7874396135266
114	1	2022	191
114	1	1990	242
114	3	1990	25
114	3	2022	24.6640151515151
115	1	2022	178
115	1	1990	193
115	3	1990	7
115	3	2022	8.05194805194808
116	1	2022	509
116	1	1990	503
116	3	1990	43
116	3	2022	42.0830770482666
117	1	2022	987
117	1	1990	949
117	3	1990	68
117	3	2022	66.7819610214198
118	1	2022	200
118	1	1990	175
118	3	1990	9
118	3	2022	14.2557236135219
119	1	2022	1028
119	1	1990	1039
119	3	1990	63
119	3	2022	109.787678207065
120	1	2022	325
120	1	1990	279
120	3	1990	25
120	3	2022	20.7170315895036
121	1	2022	595
121	1	1990	539
121	3	1990	7
121	3	2022	31.1159223209918
122	1	2022	284
122	1	1990	330
122	3	1990	16
122	3	2022	22
123	1	2022	3856
123	1	1990	2704
123	3	1990	45
123	3	2022	81.2439678284179
124	1	2022	220
124	1	1990	244
124	3	1990	8
124	3	2022	4.71428571428571
125	1	2022	343
125	1	1990	335
125	3	1990	24
125	3	2022	21.1594463614669
126	1	2022	209
126	1	1990	212
126	3	1990	13
126	3	2022	34.1578947368422
127	1	2022	717
127	1	1990	670
127	3	1990	10
127	3	2022	23.1964986043882
128	1	2022	431
128	1	1990	426
128	3	1990	15
128	3	2022	41.3134993201424
129	1	2022	656
129	1	1990	543
129	3	1990	3
129	3	2022	29.827413552166
130	1	2022	2111
130	1	1990	1484
130	3	1990	21
130	3	2022	76.1641893862887
131	1	2022	973
131	1	1990	929
131	3	1990	62
131	3	2022	83
132	1	2022	1614
132	1	1990	1701
132	3	1990	32
132	3	2022	50.5880575323434
133	1	2022	929
133	1	1990	851
133	3	1990	13
133	3	2022	43.5893309820346
134	1	2022	727
134	1	1990	751
134	3	1990	17
134	3	2022	16.065644844559
135	1	2022	1184
135	1	1990	1061
135	3	1990	35
135	3	2022	78.250401284109
136	1	2022	5884
136	1	1990	6019
136	3	1990	194
136	3	2022	336
137	1	2022	93
137	1	1990	142
137	3	1990	3
137	3	2022	11
138	1	2022	154
138	1	1990	170
138	3	1990	24
138	3	2022	4.10000000000003
139	1	2022	303
139	1	1990	285
139	3	1990	6
139	3	2022	19.4954517889632
140	1	2022	495
140	1	1990	508
140	3	1990	14
140	3	2022	25.4844961240308
141	1	2022	165
141	1	1990	168
141	3	1990	16
141	3	2022	17.1666666666667
142	1	2022	184
142	1	1990	210
142	3	1990	16
142	3	2022	24
143	1	2022	1150
143	1	1990	966
143	3	1990	15
143	3	2022	36.3009494086522
144	1	2022	238
144	1	1990	295
144	3	1990	21
144	3	2022	17.2836895034569
145	1	2022	395
145	1	1990	373
145	3	1990	21
145	3	2022	22
146	1	2022	5691
146	1	1990	4795
146	3	1990	91
146	3	2022	227
147	1	2022	4478
147	1	1990	4786
147	3	1990	247
147	3	2022	331.853190563395
148	1	2022	832
148	1	1990	606
148	3	1990	28
148	3	2022	24.2792684168855
149	1	2022	581
149	1	1990	666
149	3	1990	23
149	3	2022	20
150	1	2022	392
150	1	1990	466
150	3	1990	15
150	3	2022	24.2676579925651
151	1	2022	655
151	1	1990	684
151	3	1990	53
151	3	2022	35.4768392370573
152	1	2022	176
152	1	1990	198
152	3	1990	9
152	3	2022	14.0801188388857
153	1	2022	540
153	1	1990	381
153	3	1990	8
153	3	2022	18.9481324019731
154	1	2022	1358
154	1	1990	1250
154	3	1990	62
154	3	2022	76.4088778555166
155	1	2022	306
155	1	1990	275
155	3	1990	19
155	3	2022	15.1152618135376
156	1	2022	129
156	1	1990	128
156	3	1990	15
156	3	2022	8.421875
157	1	2022	187
157	1	1990	169
157	3	1990	4
157	3	2022	5.00133022946457
158	1	2022	249
158	1	1990	207
158	3	1990	15
158	3	2022	12.2779374471682
159	1	2022	534
159	1	1990	586
159	3	1990	37
159	3	2022	44.2700070904222
160	1	2022	440
160	1	1990	560
160	3	1990	91
160	3	2022	59.327777777778
161	1	2022	169
161	1	1990	228
161	3	1990	44
161	3	2022	48
162	1	2022	95
162	1	1990	86
162	3	1990	8
162	3	2022	3.29411764705882
163	1	2022	146
163	1	1990	194
163	3	1990	19
163	3	2022	11.3307445376411
164	1	2022	704
164	1	1990	818
164	3	1990	76
164	3	2022	72.9796067705443
165	1	2022	2105
165	1	1990	2193
165	3	1990	30
165	3	2022	61.5231100091144
166	1	2022	339
166	1	1990	311
166	3	1990	23
166	3	2022	35.1824561403509
167	1	2022	246
167	1	1990	228
167	3	1990	13
167	3	2022	26.695171026157
168	1	2022	191
168	1	1990	251
168	3	1990	23
168	3	2022	18.7414965986395
169	1	2022	188
169	1	1990	160
169	3	1990	15
169	3	2022	7.25688073394497
170	1	2022	3790
170	1	1990	4450
170	3	1990	243
170	3	2022	387
171	1	2022	964
171	1	1990	953
171	3	1990	34
171	3	2022	27.4853933420721
172	1	2022	111
172	1	1990	160
172	3	1990	6
172	3	2022	13.6758517942739
173	1	2022	293
173	1	1990	295
173	3	1990	16
173	3	2022	20.775621541579
174	1	2022	732
174	1	1990	733
174	3	1990	44
174	3	2022	62.6116608149803
175	1	2022	117
175	1	1990	125
175	3	1990	4
175	3	2022	12.4709677419355
176	1	2022	743
176	1	1990	607
176	3	1990	22
176	3	2022	48.3057324840763
177	1	2022	3252
177	1	1990	2843
177	3	1990	64
177	3	2022	112.216725455028
178	1	2022	476
178	1	1990	375
178	3	1990	13
178	3	2022	15.7551857533516
179	1	2022	123
179	1	1990	121
179	3	1990	14
179	3	2022	11.9189610389611
180	1	2022	1274
180	1	1990	1322
180	3	1990	111
180	3	2022	67.3656207366984
181	1	2022	548
181	1	1990	584
181	3	1990	82
181	3	2022	94.7945205479453
182	1	2022	2092
182	1	1990	1901
182	3	1990	134
182	3	2022	174
183	1	2022	509
183	1	1990	534
183	3	1990	57
183	3	2022	54.0502793296089
184	1	2022	393
184	1	1990	360
184	3	1990	19
184	3	2022	11.3280437756498
185	1	2022	823
185	1	1990	626
185	3	1990	27
185	3	2022	10
186	1	2022	766
186	1	1990	708
186	3	1990	15
186	3	2022	18.4036009002251
187	1	2022	547
187	1	1990	529
187	3	1990	22
187	3	2022	46.9741080530074
188	1	2022	368
188	1	1990	451
188	3	1990	49
188	3	2022	57.4248135060856
189	1	2022	305
189	1	1990	309
189	3	1990	19
189	3	2022	42.5366961317006
190	1	2022	151
190	1	1990	177
190	3	1990	16
190	3	2022	36.225937183384
191	1	2022	812
191	1	1990	751
191	3	1990	34
191	3	2022	41
192	1	2022	1082
192	1	1990	1025
192	3	1990	18
192	3	2022	27.9027795575895
193	1	2022	408
193	1	1990	326
193	3	1990	34
193	3	2022	15.234375
194	1	2022	714
194	1	1990	533
194	3	1990	11
194	3	2022	17.3152124086704
195	1	2022	235
195	1	1990	225
195	3	1990	14
195	3	2022	10.8880174291939
196	1	2022	329
196	1	1990	440
196	3	1990	14
196	3	2022	50.6831264534443
197	1	2022	1995
197	1	1990	2422
197	3	1990	96
197	3	2022	226.510158013546
198	1	2022	725
198	1	1990	649
198	3	1990	38
198	3	2022	58.8179654809125
199	1	2022	659
199	1	1990	708
199	3	1990	27
199	3	2022	75
200	1	2022	134
200	1	1990	162
200	3	1990	9
200	3	2022	13.0948905109489
201	1	2022	251
201	1	1990	272
201	3	1990	12
201	3	2022	18.2105263157895
202	1	2022	2419
202	1	1990	2566
202	3	1990	131
202	3	2022	224
203	1	2022	332
203	1	1990	265
203	3	1990	46
203	3	2022	35.2641509433962
204	1	2022	2115
204	1	1990	1800
204	3	1990	24
204	3	2022	51.9391916681953
205	1	2022	967
205	1	1990	817
205	3	1990	27
205	3	2022	39.774405190407
206	1	2022	664
206	1	1990	543
206	3	1990	23
206	3	2022	39
207	1	2022	2358
207	1	1990	2260
207	3	1990	28
207	3	2022	97.5788576300083
208	1	2022	223
208	1	1990	194
208	3	1990	10
208	3	2022	22.2993197278911
209	1	2022	140
209	1	1990	155
209	3	1990	18
209	3	2022	29
210	1	2022	99
210	1	1990	90
210	3	1990	0
210	3	2022	6.19962894248608
211	1	2022	210
211	1	1990	201
211	3	1990	22
211	3	2022	14.4801641586867
212	1	2022	1357
212	1	1990	1496
212	3	1990	79
212	3	2022	91.6608294930876
213	1	2022	1036
213	1	1990	1159
213	3	1990	26
213	3	2022	42.0013558800817
214	1	2022	2258
214	1	1990	2433
214	3	1990	44
214	3	2022	131.40400925212
215	1	2022	889
215	1	1990	954
215	3	1990	51
215	3	2022	105
216	1	2022	258
216	1	1990	290
216	3	1990	27
216	3	2022	39.8372488934287
217	1	2022	155
217	1	1990	225
217	3	1990	19
217	3	2022	12.4571428571429
218	1	2022	341
218	1	1990	340
218	3	1990	8
218	3	2022	43
219	1	2022	208
219	1	1990	245
219	3	1990	13
219	3	2022	12.9084507042253
220	1	2022	245
220	1	1990	223
220	3	1990	26
220	3	2022	24.7542579075426
221	1	2022	150
221	1	1990	177
221	3	1990	3
221	3	2022	8
222	1	2022	351
222	1	1990	493
222	3	1990	32
222	3	2022	6.43373493975904
223	1	2022	214
223	1	1990	283
223	3	1990	6
223	3	2022	32.3478260869568
224	1	2022	141
224	1	1990	136
224	3	1990	25
224	3	2022	3.95820105820105
225	1	2022	251
225	1	1990	217
225	3	1990	8
225	3	2022	14
226	1	2022	496
226	1	1990	475
226	3	1990	30
226	3	2022	28.3888888888888
227	1	2022	253
227	1	1990	260
227	3	1990	14
227	3	2022	25.701746754882
228	1	2022	501
228	1	1990	359
228	3	1990	19
228	3	2022	22
229	1	2022	379
229	1	1990	297
229	3	1990	7
229	3	2022	20.5657458563536
230	1	2022	314
230	1	1990	454
230	3	1990	19
230	3	2022	47.8222222222222
231	1	2022	105
231	1	1990	97
231	3	1990	15
231	3	2022	9
232	1	2022	195
232	1	1990	222
232	3	1990	25
232	3	2022	14.2807291666667
233	1	2022	885
233	1	1990	874
233	3	1990	12
233	3	2022	31.816281030561
234	1	2022	379
234	1	1990	477
234	3	1990	67
234	3	2022	38.8523568144041
235	1	2022	2394
235	1	1990	2258
235	3	1990	16
235	3	2022	50
236	1	2022	571
236	1	1990	403
236	3	1990	17
236	3	2022	26.2855664951195
237	1	2022	116
237	1	1990	152
237	3	1990	12
237	3	2022	28.2857142857142
238	1	2022	164
238	1	1990	180
238	3	1990	15
238	3	2022	19.1055555555556
239	1	2022	715
239	1	1990	606
239	3	1990	19
239	3	2022	40
240	1	2022	617
240	1	1990	531
240	3	1990	3
240	3	2022	24.0623781676414
241	1	2022	221
241	1	1990	211
241	3	1990	16
241	3	2022	16.0023091355174
242	1	2022	2023
242	1	1990	1587
242	3	1990	24
242	3	2022	70.6906969061355
243	1	2022	4020
243	1	1990	4290
243	3	1990	167
243	3	2022	306
244	1	2022	525
244	1	1990	445
244	3	1990	14
244	3	2022	23.249135881786
245	1	2022	571
245	1	1990	526
245	3	1990	16
245	3	2022	39
246	1	2022	119
246	1	1990	106
246	3	1990	8
246	3	2022	2.19715099715099
247	1	2022	398
247	1	1990	529
247	3	1990	15
247	3	2022	29
248	1	2022	2909
248	1	1990	2606
248	3	1990	116
248	3	2022	160
249	1	2022	4334
249	1	1990	3378
249	3	1990	41
249	3	2022	127.970809668664
250	1	2022	298
250	1	1990	374
250	3	1990	23
250	3	2022	37.6268153339285
251	1	2022	232
251	1	1990	234
251	3	1990	11
251	3	2022	17
252	1	2022	7396
252	1	1990	7203
252	3	1990	209
252	3	2022	321.491581845812
253	1	2022	3394
253	1	1990	3893
253	3	1990	163
253	3	2022	403.387351589135
254	1	2022	493
254	1	1990	334
254	3	1990	27
254	3	2022	8.09125475285169
255	1	2022	1327
255	1	1990	997
255	3	1990	25
255	3	2022	65.0631162818662
256	1	2022	328
256	1	1990	370
256	3	1990	17
256	3	2022	28.3962264150944
257	1	2022	350
257	1	1990	372
257	3	1990	11
257	3	2022	17.1695792079207
258	1	2022	1339
258	1	1990	1050
258	3	1990	60
258	3	2022	88
259	1	2022	218
259	1	1990	264
259	3	1990	14
259	3	2022	17.7446808510638
260	1	2022	219
260	1	1990	194
260	3	1990	8
260	3	2022	10
261	1	2022	407
261	1	1990	374
261	3	1990	9
261	3	2022	26
262	1	2022	969
262	1	1990	1002
262	3	1990	17
262	3	2022	48
263	1	2022	323
263	1	1990	339
263	3	1990	75
263	3	2022	61.1081081081081
264	1	2022	313
264	1	1990	240
264	3	1990	17
264	3	2022	15
265	1	2022	1033
265	1	1990	1128
265	3	1990	49
265	3	2022	124
266	1	2022	212
266	1	1990	259
266	3	1990	16
266	3	2022	17.9770114942529
267	1	2022	796
267	1	1990	724
267	3	1990	38
267	3	2022	41.5487705702259
268	1	2022	102
268	1	1990	118
268	3	1990	23
268	3	2022	5
269	1	2022	380
269	1	1990	402
269	3	1990	22
269	3	2022	29.8644338118024
270	1	2022	429
270	1	1990	472
270	3	1990	23
270	3	2022	39
271	1	2022	358
271	1	1990	301
271	3	1990	13
271	3	2022	22
272	1	2022	915
272	1	1990	836
272	3	1990	24
272	3	2022	43.5614659484416
273	1	2022	44
273	1	1990	75
273	3	1990	4
273	3	2022	7
274	1	2022	488
274	1	1990	436
274	3	1990	28
274	3	2022	23.9035326086957
275	1	2022	131
275	1	1990	147
275	3	1990	19
275	3	2022	19.4130434782608
276	1	2022	130
276	1	1990	114
276	3	1990	5
276	3	2022	8.09523809523808
277	1	2022	726
277	1	1990	741
277	3	1990	61
277	3	2022	71
278	1	2022	832
278	1	1990	921
278	3	1990	25
278	3	2022	34.3854875283448
279	1	2022	94
279	1	1990	89
279	3	1990	16
279	3	2022	6.72727272727275
280	1	2022	121
280	1	1990	163
280	3	1990	7
280	3	2022	11.2444444444444
281	1	2022	124
281	1	1990	131
281	3	1990	10
281	3	2022	7.5121951219512
282	1	2022	350
282	1	1990	373
282	3	1990	13
282	3	2022	22.390500380123
283	1	2022	896
283	1	1990	1017
283	3	1990	65
283	3	2022	63.6426736922815
284	1	2022	306
284	1	1990	257
284	3	1990	12
284	3	2022	11.0723684210526
285	1	2022	795
285	1	1990	790
285	3	1990	71
285	3	2022	71.2151094923578
286	1	2022	1029
286	1	1990	1108
286	3	1990	56
286	3	2022	59.7956177520174
287	1	2022	3220
287	1	1990	3125
287	3	1990	54
287	3	2022	130.224898814625
288	1	2022	305
288	1	1990	282
288	3	1990	16
288	3	2022	16.0952380952381
289	1	2022	302
289	1	1990	288
289	3	1990	10
289	3	2022	23.0010224948875
290	1	2022	202
290	1	1990	250
290	3	1990	14
290	3	2022	18
291	1	2022	243
291	1	1990	243
291	3	1990	10
291	3	2022	22.4590368980613
292	1	2022	513
292	1	1990	437
292	3	1990	21
292	3	2022	38.3974735750142
293	1	2022	1273
293	1	1990	1083
293	3	1990	21
293	3	2022	39
294	1	2022	509
294	1	1990	578
294	3	1990	11
294	3	2022	19.3332872864577
295	1	2022	793
295	1	1990	777
295	3	1990	31
295	3	2022	44.8073288769879
296	1	2022	229
296	1	1990	222
296	3	1990	12
296	3	2022	34.8011363636364
297	1	2022	832
297	1	1990	694
297	3	1990	31
297	3	2022	26
298	1	2022	116
298	1	1990	104
298	3	1990	8
298	3	2022	16.1766774891775
299	1	2022	41
299	1	1990	46
299	3	1990	4
299	3	2022	3.62162162162162
300	1	2022	138
300	1	1990	182
300	3	1990	3
300	3	2022	22.2384879725087
301	1	2022	7556
301	1	1990	6436
301	3	1990	117
301	3	2022	285.081498808313
302	1	2022	1007
302	1	1990	1225
302	3	1990	31
302	3	2022	49.5384292479571
303	1	2022	400
303	1	1990	406
303	3	1990	8
303	3	2022	13.2500457959333
304	1	2022	313
304	1	1990	327
304	3	1990	17
304	3	2022	34.6663832500797
305	1	2022	311
305	1	1990	365
305	3	1990	33
305	3	2022	42.3135633204739
306	1	2022	531
306	1	1990	475
306	3	1990	49
306	3	2022	41.6614397380112
307	1	2022	68
307	1	1990	69
307	3	1990	8
307	3	2022	3.14821428571427
308	1	2022	98
308	1	1990	102
308	3	1990	20
308	3	2022	11
309	1	2022	2093
309	1	1990	2176
309	3	1990	59
309	3	2022	119.975578330632
310	1	2022	903
310	1	1990	633
310	3	1990	23
310	3	2022	34.2334578483188
311	1	2022	965
311	1	1990	946
311	3	1990	36
311	3	2022	42
312	1	2022	1166
312	1	1990	1121
312	3	1990	26
312	3	2022	38.8502996696236
313	1	2022	149
313	1	1990	130
313	3	1990	12
313	3	2022	6
314	1	2022	182
314	1	1990	227
314	3	1990	6
314	3	2022	14.206683971447
315	1	2022	10057
315	1	1990	10353
315	3	1990	212
315	3	2022	308.731507018736
316	1	2022	380
316	1	1990	367
316	3	1990	37
316	3	2022	34.2
317	1	2022	106
317	1	1990	103
317	3	1990	11
317	3	2022	9
318	1	2022	585
318	1	1990	544
318	3	1990	6
318	3	2022	24.7472018745538
319	1	2022	1530
319	1	1990	1175
319	3	1990	23
319	3	2022	61.7710515520023
320	1	2022	427
320	1	1990	329
320	3	1990	12
320	3	2022	17.2463768115942
321	1	2022	163
321	1	1990	170
321	3	1990	11
321	3	2022	19.3551401869159
322	1	2022	724
322	1	1990	731
322	3	1990	24
322	3	2022	27.9717449418065
323	1	2022	787
323	1	1990	579
323	3	1990	30
323	3	2022	36.3104207559514
324	1	2022	572
324	1	1990	643
324	3	1990	14
324	3	2022	21.4108422507149
325	1	2022	1146
325	1	1990	1020
325	3	1990	17
325	3	2022	24.4332674371451
326	1	2022	462
326	1	1990	401
326	3	1990	4
326	3	2022	23
327	1	2022	940
327	1	1990	555
327	3	1990	13
327	3	2022	21.4846153846154
328	1	2022	81
328	1	1990	110
328	3	1990	21
328	3	2022	11
329	1	2022	240
329	1	1990	349
329	3	1990	18
329	3	2022	34
330	1	2022	190
330	1	1990	212
330	3	1990	14
330	3	2022	11.7515673225308
331	1	2022	2862
331	1	1990	2220
331	3	1990	90
331	3	2022	124
332	1	2022	79
332	1	1990	106
332	3	1990	11
332	3	2022	9
333	1	2022	295
333	1	1990	321
333	3	1990	27
333	3	2022	17.0815280208142
334	1	2022	121
334	1	1990	124
334	3	1990	14
334	3	2022	6.87410511611663
335	1	2022	383
335	1	1990	371
335	3	1990	10
335	3	2022	18.8411359167723
336	1	2022	94
336	1	1990	102
336	3	1990	17
336	3	2022	4.37847222222222
337	1	2022	321
337	1	1990	406
337	3	1990	37
337	3	2022	22.6254295532646
338	1	2022	588
338	1	1990	714
338	3	1990	34
338	3	2022	25.0980392156863
339	1	2022	147
339	1	1990	152
339	3	1990	4
339	3	2022	4.03396891523794
340	1	2022	294
340	1	1990	223
340	3	1990	11
340	3	2022	22.4013695090441
341	1	2022	131
341	1	1990	154
341	3	1990	15
341	3	2022	14
342	1	2022	108
342	1	1990	85
342	3	1990	11
342	3	2022	7
343	1	2022	161
343	1	1990	181
343	3	1990	25
343	3	2022	16.1649484536083
344	1	2022	804
344	1	1990	633
344	3	1990	26
344	3	2022	32
345	1	2022	718
345	1	1990	765
345	3	1990	17
345	3	2022	47.3487183592045
346	1	2022	981
346	1	1990	996
346	3	1990	80
346	3	2022	86.5601233928652
347	1	2022	367
347	1	1990	279
347	3	1990	11
347	3	2022	17.3496963874733
348	1	2022	159
348	1	1990	123
348	3	1990	14
348	3	2022	7.337822671156
349	1	2022	332
349	1	1990	400
349	3	1990	21
349	3	2022	41
350	1	2022	1044
350	1	1990	933
350	3	1990	16
350	3	2022	23
351	1	2022	494
351	1	1990	513
351	3	1990	27
351	3	2022	43.262996941896
352	1	2022	1594
352	1	1990	1344
352	3	1990	6
352	3	2022	32.4873799707256
353	1	2022	312
353	1	1990	339
353	3	1990	13
353	3	2022	11.4418604651163
354	1	2022	242
354	1	1990	289
354	3	1990	12
354	3	2022	16.3157894736842
355	1	2022	408
355	1	1990	351
355	3	1990	8
355	3	2022	13.9088241931844
356	1	2022	822
356	1	1990	674
356	3	1990	15
356	3	2022	6.06671314923778
357	1	2022	235
357	1	1990	320
357	3	1990	10
357	3	2022	19.1225806451614
358	1	2022	536
358	1	1990	503
358	3	1990	48
358	3	2022	45.8662790697674
359	1	2022	562
359	1	1990	432
359	3	1990	25
359	3	2022	22.1430627875287
360	1	2022	133
360	1	1990	99
360	3	1990	0
360	3	2022	5.29166666666666
361	1	2022	4578
361	1	1990	2944
361	3	1990	81
361	3	2022	140.628875316431
362	1	2022	196
362	1	1990	199
362	3	1990	14
362	3	2022	6.49368495028675
363	1	2022	197
363	1	1990	163
363	3	1990	5
363	3	2022	10
364	1	2022	266
364	1	1990	207
364	3	1990	8
364	3	2022	11.7333333333333
365	1	2022	318
365	1	1990	231
365	3	1990	6
365	3	2022	7.24374940128359
366	1	2022	2314
366	1	1990	1481
366	3	1990	23
366	3	2022	70.4464148038603
367	1	2022	1366
367	1	1990	310
367	3	1990	5
367	3	2022	11.6316080522561
368	1	2022	4147
368	1	1990	2908
368	3	1990	64
368	3	2022	158.001222710939
369	1	2022	395
369	1	1990	208
369	3	1990	14
369	3	2022	16.1641283299314
370	1	2022	163
370	1	1990	149
370	3	1990	4
370	3	2022	12.5667138142386
371	1	2022	366
371	1	1990	353
371	3	1990	15
371	3	2022	22
372	1	2022	715
372	1	1990	485
372	3	1990	28
372	3	2022	36
373	1	2022	762
373	1	1990	837
373	3	1990	33
373	3	2022	56.4846571250308
374	1	2022	764
374	1	1990	539
374	3	1990	51
374	3	2022	31
375	1	2022	877
375	1	1990	508
375	3	1990	23
375	3	2022	34.2677764898677
376	1	2022	1306
376	1	1990	1165
376	3	1990	65
376	3	2022	75.1812557691956
377	1	2022	339
377	1	1990	331
377	3	1990	18
377	3	2022	20.6904761904762
378	1	2022	3875
378	1	1990	2734
378	3	1990	72
378	3	2022	161
379	1	2022	980
379	1	1990	817
379	3	1990	51
379	3	2022	76.2755102040819
380	1	2022	373
380	1	1990	321
380	3	1990	17
380	3	2022	20.2642877056036
381	1	2022	1359
381	1	1990	1462
381	3	1990	103
381	3	2022	144.510879456346
382	1	2022	699
382	1	1990	634
382	3	1990	35
382	3	2022	32.0756501182032
383	1	2022	398
383	1	1990	460
383	3	1990	18
383	3	2022	42.0320317917028
384	1	2022	491
384	1	1990	457
384	3	1990	11
384	3	2022	16.6900275735295
385	1	2022	9759
385	1	1990	7786
385	3	1990	113
385	3	2022	405
386	1	2022	179
386	1	1990	160
386	3	1990	6
386	3	2022	6
387	1	2022	614
387	1	1990	355
387	3	1990	23
387	3	2022	40.1830635118307
388	1	2022	203
388	1	1990	204
388	3	1990	23
388	3	2022	18
389	1	2022	823
389	1	1990	482
389	3	1990	20
389	3	2022	19.4511873350923
390	1	2022	496
390	1	1990	377
390	3	1990	8
390	3	2022	29.3057305021035
391	1	2022	470
391	1	1990	410
391	3	1990	11
391	3	2022	33.1785142857143
392	1	2022	104
392	1	1990	148
392	3	1990	7
392	3	2022	7.9080459770115
393	1	2022	785
393	1	1990	452
393	3	1990	9
393	3	2022	11.1349693251534
394	1	2022	654
394	1	1990	645
394	3	1990	37
394	3	2022	48.4582417392854
395	1	2022	689
395	1	1990	494
395	3	1990	26
395	3	2022	34.3723796812437
396	1	2022	216
396	1	1990	168
396	3	1990	2
396	3	2022	18.288
397	1	2022	1811
397	1	1990	426
397	3	1990	26
397	3	2022	40.2752839034755
398	1	2022	447
398	1	1990	312
398	3	1990	21
398	3	2022	20.0826446280992
399	1	2022	761
399	1	1990	657
399	3	1990	34
399	3	2022	57.8469957051736
400	1	2022	1163
400	1	1990	732
400	3	1990	25
400	3	2022	60.4058119658121
401	1	2022	1003
401	1	1990	731
401	3	1990	32
401	3	2022	36.4835462208486
402	1	2022	363
402	1	1990	312
402	3	1990	27
402	3	2022	16
403	1	2022	240
403	1	1990	249
403	3	1990	11
403	3	2022	15.1843238587425
404	1	2022	330
404	1	1990	308
404	3	1990	14
404	3	2022	20.9017690875233
405	1	2022	77
405	1	1990	83
405	3	1990	8
405	3	2022	3.32478632478633
406	1	2022	519
406	1	1990	427
406	3	1990	22
406	3	2022	46.6818232077517
407	1	2022	2177
407	1	1990	2014
407	3	1990	37
407	3	2022	76.9846024398932
408	1	2022	713
408	1	1990	603
408	3	1990	36
408	3	2022	43
409	1	2022	1313
409	1	1990	1109
409	3	1990	42
409	3	2022	62.1215457582147
410	1	2022	203
410	1	1990	198
410	3	1990	9
410	3	2022	14.2153846153847
411	1	2022	336
411	1	1990	321
411	3	1990	33
411	3	2022	20
412	1	2022	632
412	1	1990	450
412	3	1990	20
412	3	2022	27.9845284736784
413	1	2022	910
413	1	1990	390
413	3	1990	17
413	3	2022	17.6771555598357
414	1	2022	3515
414	1	1990	2851
414	3	1990	115
414	3	2022	171.755097343144
415	1	2022	1441
415	1	1990	1044
415	3	1990	10
415	3	2022	20.6752547562848
416	1	2022	230
416	1	1990	219
416	3	1990	10
416	3	2022	19
417	1	2022	140
417	1	1990	132
417	3	1990	9
417	3	2022	7.08974358974357
418	1	2022	228
418	1	1990	307
418	3	1990	9
418	3	2022	22
419	1	2022	473
419	1	1990	329
419	3	1990	19
419	3	2022	16
420	1	2022	3060
420	1	1990	1863
420	3	1990	41
420	3	2022	191.566980003686
421	1	2022	1891
421	1	1990	1160
421	3	1990	23
421	3	2022	60.3499743983619
422	1	2022	225
422	1	1990	275
422	3	1990	7
422	3	2022	13.0833333333334
423	1	2022	170
423	1	1990	178
423	3	1990	13
423	3	2022	14
424	1	2022	238
424	1	1990	228
424	3	1990	15
424	3	2022	20.0469929245283
425	1	2022	219
425	1	1990	176
425	3	1990	10
425	3	2022	15.7695721640334
426	1	2022	978
426	1	1990	790
426	3	1990	17
426	3	2022	67.7073966457664
427	1	2022	516
427	1	1990	520
427	3	1990	12
427	3	2022	37
428	1	2022	1337
428	1	1990	1209
428	3	1990	28
428	3	2022	99.4987052882597
429	1	2022	1313
429	1	1990	989
429	3	1990	24
429	3	2022	46.6589861751154
430	1	2022	1079
430	1	1990	860
430	3	1990	32
430	3	2022	54.0984182587775
431	1	2022	1470
431	1	1990	1087
431	3	1990	17
431	3	2022	47.0164220964158
432	1	2022	326
432	1	1990	280
432	3	1990	4
432	3	2022	31.1145833333333
433	1	2022	1289
433	1	1990	1101
433	3	1990	51
433	3	2022	86.1219858156027
434	1	2022	526
434	1	1990	424
434	3	1990	25
434	3	2022	27.9601527121187
435	1	2022	1652
435	1	1990	1031
435	3	1990	36
435	3	2022	67.2028550989558
436	1	2022	985
436	1	1990	730
436	3	1990	18
436	3	2022	29.8759718231927
437	1	2022	369
437	1	1990	316
437	3	1990	11
437	3	2022	24.472906403941
438	1	2022	493
438	1	1990	427
438	3	1990	28
438	3	2022	18
439	1	2022	637
439	1	1990	482
439	3	1990	20
439	3	2022	13.1887327482779
440	1	2022	687
440	1	1990	449
440	3	1990	21
440	3	2022	35.1543417303223
441	1	2022	419
441	1	1990	328
441	3	1990	15
441	3	2022	8.11448009041906
442	1	2022	3634
442	1	1990	3086
442	3	1990	74
442	3	2022	112.481981032665
443	1	2022	214
443	1	1990	100
443	3	1990	7
443	3	2022	4.04347826086956
444	1	2022	1007
444	1	1990	890
444	3	1990	19
444	3	2022	22.662638640382
445	1	2022	2014
445	1	1990	1512
445	3	1990	22
445	3	2022	42.982271747913
446	1	2022	164
446	1	1990	167
446	3	1990	8
446	3	2022	4.04494382022472
447	1	2022	4359
447	1	1990	3544
447	3	1990	155
447	3	2022	205.379360401469
448	1	2022	6440
448	1	1990	4993
448	3	1990	133
448	3	2022	114.882649691542
449	1	2022	217
449	1	1990	195
449	3	1990	9
449	3	2022	12.258064516129
450	1	2022	70
450	1	1990	81
450	3	1990	3
450	3	2022	2.17188208616779
451	1	2022	836
451	1	1990	529
451	3	1990	14
451	3	2022	20
452	1	2022	595
452	1	1990	599
452	3	1990	36
452	3	2022	42.5064052891952
453	1	2022	694
453	1	1990	604
453	3	1990	37
453	3	2022	38
454	1	2022	1135
454	1	1990	1045
454	3	1990	60
454	3	2022	38.5577147420541
455	1	2022	340
455	1	1990	375
455	3	1990	24
455	3	2022	27.468531419244
456	1	2022	1274
456	1	1990	968
456	3	1990	24
456	3	2022	33.528846153846
457	1	2022	1087
457	1	1990	1008
457	3	1990	97
457	3	2022	38.6443434872183
458	1	2022	309
458	1	1990	424
458	3	1990	38
458	3	2022	34.3671505508623
459	1	2022	321
459	1	1990	183
459	3	1990	16
459	3	2022	22.2222075441153
460	1	2022	1560
460	1	1990	686
460	3	1990	17
460	3	2022	28.3587106252552
461	1	2022	405
461	1	1990	237
461	3	1990	9
461	3	2022	12.5631357766335
462	1	2022	1423
462	1	1990	592
462	3	1990	6
462	3	2022	29.0235451886079
463	1	2022	1026
463	1	1990	961
463	3	1990	63
463	3	2022	85.556492152731
464	1	2022	847
464	1	1990	743
464	3	1990	40
464	3	2022	48
465	1	2022	744
465	1	1990	368
465	3	1990	15
465	3	2022	26.603753808745
466	1	2022	708
466	1	1990	475
466	3	1990	25
466	3	2022	35.4539394519499
467	1	2022	196
467	1	1990	222
467	3	1990	9
467	3	2022	18
468	1	2022	301
468	1	1990	217
468	3	1990	18
468	3	2022	30.3333333333334
469	1	2022	235
469	1	1990	210
469	3	1990	26
469	3	2022	18
470	1	2022	136
470	1	1990	165
470	3	1990	6
470	3	2022	12
471	1	2022	328
471	1	1990	230
471	3	1990	13
471	3	2022	11
472	1	2022	1278
472	1	1990	686
472	3	1990	51
472	3	2022	44
473	1	2022	1969
473	1	1990	1204
473	3	1990	25
473	3	2022	56
474	1	2022	1112
474	1	1990	1029
474	3	1990	7
474	3	2022	37.3170320842273
475	1	2022	227
475	1	1990	193
475	3	1990	21
475	3	2022	14.1555555555556
476	1	2022	442
476	1	1990	294
476	3	1990	24
476	3	2022	18.1950745963621
477	1	2022	454
477	1	1990	494
477	3	1990	14
477	3	2022	12.1851851851852
478	1	2022	311
478	1	1990	262
478	3	1990	19
478	3	2022	22.8790293183357
479	1	2022	2081
479	1	1990	990
479	3	1990	34
479	3	2022	147
480	1	2022	717
480	1	1990	546
480	3	1990	15
480	3	2022	29.3201426024958
481	1	2022	413
481	1	1990	341
481	3	1990	24
481	3	2022	25.781512605042
482	1	2022	484
482	1	1990	400
482	3	1990	27
482	3	2022	24.3606375251037
483	1	2022	2223
483	1	1990	1730
483	3	1990	84
483	3	2022	143.81850971574
484	1	2022	648
484	1	1990	516
484	3	1990	10
484	3	2022	41.7432024169182
485	1	2022	859
485	1	1990	526
485	3	1990	22
485	3	2022	33
486	1	2022	442
486	1	1990	357
486	3	1990	15
486	3	2022	53
487	1	2022	225
487	1	1990	266
487	3	1990	15
487	3	2022	21.3749999999999
488	1	2022	1377
488	1	1990	863
488	3	1990	13
488	3	2022	45.248025822042
489	1	2022	223
489	1	1990	161
489	3	1990	8
489	3	2022	11
490	1	2022	271
490	1	1990	335
490	3	1990	12
490	3	2022	26
491	1	2022	373
491	1	1990	327
491	3	1990	21
491	3	2022	24
492	1	2022	3187
492	1	1990	2440
492	3	1990	138
492	3	2022	122.773625145219
493	1	2022	483
493	1	1990	398
493	3	1990	25
493	3	2022	26.3796540761894
494	1	2022	6084
494	1	1990	3627
494	3	1990	38
494	3	2022	175.212981595851
495	1	2022	705
495	1	1990	589
495	3	1990	11
495	3	2022	43.8854824518318
496	1	2022	482
496	1	1990	440
496	3	1990	9
496	3	2022	35.3642960812772
497	1	2022	3701
497	1	1990	2672
497	3	1990	49
497	3	2022	101.597820163488
498	1	2022	1380
498	1	1990	804
498	3	1990	23
498	3	2022	53.0521368442929
499	1	2022	445
499	1	1990	291
499	3	1990	3
499	3	2022	10.2727272727273
500	1	2022	58
500	1	1990	82
500	3	1990	0
500	3	2022	7.00264700321422
501	1	2022	533
501	1	1990	545
501	3	1990	27
501	3	2022	37.8899759422615
502	1	2022	909
502	1	1990	722
502	3	1990	28
502	3	2022	36
503	1	2022	925
503	1	1990	676
503	3	1990	36
503	3	2022	76.3638067042097
504	1	2022	2132
504	1	1990	1730
504	3	1990	68
504	3	2022	74.7331349206349
505	1	2022	733
505	1	1990	445
505	3	1990	24
505	3	2022	20.0776809763007
506	1	2022	2763
506	1	1990	1413
506	3	1990	38
506	3	2022	153.382651571405
507	1	2022	120
507	1	1990	87
507	3	1990	13
507	3	2022	9.12779973649541
508	1	2022	168
508	1	1990	133
508	3	1990	5
508	3	2022	13.5098039215686
509	1	2022	1459
509	1	1990	306
509	3	1990	20
509	3	2022	43.9833597242725
510	1	2022	361
510	1	1990	340
510	3	1990	22
510	3	2022	20.969475112182
511	1	2022	427
511	1	1990	338
511	3	1990	42
511	3	2022	36.9338399703698
512	1	2022	3131
512	1	1990	2452
512	3	1990	66
512	3	2022	32
513	1	2022	224
513	1	1990	270
513	3	1990	16
513	3	2022	23.6606016933886
514	1	2022	511
514	1	1990	370
514	3	1990	28
514	3	2022	40.4825908858164
515	1	2022	2313
515	1	1990	1962
515	3	1990	34
515	3	2022	45.1204138226678
516	1	2022	392
516	1	1990	365
516	3	1990	36
516	3	2022	35.7768764071286
517	1	2022	1323
517	1	1990	786
517	3	1990	42
517	3	2022	57.5089462512052
518	1	2022	760
518	1	1990	615
518	3	1990	19
518	3	2022	56
519	1	2022	4124
519	1	1990	3238
519	3	1990	252
519	3	2022	284
520	1	2022	783
520	1	1990	464
520	3	1990	31
520	3	2022	36
521	1	2022	3033
521	1	1990	2333
521	3	1990	74
521	3	2022	134
522	1	2022	220
522	1	1990	268
522	3	1990	15
522	3	2022	23
523	1	2022	889
523	1	1990	533
523	3	1990	21
523	3	2022	41.442668798198
524	1	2022	647
524	1	1990	539
524	3	1990	7
524	3	2022	26.9284149420194
525	1	2022	103
525	1	1990	138
525	3	1990	21
525	3	2022	16.3516483516483
526	1	2022	119
526	1	1990	102
526	3	1990	15
526	3	2022	12.6726190476191
527	1	2022	77
527	1	1990	59
527	3	1990	4
527	3	2022	8.2
528	1	2022	1759
528	1	1990	1129
528	3	1990	32
528	3	2022	71.1623456790122
529	1	2022	107
529	1	1990	132
529	3	1990	13
529	3	2022	8.6845466155811
530	1	2022	310
530	1	1990	224
530	3	1990	25
530	3	2022	22.4136585365854
531	1	2022	568
531	1	1990	317
531	3	1990	21
531	3	2022	22.0798060656796
532	1	2022	951
532	1	1990	616
532	3	1990	15
532	3	2022	52.1503759398496
533	1	2022	598
533	1	1990	402
533	3	1990	13
533	3	2022	24.5894736842105
534	1	2022	2115
534	1	1990	1689
534	3	1990	68
534	3	2022	87.0122423393198
535	1	2022	1040
535	1	1990	440
535	3	1990	27
535	3	2022	13.4099561961637
536	1	2022	479
536	1	1990	343
536	3	1990	20
536	3	2022	24.3636363636364
537	1	2022	452
537	1	1990	466
537	3	1990	32
537	3	2022	40
538	1	2022	2953
538	1	1990	2486
538	3	1990	13
538	3	2022	40.7932609925657
539	1	2022	427
539	1	1990	259
539	3	1990	13
539	3	2022	17.1619047619047
540	1	2022	876
540	1	1990	713
540	3	1990	28
540	3	2022	44.9240191387562
541	1	2022	2591
541	1	1990	1633
541	3	1990	16
541	3	2022	38.1486888984316
542	1	2022	3447
542	1	1990	2413
542	3	1990	19
542	3	2022	101.016331658291
543	1	2022	272
543	1	1990	268
543	3	1990	14
543	3	2022	8.90625
544	1	2022	548
544	1	1990	367
544	3	1990	7
544	3	2022	18
545	1	2022	3576
545	1	1990	3998
545	3	1990	408
545	3	2022	370.963472447663
546	1	2022	314
546	1	1990	169
546	3	1990	6
546	3	2022	14
547	1	2022	153
547	1	1990	96
547	3	1990	4
547	3	2022	9
548	1	2022	7594
548	1	1990	5287
548	3	1990	96
548	3	2022	375.508148638477
549	1	2022	494
549	1	1990	243
549	3	1990	23
549	3	2022	12.2943289523185
550	1	2022	575
550	1	1990	527
550	3	1990	27
550	3	2022	38.6676642844241
551	1	2022	798
551	1	1990	474
551	3	1990	20
551	3	2022	23
552	1	2022	301
552	1	1990	264
552	3	1990	24
552	3	2022	38
553	1	2022	382
553	1	1990	314
553	3	1990	5
553	3	2022	6
554	1	2022	284
554	1	1990	340
554	3	1990	16
554	3	2022	9.14087296204868
555	1	2022	742
555	1	1990	561
555	3	1990	26
555	3	2022	17.394880179617
556	1	2022	1061
556	1	1990	417
556	3	1990	7
556	3	2022	15
557	1	2022	268
557	1	1990	244
557	3	1990	12
557	3	2022	11.2211550774747
558	1	2022	511
558	1	1990	534
558	3	1990	51
558	3	2022	59.3305322128855
559	1	2022	761
559	1	1990	786
559	3	1990	39
559	3	2022	42
560	1	2022	172
560	1	1990	166
560	3	1990	6
560	3	2022	14.1176470588236
561	1	2022	155
561	1	1990	170
561	3	1990	18
561	3	2022	14.8647660818713
562	1	2022	513
562	1	1990	214
562	3	1990	12
562	3	2022	10
563	1	2022	43
563	1	1990	48
563	3	1990	1
563	3	2022	6.66666666666667
564	1	2022	1013
564	1	1990	763
564	3	1990	39
564	3	2022	37.3035298327723
565	1	2022	296
565	1	1990	276
565	3	1990	17
565	3	2022	35.1776649746192
566	1	2022	4487
566	1	1990	4170
566	3	1990	131
566	3	2022	285
567	1	2022	6148
567	1	1990	5132
567	3	1990	195
567	3	2022	336
568	1	2022	412
568	1	1990	347
568	3	1990	12
568	3	2022	18.75
569	1	2022	956
569	1	1990	702
569	3	1990	36
569	3	2022	46.5573306027649
570	1	2022	3185
570	1	1990	1926
570	3	1990	29
570	3	2022	67.4995424344827
571	1	2022	183
571	1	1990	194
571	3	1990	10
571	3	2022	14.5453720508167
572	1	2022	2202
572	1	1990	2183
572	3	1990	85
572	3	2022	156
573	1	2022	2184
573	1	1990	1205
573	3	1990	106
573	3	2022	13.2733543483088
574	1	2022	990
574	1	1990	762
574	3	1990	26
574	3	2022	40
575	1	2022	236
575	1	1990	187
575	3	1990	12
575	3	2022	14.6639529624604
576	1	2022	3041
576	1	1990	1965
576	3	1990	30
576	3	2022	116.092229925537
577	1	2022	235
577	1	1990	179
577	3	1990	17
577	3	2022	27
578	1	2022	3165
578	1	1990	1862
578	3	1990	63
578	3	2022	125.498088433459
579	1	2022	104
579	1	1990	127
579	3	1990	12
579	3	2022	14.343530470291
580	1	2022	1544
580	1	1990	922
580	3	1990	55
580	3	2022	85.6863008729439
581	1	2022	329
581	1	1990	310
581	3	1990	17
581	3	2022	18.1904761904762
582	1	2022	354
582	1	1990	329
582	3	1990	22
582	3	2022	21.039618488628
583	1	2022	699
583	1	1990	740
583	3	1990	34
583	3	2022	38
584	1	2022	1532
584	1	1990	1409
584	3	1990	68
584	3	2022	183.389827029636
585	1	2022	592
585	1	1990	467
585	3	1990	12
585	3	2022	21.7971280276816
586	1	2022	446
586	1	1990	439
586	3	1990	36
586	3	2022	31.6976744186046
587	1	2022	3226
587	1	1990	3140
587	3	1990	191
587	3	2022	257.018410604867
588	1	2022	1636
588	1	1990	1647
588	3	1990	48
588	3	2022	84.8576850219876
589	1	2022	871
589	1	1990	644
589	3	1990	26
589	3	2022	31.5159275576473
590	1	2022	1263
590	1	1990	1326
590	3	1990	81
590	3	2022	123.970337375346
591	1	2022	686
591	1	1990	502
591	3	1990	36
591	3	2022	42
592	1	2022	940
592	1	1990	486
592	3	1990	8
592	3	2022	25.0714221143215
593	1	2022	538
593	1	1990	394
593	3	1990	18
593	3	2022	11.6987325152754
594	1	2022	867
594	1	1990	640
594	3	1990	18
594	3	2022	50.1018321477969
595	1	2022	911
595	1	1990	972
595	3	1990	50
595	3	2022	80.6068268015168
596	1	2022	170
596	1	1990	184
596	3	1990	15
596	3	2022	18.4043392504931
597	1	2022	489
597	1	1990	431
597	3	1990	41
597	3	2022	26.7573689109526
598	1	2022	313
598	1	1990	275
598	3	1990	7
598	3	2022	10.7821728430805
599	1	2022	1357
599	1	1990	1017
599	3	1990	34
599	3	2022	54.7838709677424
600	1	2022	204
600	1	1990	190
600	3	1990	11
600	3	2022	13
601	1	2022	795
601	1	1990	353
601	3	1990	14
601	3	2022	25.1394687261797
602	1	2022	326
602	1	1990	259
602	3	1990	24
602	3	2022	18.6527511398943
603	1	2022	667
603	1	1990	752
603	3	1990	43
603	3	2022	100.853785782335
604	1	2022	316
604	1	1990	214
604	3	1990	13
604	3	2022	22.8516129032257
605	1	2022	160
605	1	1990	155
605	3	1990	1
605	3	2022	5.0602409638554
606	1	2022	408
606	1	1990	331
606	3	1990	15
606	3	2022	42.2037037037037
607	1	2022	346
607	1	1990	385
607	3	1990	23
607	3	2022	36.8343208855817
608	1	2022	1213
608	1	1990	953
608	3	1990	31
608	3	2022	38.039709852271
609	1	2022	577
609	1	1990	547
609	3	1990	26
609	3	2022	40.8861111111111
610	1	2022	5805
610	1	1990	4957
610	3	1990	80
610	3	2022	162.000160692847
611	1	2022	1224
611	1	1990	506
611	3	1990	17
611	3	2022	42.4490033473404
612	1	2022	724
612	1	1990	607
612	3	1990	26
612	3	2022	43.6355913257324
613	1	2022	1259
613	1	1990	550
613	3	1990	23
613	3	2022	31
614	1	2022	422
614	1	1990	401
614	3	1990	28
614	3	2022	25.2137931034483
615	1	2022	715
615	1	1990	653
615	3	1990	21
615	3	2022	41.2152674693499
616	1	2022	611
616	1	1990	503
616	3	1990	24
616	3	2022	36.0833333333332
617	1	2022	327
617	1	1990	333
617	3	1990	36
617	3	2022	23.4162895927603
618	1	2022	959
618	1	1990	964
618	3	1990	63
618	3	2022	79
619	1	2022	8802
619	1	1990	4129
619	3	1990	41
619	3	2022	176.276748978292
620	1	2022	799
620	1	1990	566
620	3	1990	13
620	3	2022	20.5141388174806
621	1	2022	71
621	1	1990	60
621	3	1990	0
621	3	2022	5
622	1	2022	1029
622	1	1990	1032
622	3	1990	51
622	3	2022	68.1112929623568
623	1	2022	775
623	1	1990	386
623	3	1990	17
623	3	2022	38.4116071382589
624	1	2022	666
624	1	1990	387
624	3	1990	11
624	3	2022	45.8723404255321
625	1	2022	817
625	1	1990	433
625	3	1990	26
625	3	2022	40
626	1	2022	161
626	1	1990	119
626	3	1990	8
626	3	2022	11
627	1	2022	212
627	1	1990	182
627	3	1990	11
627	3	2022	7.17647058823529
628	1	2022	4308
628	1	1990	4412
628	3	1990	234
628	3	2022	380.133910243382
629	1	2022	1793
629	1	1990	1385
629	3	1990	63
629	3	2022	112.321739322546
630	1	2022	1170
630	1	1990	1028
630	3	1990	38
630	3	2022	58.7864726279566
631	1	2022	582
631	1	1990	660
631	3	1990	7
631	3	2022	23.6794900203534
632	1	2022	288
632	1	1990	243
632	3	1990	12
632	3	2022	18
633	1	2022	312
633	1	1990	236
633	3	1990	12
633	3	2022	25.3138183606387
634	1	2022	438
634	1	1990	305
634	3	1990	12
634	3	2022	7.51955577015937
635	1	2022	286
635	1	1990	260
635	3	1990	13
635	3	2022	10.0617283950617
636	1	2022	6668
636	1	1990	4067
636	3	1990	64
636	3	2022	159.373668577477
637	1	2022	521
637	1	1990	248
637	3	1990	17
637	3	2022	15.1276595744681
638	1	2022	723
638	1	1990	406
638	3	1990	16
638	3	2022	33.1545101699578
639	1	2022	184
639	1	1990	209
639	3	1990	15
639	3	2022	26
640	1	2022	773
640	1	1990	731
640	3	1990	38
640	3	2022	46.8141592920354
641	1	2022	1057
641	1	1990	805
641	3	1990	24
641	3	2022	63
642	1	2022	2428
642	1	1990	1163
642	3	1990	30
642	3	2022	96.2136124545068
643	1	2022	977
643	1	1990	715
643	3	1990	52
643	3	2022	36.7270659104745
644	1	2022	23188
644	1	1990	25561
644	3	1990	1246
644	3	2022	1487.07887091037
645	1	2022	79961
645	1	1990	71094
645	3	1990	2274
645	3	2022	3655.8180973407
646	1	2022	83
646	1	1990	99
646	3	1990	9
646	3	2022	9.54285714285713
647	1	2022	623
647	1	1990	493
647	3	1990	35
647	3	2022	32.8290439684195
648	1	2022	1005
648	1	1990	703
648	3	1990	30
648	3	2022	52.1805555555554
649	1	2022	503
649	1	1990	352
649	3	1990	14
649	3	2022	31.807595009548
650	1	2022	427
650	1	1990	358
650	3	1990	30
650	3	2022	28.4943487122475
651	1	2022	19322
651	1	1990	16837
651	3	1990	1220
651	3	2022	614.113742889465
652	1	2022	1413
652	1	1990	1027
652	3	1990	39
652	3	2022	63.396091084515
653	1	2022	2774
653	1	1990	1830
653	3	1990	49
653	3	2022	84.2453999900816
654	1	2022	1884
654	1	1990	2040
654	3	1990	103
654	3	2022	199.808970099668
655	1	2022	1220
655	1	1990	810
655	3	1990	36
655	3	2022	47.3661201893906
656	1	2022	1503
656	1	1990	742
656	3	1990	44
656	3	2022	10
657	1	2022	840
657	1	1990	819
657	3	1990	56
657	3	2022	65.1880733771779
658	1	2022	388
658	1	1990	359
658	3	1990	24
658	3	2022	23
659	1	2022	894
659	1	1990	858
659	3	1990	23
659	3	2022	38.152610441767
660	1	2022	1405
660	1	1990	827
660	3	1990	23
660	3	2022	53.2901781170485
661	1	2022	388
661	1	1990	375
661	3	1990	22
661	3	2022	25.3164556962026
662	1	2022	575
662	1	1990	569
662	3	1990	19
662	3	2022	41.4270833333332
663	1	2022	712
663	1	1990	607
663	3	1990	55
663	3	2022	32.683281771361
664	1	2022	110
664	1	1990	120
664	3	1990	5
664	3	2022	5.24590163934425
665	1	2022	416
665	1	1990	293
665	3	1990	17
665	3	2022	15.2898550724639
666	1	2022	346
666	1	1990	237
666	3	1990	22
666	3	2022	7
667	1	2022	683
667	1	1990	340
667	3	1990	16
667	3	2022	33.0653400037057
668	1	2022	1346
668	1	1990	1107
668	3	1990	148
668	3	2022	78.6945072570502
669	1	2022	113
669	1	1990	83
669	3	1990	12
669	3	2022	5.07042253521125
670	1	2022	501
670	1	1990	584
670	3	1990	57
670	3	2022	59
671	1	2022	285
671	1	1990	319
671	3	1990	16
671	3	2022	31
672	1	2022	322
672	1	1990	253
672	3	1990	16
672	3	2022	18.2591760299626
673	1	2022	907
673	1	1990	1012
673	3	1990	67
673	3	2022	79.326356750065
674	1	2022	390
674	1	1990	245
674	3	1990	8
674	3	2022	15.7191598723858
675	1	2022	1364
675	1	1990	869
675	3	1990	30
675	3	2022	55
676	1	2022	1252
676	1	1990	956
676	3	1990	44
676	3	2022	90.7748112006877
677	1	2022	407
677	1	1990	344
677	3	1990	35
677	3	2022	37.0702680462909
678	1	2022	5093
678	1	1990	4705
678	3	1990	382
678	3	2022	186
679	1	2022	281
679	1	1990	243
679	3	1990	35
679	3	2022	38
680	1	2022	2840
680	1	1990	1912
680	3	1990	45
680	3	2022	74
681	1	2022	4052
681	1	1990	3144
681	3	1990	110
681	3	2022	27
682	1	2022	1869
682	1	1990	1373
682	3	1990	42
682	3	2022	67
683	1	2022	1298
683	1	1990	1166
683	3	1990	22
683	3	2022	63.4341534404707
684	1	2022	1498
684	1	1990	1410
684	3	1990	37
684	3	2022	53.5293383270914
685	1	2022	186
685	1	1990	197
685	3	1990	10
685	3	2022	12
686	1	2022	406
686	1	1990	346
686	3	1990	27
686	3	2022	23.4440154440154
687	1	2022	144
687	1	1990	134
687	3	1990	11
687	3	2022	12
688	1	2022	1350
688	1	1990	1066
688	3	1990	36
688	3	2022	75
689	1	2022	298
689	1	1990	273
689	3	1990	10
689	3	2022	15.5202312138728
690	1	2022	1485
690	1	1990	1109
690	3	1990	30
690	3	2022	47.0132158590305
691	1	2022	6679
691	1	1990	8060
691	3	1990	361
691	3	2022	1023.27459073837
692	1	2022	698
692	1	1990	486
692	3	1990	13
692	3	2022	27
693	1	2022	3050
693	1	1990	1627
693	3	1990	59
693	3	2022	76.6825463428311
694	1	2022	857
694	1	1990	838
694	3	1990	29
694	3	2022	83.6114180478818
695	1	2022	2100
695	1	1990	1432
695	3	1990	36
695	3	2022	96.8868690675625
696	1	2022	2285
696	1	1990	1256
696	3	1990	44
696	3	2022	82.619010066144
697	1	2022	672
697	1	1990	461
697	3	1990	26
697	3	2022	19.8603076406765
698	1	2022	527
698	1	1990	476
698	3	1990	24
698	3	2022	26
699	1	2022	312
699	1	1990	274
699	3	1990	14
699	3	2022	17.2561132561132
700	1	2022	533
700	1	1990	511
700	3	1990	22
700	3	2022	47.2641156007492
701	1	2022	298
701	1	1990	318
701	3	1990	14
701	3	2022	26.9999999999999
702	1	2022	1244
702	1	1990	865
702	3	1990	40
702	3	2022	44.7736414429453
703	1	2022	3392
703	1	1990	1806
703	3	1990	61
703	3	2022	67.6764346617864
704	1	2022	110
704	1	1990	112
704	3	1990	9
704	3	2022	8
705	1	2022	301
705	1	1990	194
705	3	1990	23
705	3	2022	9.75155279503105
706	1	2022	549
706	1	1990	419
706	3	1990	8
706	3	2022	20.6377686328303
707	1	2022	428
707	1	1990	328
707	3	1990	5
707	3	2022	22.2046511627908
708	1	2022	471
708	1	1990	483
708	3	1990	15
708	3	2022	30.4102040816327
709	1	2022	459
709	1	1990	398
709	3	1990	13
709	3	2022	24.2950819672131
710	1	2022	152
710	1	1990	164
710	3	1990	7
710	3	2022	5.83636363636364
711	1	2022	2309
711	1	1990	2512
711	3	1990	136
711	3	2022	60.9315269727669
712	1	2022	90
712	1	1990	48
712	3	1990	3
712	3	2022	8
713	1	2022	2367
713	1	1990	1073
713	3	1990	29
713	3	2022	45.5009387775089
714	1	2022	225
714	1	1990	183
714	3	1990	14
714	3	2022	13
715	1	2022	1214
715	1	1990	834
715	3	1990	41
715	3	2022	65
716	1	2022	2133
716	1	1990	612
716	3	1990	9
716	3	2022	19.4644348385911
717	1	2022	137
717	1	1990	147
717	3	1990	8
717	3	2022	9.10344827586204
718	1	2022	417
718	1	1990	351
718	3	1990	15
718	3	2022	27.7276953201612
719	1	2022	214
719	1	1990	219
719	3	1990	10
719	3	2022	19
720	1	2022	3879
720	1	1990	2736
720	3	1990	112
720	3	2022	90.0552934262443
721	1	2022	214
721	1	1990	185
721	3	1990	12
721	3	2022	11.0827067669173
722	1	2022	564
722	1	1990	409
722	3	1990	18
722	3	2022	18.2552934870007
723	1	2022	347
723	1	1990	366
723	3	1990	12
723	3	2022	28.2295081967213
724	1	2022	268
724	1	1990	293
724	3	1990	8
724	3	2022	12.1655172413793
725	1	2022	6665
725	1	1990	5365
725	3	1990	181
725	3	2022	328.875534072268
726	1	2022	335
726	1	1990	260
726	3	1990	20
726	3	2022	22.217821782178
727	1	2022	1988
727	1	1990	1289
727	3	1990	52
727	3	2022	54.0765687426555
728	1	2022	263
728	1	1990	282
728	3	1990	11
728	3	2022	16.8978758169935
729	1	2022	578
729	1	1990	369
729	3	1990	14
729	3	2022	19.0678571428572
730	1	2022	114
730	1	1990	144
730	3	1990	4
730	3	2022	9
731	1	2022	2394
731	1	1990	1272
731	3	1990	28
731	3	2022	33.0955906810336
732	1	2022	1777
732	1	1990	1244
732	3	1990	54
732	3	2022	94.7261708238408
733	1	2022	910
733	1	1990	685
733	3	1990	27
733	3	2022	38.9675741851068
734	1	2022	514
734	1	1990	501
734	3	1990	19
734	3	2022	33
735	1	2022	1885
735	1	1990	899
735	3	1990	35
735	3	2022	57.4180161943319
736	1	2022	2458
736	1	1990	2340
736	3	1990	118
736	3	2022	155.140035239121
737	1	2022	166
737	1	1990	164
737	3	1990	7
737	3	2022	7.0241134751773
738	1	2022	648
738	1	1990	511
738	3	1990	7
738	3	2022	24.4322107707941
739	1	2022	93
739	1	1990	145
739	3	1990	7
739	3	2022	9
740	1	2022	162
740	1	1990	107
740	3	1990	12
740	3	2022	8
741	1	2022	767
741	1	1990	648
741	3	1990	20
741	3	2022	35.2559318398941
742	1	2022	684
742	1	1990	309
742	3	1990	19
742	3	2022	27.5476190476192
743	1	2022	205
743	1	1990	212
743	3	1990	36
743	3	2022	22.6245421245421
744	1	2022	420
744	1	1990	322
744	3	1990	23
744	3	2022	20.9561601474431
745	1	2022	5016
745	1	1990	2603
745	3	1990	38
745	3	2022	144
746	1	2022	919
746	1	1990	465
746	3	1990	11
746	3	2022	24.6420331873419
747	1	2022	3417
747	1	1990	2101
747	3	1990	23
747	3	2022	61.8589400647514
748	1	2022	574
748	1	1990	610
748	3	1990	47
748	3	2022	43.3723777528929
749	1	2022	1118
749	1	1990	1490
749	3	1990	67
749	3	2022	18.2576787608652
750	1	2022	628
750	1	1990	477
750	3	1990	17
750	3	2022	19
751	1	2022	1411
751	1	1990	702
751	3	1990	9
751	3	2022	34.7968749999999
752	1	2022	5531
752	1	1990	3279
752	3	1990	44
752	3	2022	144.473251644904
753	1	2022	25312
753	1	1990	25874
753	3	1990	864
753	3	2022	1397.29325722514
754	1	2022	57
754	1	1990	97
754	3	1990	14
754	3	2022	9.13432835820897
755	1	2022	164
755	1	1990	179
755	3	1990	6
755	3	2022	6.93723196881091
756	1	2022	609
756	1	1990	504
756	3	1990	34
756	3	2022	32
757	1	2022	2427
757	1	1990	1441
757	3	1990	25
757	3	2022	81.9600593878267
758	1	2022	7314
758	1	1990	4891
758	3	1990	236
758	3	2022	333.043287725064
759	1	2022	91
759	1	1990	117
759	3	1990	13
759	3	2022	4
760	1	2022	68
760	1	1990	53
760	3	1990	4
760	3	2022	3.80952380952381
761	1	2022	389
761	1	1990	212
761	3	1990	14
761	3	2022	19.4656989101433
762	1	2022	2532
762	1	1990	1208
762	3	1990	28
762	3	2022	143.562319467013
763	1	2022	275
763	1	1990	207
763	3	1990	26
763	3	2022	9
764	1	2022	213
764	1	1990	215
764	3	1990	21
764	3	2022	8.18403996816845
765	1	2022	503
765	1	1990	536
765	3	1990	35
765	3	2022	40.0757439164631
766	1	2022	3935
766	1	1990	1220
766	3	1990	33
766	3	2022	66
767	1	2022	419
767	1	1990	328
767	3	1990	20
767	3	2022	24.4210526315789
768	1	2022	742
768	1	1990	494
768	3	1990	28
768	3	2022	24.3140238798434
769	1	2022	374
769	1	1990	267
769	3	1990	6
769	3	2022	14.6100888842768
770	1	2022	214
770	1	1990	196
770	3	1990	20
770	3	2022	14.5164400836614
771	1	2022	6861
771	1	1990	6049
771	3	1990	172
771	3	2022	425.248675423138
772	1	2022	191
772	1	1990	137
772	3	1990	7
772	3	2022	8.09265667051135
773	1	2022	782
773	1	1990	561
773	3	1990	37
773	3	2022	67.1472527472526
774	1	2022	83
774	1	1990	83
774	3	1990	5
774	3	2022	18.4301113392721
775	1	2022	296
775	1	1990	230
775	3	1990	15
775	3	2022	16.0969696969698
776	1	2022	772
776	1	1990	610
776	3	1990	28
776	3	2022	37.388357837694
777	1	2022	381
777	1	1990	215
777	3	1990	7
777	3	2022	13.827111740018
778	1	2022	1144
778	1	1990	758
778	3	1990	20
778	3	2022	40.7756651624012
779	1	2022	387
779	1	1990	232
779	3	1990	0
779	3	2022	21.4201924873713
780	1	2022	1874
780	1	1990	951
780	3	1990	40
780	3	2022	50.5785888835409
781	1	2022	1702
781	1	1990	922
781	3	1990	32
781	3	2022	67.8835114368986
782	1	2022	332
782	1	1990	302
782	3	1990	18
782	3	2022	32.2909090909091
783	1	2022	470
783	1	1990	456
783	3	1990	24
783	3	2022	32.3585628569362
784	1	2022	2085
784	1	1990	1024
784	3	1990	20
784	3	2022	37
785	1	2022	1190
785	1	1990	1088
785	3	1990	42
785	3	2022	64.3711438780131
786	1	2022	8248
786	1	1990	6814
786	3	1990	141
786	3	2022	327
787	1	2022	252
787	1	1990	202
787	3	1990	16
787	3	2022	24.2857142857142
788	1	2022	544
788	1	1990	474
788	3	1990	54
788	3	2022	29.2716441309032
789	1	2022	4543
789	1	1990	4623
789	3	1990	182
789	3	2022	238.528705824001
790	1	2022	1505
790	1	1990	1049
790	3	1990	36
790	3	2022	38.1594452904727
791	1	2022	383
791	1	1990	314
791	3	1990	35
791	3	2022	19
792	1	2022	683
792	1	1990	585
792	3	1990	18
792	3	2022	23.9794014645018
793	1	2022	1196
793	1	1990	910
793	3	1990	33
793	3	2022	28
794	1	2022	191
794	1	1990	173
794	3	1990	5
794	3	2022	11
795	1	2022	545
795	1	1990	594
795	3	1990	21
795	3	2022	32.4382809338804
796	1	2022	847
796	1	1990	634
796	3	1990	39
796	3	2022	21.6363636363637
797	1	2022	4030
797	1	1990	3054
797	3	1990	281
797	3	2022	187.413649707511
798	1	2022	771
798	1	1990	538
798	3	1990	25
798	3	2022	24.3085749700375
799	1	2022	1285
799	1	1990	551
799	3	1990	13
799	3	2022	20.1680079010783
800	1	2022	168
800	1	1990	174
800	3	1990	8
800	3	2022	8.2025316455696
801	1	2022	610
801	1	1990	591
801	3	1990	15
801	3	2022	32
802	1	2022	2375
802	1	1990	1166
802	3	1990	24
802	3	2022	65.1296093206054
803	1	2022	244
803	1	1990	175
803	3	1990	9
803	3	2022	10.0613333333333
804	1	2022	159
804	1	1990	144
804	3	1990	11
804	3	2022	11
805	1	2022	578
805	1	1990	387
805	3	1990	4
805	3	2022	20
806	1	2022	240
806	1	1990	256
806	3	1990	22
806	3	2022	19.5108622994653
807	1	2022	203
807	1	1990	323
807	3	1990	19
807	3	2022	22
808	1	2022	2241
808	1	1990	958
808	3	1990	12
808	3	2022	17.1819688424361
809	1	2022	125
809	1	1990	155
809	3	1990	10
809	3	2022	12.2424242424242
810	1	2022	745
810	1	1990	768
810	3	1990	18
810	3	2022	40
811	1	2022	270
811	1	1990	269
811	3	1990	14
811	3	2022	14
812	1	2022	108
812	1	1990	163
812	3	1990	7
812	3	2022	13.5416666666667
813	1	2022	67
813	1	1990	58
813	3	1990	8
813	3	2022	6
814	1	2022	298
814	1	1990	243
814	3	1990	9
814	3	2022	17.0762202280137
815	1	2022	738
815	1	1990	387
815	3	1990	13
815	3	2022	12
816	1	2022	172
816	1	1990	98
816	3	1990	17
816	3	2022	18.4
817	1	2022	657
817	1	1990	404
817	3	1990	12
817	3	2022	8.4666715563658
818	1	2022	1508
818	1	1990	893
818	3	1990	21
818	3	2022	43.97747147215
819	1	2022	1754
819	1	1990	1455
819	3	1990	43
819	3	2022	79.765244607665
820	1	2022	1096
820	1	1990	718
820	3	1990	9
820	3	2022	24.0121300039255
821	1	2022	695
821	1	1990	644
821	3	1990	9
821	3	2022	22.5104709366519
822	1	2022	376
822	1	1990	358
822	3	1990	16
822	3	2022	11.1874158632335
823	1	2022	367
823	1	1990	325
823	3	1990	23
823	3	2022	27.1444096735758
824	1	2022	235
824	1	1990	263
824	3	1990	12
824	3	2022	10.1948051948052
825	1	2022	730
825	1	1990	739
825	3	1990	23
825	3	2022	41.1466200852648
826	1	2022	4050
826	1	1990	3379
826	3	1990	175
826	3	2022	353.909207161127
827	1	2022	103
827	1	1990	96
827	3	1990	13
827	3	2022	1.03916801162604
828	1	2022	827
828	1	1990	824
828	3	1990	31
828	3	2022	36.481426448737
829	1	2022	209
829	1	1990	184
829	3	1990	18
829	3	2022	0
830	1	2022	126
830	1	1990	111
830	3	1990	1
830	3	2022	7.12124849939976
831	1	2022	2857
831	1	1990	3364
831	3	1990	161
831	3	2022	351.625262365601
832	1	2022	1206
832	1	1990	1444
832	3	1990	68
832	3	2022	144.472979266429
833	1	2022	207
833	1	1990	225
833	3	1990	21
833	3	2022	24
834	1	2022	860
834	1	1990	788
834	3	1990	36
834	3	2022	63
835	1	2022	219
835	1	1990	250
835	3	1990	13
835	3	2022	23.1345207803223
836	1	2022	712
836	1	1990	682
836	3	1990	67
836	3	2022	46.6907178965194
837	1	2022	307
837	1	1990	317
837	3	1990	14
837	3	2022	16.2773892773893
838	1	2022	82
838	1	1990	132
838	3	1990	11
838	3	2022	1.01980198019802
839	1	2022	152
839	1	1990	311
839	3	1990	35
839	3	2022	20.1129943502825
840	1	2022	1310
840	1	1990	1473
840	3	1990	90
840	3	2022	162
841	1	2022	115
841	1	1990	134
841	3	1990	6
841	3	2022	8.00000000000004
842	1	2022	100
842	1	1990	72
842	3	1990	11
842	3	2022	3
843	1	2022	222
843	1	1990	310
843	3	1990	11
843	3	2022	33
844	1	2022	1281
844	1	1990	1068
844	3	1990	58
844	3	2022	126.792590424871
845	1	2022	487
845	1	1990	811
845	3	1990	19
845	3	2022	29.5840428239506
846	1	2022	356
846	1	1990	382
846	3	1990	17
846	3	2022	23.2816326530611
847	1	2022	246
847	1	1990	211
847	3	1990	8
847	3	2022	10.8249926513815
848	1	2022	114
848	1	1990	136
848	3	1990	11
848	3	2022	17
849	1	2022	2487
849	1	1990	4208
849	3	1990	118
849	3	2022	568
850	1	2022	276
850	1	1990	225
850	3	1990	15
850	3	2022	37
851	1	2022	967
851	1	1990	817
851	3	1990	14
851	3	2022	35.3531504065041
852	1	2022	46769
852	1	1990	49765
852	3	1990	1691
852	3	2022	3223.32058188779
853	1	2022	741
853	1	1990	1063
853	3	1990	72
853	3	2022	35.8667596791361
854	1	2022	208
854	1	1990	293
854	3	1990	33
854	3	2022	29
855	1	2022	528
855	1	1990	364
855	3	1990	22
855	3	2022	31.9996733660646
856	1	2022	1422
856	1	1990	1376
856	3	1990	136
856	3	2022	110.856592604704
857	1	2022	1158
857	1	1990	1190
857	3	1990	47
857	3	2022	24.9713958810069
858	1	2022	1492
858	1	1990	1569
858	3	1990	36
858	3	2022	69.729764460277
859	1	2022	230
859	1	1990	221
859	3	1990	11
859	3	2022	20.1548206250309
860	1	2022	150
860	1	1990	167
860	3	1990	6
860	3	2022	16.8969696969696
861	1	2022	421
861	1	1990	511
861	3	1990	15
861	3	2022	46.8304529392865
862	1	2022	615
862	1	1990	520
862	3	1990	8
862	3	2022	31.4024494602014
863	1	2022	460
863	1	1990	345
863	3	1990	6
863	3	2022	4.22184359982522
864	1	2022	260
864	1	1990	179
864	3	1990	17
864	3	2022	17
865	1	2022	196
865	1	1990	219
865	3	1990	2
865	3	2022	5
866	1	2022	113
866	1	1990	137
866	3	1990	5
866	3	2022	0
867	1	2022	377
867	1	1990	272
867	3	1990	23
867	3	2022	17.9208333333334
868	1	2022	348
868	1	1990	300
868	3	1990	20
868	3	2022	20.6818181818182
869	1	2022	747
869	1	1990	455
869	3	1990	21
869	3	2022	39.8974389862884
870	1	2022	413
870	1	1990	325
870	3	1990	3
870	3	2022	23.7539374524534
871	1	2022	166
871	1	1990	188
871	3	1990	25
871	3	2022	20.2911821705427
872	1	2022	49
872	1	1990	34
872	3	1990	8
872	3	2022	3
873	1	2022	272
873	1	1990	149
873	3	1990	4
873	3	2022	14.220582626422
874	1	2022	214
874	1	1990	203
874	3	1990	9
874	3	2022	16.3265306122449
875	1	2022	277
875	1	1990	191
875	3	1990	9
875	3	2022	18
876	1	2022	411
876	1	1990	367
876	3	1990	20
876	3	2022	30.0840859545314
877	1	2022	478
877	1	1990	381
877	3	1990	23
877	3	2022	32.7253134035822
878	1	2022	385
878	1	1990	270
878	3	1990	21
878	3	2022	25
879	1	2022	384
879	1	1990	362
879	3	1990	25
879	3	2022	20.0766283524904
880	1	2022	648
880	1	1990	678
880	3	1990	64
880	3	2022	68
881	1	2022	1283
881	1	1990	1423
881	3	1990	51
881	3	2022	60.8662209026478
882	1	2022	1173
882	1	1990	1145
882	3	1990	65
882	3	2022	75
883	1	2022	3042
883	1	1990	1962
883	3	1990	65
883	3	2022	74
884	1	2022	71
884	1	1990	89
884	3	1990	3
884	3	2022	2.09122807017543
885	1	2022	64
885	1	1990	59
885	3	1990	2
885	3	2022	8
886	1	2022	1730
886	1	1990	1560
886	3	1990	27
886	3	2022	91.3314247365091
887	1	2022	215
887	1	1990	203
887	3	1990	15
887	3	2022	12.7751285647499
888	1	2022	707
888	1	1990	569
888	3	1990	42
888	3	2022	30.7105820402023
889	1	2022	144
889	1	1990	149
889	3	1990	22
889	3	2022	11.2037037037037
890	1	2022	309
890	1	1990	304
890	3	1990	30
890	3	2022	25.1046025104602
891	1	2022	233
891	1	1990	289
891	3	1990	20
891	3	2022	16
892	1	2022	2714
892	1	1990	2050
892	3	1990	148
892	3	2022	152.446183953032
893	1	2022	4336
893	1	1990	4487
893	3	1990	116
893	3	2022	465.657837209223
894	1	2022	51
894	1	1990	59
894	3	1990	15
894	3	2022	3
895	1	2022	381
895	1	1990	338
895	3	1990	26
895	3	2022	12
896	1	2022	409
896	1	1990	342
896	3	1990	22
896	3	2022	27.2076923076922
897	1	2022	136
897	1	1990	109
897	3	1990	7
897	3	2022	3
898	1	2022	408
898	1	1990	340
898	3	1990	16
898	3	2022	21.25
899	1	2022	488
899	1	1990	528
899	3	1990	30
899	3	2022	52.1350649350648
900	1	2022	684
900	1	1990	794
900	3	1990	22
900	3	2022	56.2302133281638
901	1	2022	510
901	1	1990	513
901	3	1990	28
901	3	2022	46.7417447199264
902	1	2022	1121
902	1	1990	902
902	3	1990	19
902	3	2022	29.8578816083993
903	1	2022	112
903	1	1990	119
903	3	1990	6
903	3	2022	15
904	1	2022	258
904	1	1990	344
904	3	1990	19
904	3	2022	29.079561042524
905	1	2022	765
905	1	1990	655
905	3	1990	13
905	3	2022	33.3451882845188
906	1	2022	327
906	1	1990	413
906	3	1990	30
906	3	2022	25.7396886798123
907	1	2022	85
907	1	1990	127
907	3	1990	7
907	3	2022	28.4745762711864
908	1	2022	48
908	1	1990	70
908	3	1990	6
908	3	2022	4.96666666666667
909	1	2022	184
909	1	1990	177
909	3	1990	4
909	3	2022	7.84508359556843
910	1	2022	99
910	1	1990	80
910	3	1990	2
910	3	2022	4
911	1	2022	316
911	1	1990	309
911	3	1990	11
911	3	2022	19.2998246639391
912	1	2022	951
912	1	1990	604
912	3	1990	5
912	3	2022	59.6316916488221
913	1	2022	1147
913	1	1990	1108
913	3	1990	63
913	3	2022	28
914	1	2022	136
914	1	1990	185
914	3	1990	25
914	3	2022	10.1542451542451
915	1	2022	405
915	1	1990	408
915	3	1990	10
915	3	2022	18.2663863313907
916	1	2022	135
916	1	1990	159
916	3	1990	4
916	3	2022	8.88157894736842
917	1	2022	935
917	1	1990	917
917	3	1990	29
917	3	2022	66
918	1	2022	224
918	1	1990	257
918	3	1990	9
918	3	2022	18.3948997755591
919	1	2022	1189
919	1	1990	968
919	3	1990	69
919	3	2022	120
920	1	2022	1565
920	1	1990	1713
920	3	1990	89
920	3	2022	73.6233521657252
921	1	2022	281
921	1	1990	326
921	3	1990	9
921	3	2022	9
922	1	2022	66
922	1	1990	82
922	3	1990	7
922	3	2022	13.5
923	1	2022	124
923	1	1990	106
923	3	1990	11
923	3	2022	2
924	1	2022	504
924	1	1990	431
924	3	1990	18
924	3	2022	18.6188148925933
925	1	2022	386
925	1	1990	514
925	3	1990	12
925	3	2022	23.5633737931359
926	1	2022	1654
926	1	1990	1322
926	3	1990	41
926	3	2022	63
927	1	2022	79
927	1	1990	106
927	3	1990	1
927	3	2022	10
928	1	2022	226
928	1	1990	167
928	3	1990	27
928	3	2022	14.1342249820874
929	1	2022	114
929	1	1990	123
929	3	1990	5
929	3	2022	18
930	1	2022	102
930	1	1990	96
930	3	1990	7
930	3	2022	19
931	1	2022	115
931	1	1990	106
931	3	1990	13
931	3	2022	13.5
932	1	2022	657
932	1	1990	603
932	3	1990	41
932	3	2022	76.7333396331421
933	1	2022	162
933	1	1990	169
933	3	1990	4
933	3	2022	9.09375000000003
934	1	2022	293
934	1	1990	284
934	3	1990	35
934	3	2022	25.4044459962756
935	1	2022	266
935	1	1990	205
935	3	1990	12
935	3	2022	3.33846153846153
936	1	2022	688
936	1	1990	475
936	3	1990	25
936	3	2022	45.9547461335353
937	1	2022	819
937	1	1990	855
937	3	1990	76
937	3	2022	69.3863562456812
938	1	2022	152
938	1	1990	127
938	3	1990	13
938	3	2022	15.5363952490629
939	1	2022	244
939	1	1990	194
939	3	1990	9
939	3	2022	4
940	1	2022	2253
940	1	1990	2248
940	3	1990	173
940	3	2022	265.147677146529
941	1	2022	168
941	1	1990	174
941	3	1990	27
941	3	2022	10
942	1	2022	7995
942	1	1990	6828
942	3	1990	91
942	3	2022	353.375013876734
943	1	2022	1542
943	1	1990	1341
943	3	1990	47
943	3	2022	31
944	1	2022	853
944	1	1990	787
944	3	1990	76
944	3	2022	43
945	1	2022	176
945	1	1990	226
945	3	1990	18
945	3	2022	13.311377245509
946	1	2022	284
946	1	1990	233
946	3	1990	17
946	3	2022	27.8477166486876
947	1	2022	670
947	1	1990	669
947	3	1990	42
947	3	2022	41.1590925333822
948	1	2022	446
948	1	1990	397
948	3	1990	31
948	3	2022	25.706016194874
949	1	2022	538
949	1	1990	622
949	3	1990	28
949	3	2022	78.8288995603145
950	1	2022	136
950	1	1990	85
950	3	1990	11
950	3	2022	4.056338028169
951	1	2022	232
951	1	1990	323
951	3	1990	7
951	3	2022	23.8064197530864
952	1	2022	726
952	1	1990	948
952	3	1990	39
952	3	2022	100.971121212121
953	1	2022	340
953	1	1990	263
953	3	1990	15
953	3	2022	16.0820512820514
954	1	2022	2326
954	1	1990	2796
954	3	1990	133
954	3	2022	249.94803859179
955	1	2022	63
955	1	1990	40
955	3	1990	2
955	3	2022	1.05207646671062
956	1	2022	1290
956	1	1990	1124
956	3	1990	45
956	3	2022	78.4241160153398
957	1	2022	77
957	1	1990	76
957	3	1990	11
957	3	2022	1.96078431372549
958	1	2022	630
958	1	1990	703
958	3	1990	29
958	3	2022	45.2675667425101
959	1	2022	292
959	1	1990	515
959	3	1990	7
959	3	2022	12.0540540540541
960	1	2022	133
960	1	1990	143
960	3	1990	15
960	3	2022	19
961	1	2022	634
961	1	1990	658
961	3	1990	25
961	3	2022	43.6921461277179
962	1	2022	251
962	1	1990	216
962	3	1990	11
962	3	2022	28.9714285714284
963	1	2022	430
963	1	1990	383
963	3	1990	30
963	3	2022	28.6329113924052
964	1	2022	2318
964	1	1990	2187
964	3	1990	49
964	3	2022	130.354518498258
965	1	2022	641
965	1	1990	413
965	3	1990	30
965	3	2022	34
966	1	2022	1597
966	1	1990	1829
966	3	1990	55
966	3	2022	225.527364932991
967	1	2022	203
967	1	1990	216
967	3	1990	16
967	3	2022	8
968	1	2022	351
968	1	1990	276
968	3	1990	5
968	3	2022	19.4094827586206
969	1	2022	945
969	1	1990	648
969	3	1990	32
969	3	2022	44.29010989011
970	1	2022	478
970	1	1990	353
970	3	1990	9
970	3	2022	57
971	1	2022	3737
971	1	1990	3163
971	3	1990	99
971	3	2022	184
972	1	2022	321
972	1	1990	323
972	3	1990	32
972	3	2022	19.1532258064516
973	1	2022	256
973	1	1990	234
973	3	1990	11
973	3	2022	25.1470588235295
974	1	2022	167
974	1	1990	115
974	3	1990	8
974	3	2022	5.66292397660817
975	1	2022	220
975	1	1990	256
975	3	1990	5
975	3	2022	14
976	1	2022	167
976	1	1990	139
976	3	1990	20
976	3	2022	8.9741544823512
977	1	2022	84
977	1	1990	76
977	3	1990	12
977	3	2022	9
978	1	2022	199
978	1	1990	214
978	3	1990	24
978	3	2022	17.4637236494634
979	1	2022	431
979	1	1990	404
979	3	1990	21
979	3	2022	0
980	1	2022	1254
980	1	1990	870
980	3	1990	39
980	3	2022	75.2467126668699
981	1	2022	358
981	1	1990	249
981	3	1990	15
981	3	2022	32
982	1	2022	831
982	1	1990	1012
982	3	1990	41
982	3	2022	40.3488869795152
983	1	2022	127
983	1	1990	106
983	3	1990	11
983	3	2022	0
984	1	2022	93
984	1	1990	82
984	3	1990	10
984	3	2022	8.52941176470588
985	1	2022	41
985	1	1990	38
985	3	1990	5
985	3	2022	8.14035087719296
986	1	2022	86
986	1	1990	120
986	3	1990	7
986	3	2022	8.07843137254902
987	1	2022	293
987	1	1990	300
987	3	1990	13
987	3	2022	9
988	1	2022	235
988	1	1990	191
988	3	1990	8
988	3	2022	8
989	1	2022	181
989	1	1990	172
989	3	1990	12
989	3	2022	6.51629072681703
990	1	2022	116
990	1	1990	131
990	3	1990	12
990	3	2022	7
991	1	2022	306
991	1	1990	383
991	3	1990	32
991	3	2022	31.3842975206613
992	1	2022	127
992	1	1990	186
992	3	1990	16
992	3	2022	14.1407035175879
993	1	2022	98
993	1	1990	79
993	3	1990	5
993	3	2022	12.3564356435644
994	1	2022	1087
994	1	1990	1056
994	3	1990	38
994	3	2022	82.3319873072934
995	1	2022	175
995	1	1990	200
995	3	1990	7
995	3	2022	20.0344827586207
996	1	2022	1000
996	1	1990	634
996	3	1990	19
996	3	2022	7.13001740776425
997	1	2022	210
997	1	1990	163
997	3	1990	1
997	3	2022	21.5117577895356
998	1	2022	705
998	1	1990	566
998	3	1990	24
998	3	2022	56.9411764705879
999	1	2022	417
999	1	1990	448
999	3	1990	28
999	3	2022	35.9999999999999
1000	1	2022	769
1000	1	1990	707
1000	3	1990	33
1000	3	2022	52.0464509035938
1001	1	2022	137
1001	1	1990	140
1001	3	1990	9
1001	3	2022	5.46875
1002	1	2022	226
1002	1	1990	188
1002	3	1990	32
1002	3	2022	17.5483870967742
1003	1	2022	404
1003	1	1990	327
1003	3	1990	26
1003	3	2022	53.2136007044269
1004	1	2022	413
1004	1	1990	270
1004	3	1990	8
1004	3	2022	22.2361496233747
1005	1	2022	40
1005	1	1990	74
1005	3	1990	4
1005	3	2022	5.23809523809524
1006	1	2022	188
1006	1	1990	176
1006	3	1990	18
1006	3	2022	18.3792177090049
1007	1	2022	678
1007	1	1990	425
1007	3	1990	27
1007	3	2022	15.0099846607202
1008	1	2022	480
1008	1	1990	513
1008	3	1990	54
1008	3	2022	65.4374557752825
1009	1	2022	179
1009	1	1990	230
1009	3	1990	19
1009	3	2022	5.16895089928799
1010	1	2022	1383
1010	1	1990	908
1010	3	1990	37
1010	3	2022	52
1011	1	2022	393
1011	1	1990	242
1011	3	1990	9
1011	3	2022	5.08692810457517
1012	1	2022	458
1012	1	1990	276
1012	3	1990	25
1012	3	2022	33.3822393822394
1013	1	2022	111
1013	1	1990	133
1013	3	1990	8
1013	3	2022	7.74666666666667
1014	1	2022	245
1014	1	1990	198
1014	3	1990	20
1014	3	2022	24.8762376237624
1015	1	2022	87
1015	1	1990	62
1015	3	1990	0
1015	3	2022	6.08695652173914
1016	1	2022	592
1016	1	1990	515
1016	3	1990	13
1016	3	2022	43.0872580951737
1017	1	2022	2060
1017	1	1990	1568
1017	3	1990	44
1017	3	2022	99.2954155217802
1018	1	2022	1793
1018	1	1990	1605
1018	3	1990	41
1018	3	2022	89.450766965044
1019	1	2022	263
1019	1	1990	283
1019	3	1990	7
1019	3	2022	25.5464480874318
1020	1	2022	91
1020	1	1990	135
1020	3	1990	8
1020	3	2022	2
1021	1	2022	101
1021	1	1990	99
1021	3	1990	8
1021	3	2022	6
1022	1	2022	1149
1022	1	1990	914
1022	3	1990	11
1022	3	2022	63.8499156829683
1023	1	2022	191
1023	1	1990	201
1023	3	1990	6
1023	3	2022	17.5870900076278
1024	1	2022	173
1024	1	1990	180
1024	3	1990	21
1024	3	2022	9.84224632876752
1025	1	2022	65
1025	1	1990	88
1025	3	1990	3
1025	3	2022	5.43859649122807
1026	1	2022	997
1026	1	1990	807
1026	3	1990	21
1026	3	2022	47.1204615600642
1027	1	2022	95
1027	1	1990	103
1027	3	1990	5
1027	3	2022	8.88888888888889
1028	1	2022	599
1028	1	1990	616
1028	3	1990	35
1028	3	2022	64
1029	1	2022	435
1029	1	1990	584
1029	3	1990	47
1029	3	2022	50.8797169811321
1030	1	2022	116
1030	1	1990	168
1030	3	1990	7
1030	3	2022	4.04123711340208
1031	1	2022	239
1031	1	1990	322
1031	3	1990	46
1031	3	2022	19
1032	1	2022	173
1032	1	1990	157
1032	3	1990	7
1032	3	2022	7.89435774309724
1033	1	2022	60
1033	1	1990	53
1033	3	1990	14
1033	3	2022	9.00202020202021
1034	1	2022	485
1034	1	1990	487
1034	3	1990	13
1034	3	2022	50.1385041551245
1035	1	2022	105
1035	1	1990	98
1035	3	1990	6
1035	3	2022	2
1036	1	2022	345
1036	1	1990	362
1036	3	1990	40
1036	3	2022	31.9520194986073
1037	1	2022	193
1037	1	1990	156
1037	3	1990	22
1037	3	2022	18.4574220788462
1038	1	2022	109
1038	1	1990	114
1038	3	1990	24
1038	3	2022	27
1039	1	2022	1331
1039	1	1990	1049
1039	3	1990	14
1039	3	2022	48.898918971954
1040	1	2022	64
1040	1	1990	65
1040	3	1990	2
1040	3	2022	8
1041	1	2022	5006
1041	1	1990	3478
1041	3	1990	56
1041	3	2022	136.180577708249
1042	1	2022	175
1042	1	1990	173
1042	3	1990	5
1042	3	2022	5.10174017793648
1043	1	2022	81
1043	1	1990	88
1043	3	1990	2
1043	3	2022	1.9375
1044	1	2022	293
1044	1	1990	185
1044	3	1990	11
1044	3	2022	5.96610169491526
1045	1	2022	486
1045	1	1990	422
1045	3	1990	16
1045	3	2022	34.5014139444175
1046	1	2022	237
1046	1	1990	236
1046	3	1990	23
1046	3	2022	3
1047	1	2022	479
1047	1	1990	412
1047	3	1990	17
1047	3	2022	32.207792207792
1048	1	2022	1038
1048	1	1990	1126
1048	3	1990	51
1048	3	2022	122.502057613169
1049	1	2022	236
1049	1	1990	221
1049	3	1990	13
1049	3	2022	21.6363636363637
1050	1	2022	294
1050	1	1990	331
1050	3	1990	23
1050	3	2022	24.5767350928641
1051	1	2022	317
1051	1	1990	292
1051	3	1990	10
1051	3	2022	23.9043927648579
1052	1	2022	266
1052	1	1990	281
1052	3	1990	31
1052	3	2022	5.359256820308
1053	1	2022	451
1053	1	1990	323
1053	3	1990	14
1053	3	2022	32.9060913634907
1054	1	2022	846
1054	1	1990	946
1054	3	1990	29
1054	3	2022	63.0753922694224
1055	1	2022	78
1055	1	1990	71
1055	3	1990	6
1055	3	2022	5
1056	1	2022	132
1056	1	1990	139
1056	3	1990	0
1056	3	2022	7
1057	1	2022	1888
1057	1	1990	1407
1057	3	1990	32
1057	3	2022	36.5515487538593
1058	1	2022	194
1058	1	1990	142
1058	3	1990	3
1058	3	2022	22
1059	1	2022	1367
1059	1	1990	1216
1059	3	1990	108
1059	3	2022	93.3835330848242
1060	1	2022	329
1060	1	1990	423
1060	3	1990	24
1060	3	2022	45
1061	1	2022	679
1061	1	1990	729
1061	3	1990	37
1061	3	2022	53.7521380295333
1062	1	2022	274
1062	1	1990	275
1062	3	1990	11
1062	3	2022	20.093023255814
1063	1	2022	867
1063	1	1990	735
1063	3	1990	37
1063	3	2022	67
1064	1	2022	201
1064	1	1990	253
1064	3	1990	19
1064	3	2022	2.85525199389106
1065	1	2022	202
1065	1	1990	269
1065	3	1990	23
1065	3	2022	38.9999999999998
1066	1	2022	1814
1066	1	1990	1540
1066	3	1990	42
1066	3	2022	104.182782901504
1067	1	2022	344
1067	1	1990	342
1067	3	1990	30
1067	3	2022	38.9052227783203
1068	1	2022	273
1068	1	1990	308
1068	3	1990	21
1068	3	2022	37
1069	1	2022	568
1069	1	1990	772
1069	3	1990	28
1069	3	2022	52
1070	1	2022	229
1070	1	1990	257
1070	3	1990	33
1070	3	2022	17.2253193027553
1071	1	2022	237
1071	1	1990	199
1071	3	1990	16
1071	3	2022	2.14528110094612
1072	1	2022	773
1072	1	1990	972
1072	3	1990	15
1072	3	2022	56
1073	1	2022	143
1073	1	1990	229
1073	3	1990	17
1073	3	2022	31.5949367088608
1074	1	2022	297
1074	1	1990	289
1074	3	1990	13
1074	3	2022	18.3929495031986
1075	1	2022	520
1075	1	1990	569
1075	3	1990	47
1075	3	2022	78.7276304351142
1076	1	2022	338
1076	1	1990	403
1076	3	1990	48
1076	3	2022	46.0086037764226
1077	1	2022	104
1077	1	1990	92
1077	3	1990	10
1077	3	2022	11.4583333333334
1078	1	2022	35
1078	1	1990	56
1078	3	1990	6
1078	3	2022	3
1079	1	2022	1258
1079	1	1990	1520
1079	3	1990	77
1079	3	2022	170.951219512195
1080	1	2022	541
1080	1	1990	528
1080	3	1990	23
1080	3	2022	23.3961686451085
1081	1	2022	266
1081	1	1990	263
1081	3	1990	13
1081	3	2022	12
1082	1	2022	13602
1082	1	1990	17164
1082	3	1990	1187
1082	3	2022	1387.56940485788
1083	1	2022	803
1083	1	1990	740
1083	3	1990	31
1083	3	2022	54.7335831300106
1084	1	2022	4271
1084	1	1990	2762
1084	3	1990	40
1084	3	2022	100
1085	1	2022	9174
1085	1	1990	11448
1085	3	1990	553
1085	3	2022	985.851493931124
1086	1	2022	2806
1086	1	1990	2813
1086	3	1990	202
1086	3	2022	319.922298015853
1087	1	2022	151
1087	1	1990	124
1087	3	1990	9
1087	3	2022	18
1088	1	2022	2436
1088	1	1990	1851
1088	3	1990	28
1088	3	2022	83.1216150275302
1089	1	2022	409
1089	1	1990	280
1089	3	1990	10
1089	3	2022	20.3960396039604
1090	1	2022	174
1090	1	1990	181
1090	3	1990	22
1090	3	2022	14.0809248554913
1091	1	2022	74
1091	1	1990	80
1091	3	1990	5
1091	3	2022	6.375
1092	1	2022	82
1092	1	1990	71
1092	3	1990	0
1092	3	2022	7
1093	1	2022	85
1093	1	1990	133
1093	3	1990	17
1093	3	2022	8.90627276455861
1094	1	2022	1295
1094	1	1990	1210
1094	3	1990	45
1094	3	2022	65.1469752683441
1095	1	2022	529
1095	1	1990	582
1095	3	1990	45
1095	3	2022	52.3970501859947
1096	1	2022	239
1096	1	1990	244
1096	3	1990	6
1096	3	2022	9.75973228417673
1097	1	2022	1243
1097	1	1990	1026
1097	3	1990	76
1097	3	2022	72.7494239631332
1098	1	2022	696
1098	1	1990	608
1098	3	1990	36
1098	3	2022	37
1099	1	2022	1442
1099	1	1990	1481
1099	3	1990	88
1099	3	2022	216.294431479063
1100	1	2022	1028
1100	1	1990	982
1100	3	1990	63
1100	3	2022	82.2897526501763
1101	1	2022	141
1101	1	1990	169
1101	3	1990	19
1101	3	2022	10.9266666666667
1102	1	2022	549
1102	1	1990	519
1102	3	1990	52
1102	3	2022	58.4055944055942
1103	1	2022	196
1103	1	1990	167
1103	3	1990	20
1103	3	2022	33.7235772357724
1104	1	2022	205
1104	1	1990	269
1104	3	1990	27
1104	3	2022	23
1105	1	2022	236
1105	1	1990	247
1105	3	1990	27
1105	3	2022	12.5
1106	1	2022	3036
1106	1	1990	5097
1106	3	1990	394
1106	3	2022	747
1107	1	2022	92
1107	1	1990	124
1107	3	1990	17
1107	3	2022	17.0623936471923
1108	1	2022	117
1108	1	1990	146
1108	3	1990	7
1108	3	2022	17
1109	1	2022	163
1109	1	1990	191
1109	3	1990	4
1109	3	2022	15.9992283950617
1110	1	2022	116
1110	1	1990	144
1110	3	1990	16
1110	3	2022	14.2456140350877
1111	1	2022	1153
1111	1	1990	1536
1111	3	1990	107
1111	3	2022	152.308781903257
1112	1	2022	116
1112	1	1990	133
1112	3	1990	10
1112	3	2022	12.5952380952381
1113	1	2022	803
1113	1	1990	1019
1113	3	1990	48
1113	3	2022	71.0026168362083
1114	1	2022	181
1114	1	1990	149
1114	3	1990	16
1114	3	2022	3.02189781021897
1115	1	2022	167
1115	1	1990	224
1115	3	1990	26
1115	3	2022	31.1856287425151
1116	1	2022	229
1116	1	1990	303
1116	3	1990	41
1116	3	2022	20.5138697619516
1117	1	2022	30
1117	1	1990	41
1117	3	1990	3
1117	3	2022	4
1118	1	2022	357
1118	1	1990	425
1118	3	1990	25
1118	3	2022	44
1119	1	2022	767
1119	1	1990	837
1119	3	1990	103
1119	3	2022	113.586864275621
1120	1	2022	386
1120	1	1990	525
1120	3	1990	45
1120	3	2022	62.5422740524781
1121	1	2022	532
1121	1	1990	495
1121	3	1990	13
1121	3	2022	13.1823925667829
1122	1	2022	1354
1122	1	1990	1387
1122	3	1990	99
1122	3	2022	122.523387995975
1123	1	2022	371
1123	1	1990	343
1123	3	1990	29
1123	3	2022	35
1124	1	2022	226
1124	1	1990	249
1124	3	1990	26
1124	3	2022	13.0646766169154
1125	1	2022	117
1125	1	1990	80
1125	3	1990	8
1125	3	2022	27
1126	1	2022	233
1126	1	1990	278
1126	3	1990	41
1126	3	2022	55.1157024793387
1127	1	2022	2408
1127	1	1990	3385
1127	3	1990	129
1127	3	2022	317.811345422972
1128	1	2022	1239
1128	1	1990	1652
1128	3	1990	113
1128	3	2022	195.920012851091
1129	1	2022	687
1129	1	1990	899
1129	3	1990	47
1129	3	2022	97.5470271941023
1130	1	2022	452
1130	1	1990	348
1130	3	1990	17
1130	3	2022	20.3551673944686
1131	1	2022	31
1131	1	1990	32
1131	3	1990	3
1131	3	2022	3
1132	1	2022	713
1132	1	1990	756
1132	3	1990	44
1132	3	2022	56.0273172504611
1133	1	2022	1045
1133	1	1990	1139
1133	3	1990	71
1133	3	2022	151
1134	1	2022	75
1134	1	1990	113
1134	3	1990	10
1134	3	2022	9.80392156862745
1135	1	2022	259
1135	1	1990	239
1135	3	1990	29
1135	3	2022	41.6507936507936
1136	1	2022	532
1136	1	1990	589
1136	3	1990	44
1136	3	2022	100.859100300866
1137	1	2022	159
1137	1	1990	162
1137	3	1990	22
1137	3	2022	18.3461538461539
1138	1	2022	251
1138	1	1990	340
1138	3	1990	55
1138	3	2022	43.5977961432507
1139	1	2022	125
1139	1	1990	135
1139	3	1990	13
1139	3	2022	14.76
1140	1	2022	97
1140	1	1990	113
1140	3	1990	18
1140	3	2022	15
1141	1	2022	86
1141	1	1990	84
1141	3	1990	11
1141	3	2022	10
1142	1	2022	827
1142	1	1990	1105
1142	3	1990	64
1142	3	2022	145.814835318954
1143	1	2022	79
1143	1	1990	116
1143	3	1990	9
1143	3	2022	18
1144	1	2022	243
1144	1	1990	266
1144	3	1990	28
1144	3	2022	32.1343062605753
1145	1	2022	480
1145	1	1990	438
1145	3	1990	47
1145	3	2022	27.2149828767123
1146	1	2022	255
1146	1	1990	202
1146	3	1990	36
1146	3	2022	36
1147	1	2022	118
1147	1	1990	151
1147	3	1990	12
1147	3	2022	19
1148	1	2022	77
1148	1	1990	94
1148	3	1990	6
1148	3	2022	20.2631578947368
1149	1	2022	444
1149	1	1990	310
1149	3	1990	18
1149	3	2022	19.2394957983194
1150	1	2022	206
1150	1	1990	204
1150	3	1990	11
1150	3	2022	21.2957746478872
1151	1	2022	194
1151	1	1990	281
1151	3	1990	23
1151	3	2022	17
1152	1	2022	29
1152	1	1990	35
1152	3	1990	4
1152	3	2022	6.80359147025814
1153	1	2022	310
1153	1	1990	375
1153	3	1990	42
1153	3	2022	36.8556453861165
1154	1	2022	545
1154	1	1990	558
1154	3	1990	98
1154	3	2022	88.900798339554
1155	1	2022	105
1155	1	1990	104
1155	3	1990	18
1155	3	2022	7
1156	1	2022	97
1156	1	1990	105
1156	3	1990	5
1156	3	2022	8.76190476190476
1157	1	2022	138
1157	1	1990	144
1157	3	1990	11
1157	3	2022	17
1158	1	2022	736
1158	1	1990	794
1158	3	1990	62
1158	3	2022	104.188497918671
1159	1	2022	560
1159	1	1990	631
1159	3	1990	54
1159	3	2022	98.915887850467
1160	1	2022	151
1160	1	1990	171
1160	3	1990	21
1160	3	2022	21
1161	1	2022	653
1161	1	1990	752
1161	3	1990	82
1161	3	2022	142.474123539232
1162	1	2022	288
1162	1	1990	347
1162	3	1990	28
1162	3	2022	60.4979253112033
1163	1	2022	192
1163	1	1990	216
1163	3	1990	29
1163	3	2022	24.6672248418631
1164	1	2022	737
1164	1	1990	1057
1164	3	1990	63
1164	3	2022	148.623431152344
1165	1	2022	514
1165	1	1990	552
1165	3	1990	72
1165	3	2022	65.8141962421713
1166	1	2022	389
1166	1	1990	674
1166	3	1990	52
1166	3	2022	84
1167	1	2022	433
1167	1	1990	636
1167	3	1990	87
1167	3	2022	72.8859194540717
1168	1	2022	187
1168	1	1990	202
1168	3	1990	28
1168	3	2022	20.9621254162042
1169	1	2022	232
1169	1	1990	246
1169	3	1990	34
1169	3	2022	23.3892063492063
1170	1	2022	405
1170	1	1990	455
1170	3	1990	59
1170	3	2022	83
1171	1	2022	188
1171	1	1990	197
1171	3	1990	24
1171	3	2022	39
1172	1	2022	1086
1172	1	1990	1203
1172	3	1990	84
1172	3	2022	130.946250326008
1173	1	2022	1285
1173	1	1990	1716
1173	3	1990	81
1173	3	2022	222.429505031295
1174	1	2022	448
1174	1	1990	391
1174	3	1990	15
1174	3	2022	15
1175	1	2022	189
1175	1	1990	169
1175	3	1990	21
1175	3	2022	16.6878620344459
1176	1	2022	1552
1176	1	1990	1985
1176	3	1990	129
1176	3	2022	234.466106388722
1177	1	2022	108
1177	1	1990	105
1177	3	1990	18
1177	3	2022	0
1178	1	2022	300
1178	1	1990	364
1178	3	1990	30
1178	3	2022	35
1179	1	2022	307
1179	1	1990	255
1179	3	1990	17
1179	3	2022	13
1180	1	2022	255
1180	1	1990	279
1180	3	1990	26
1180	3	2022	15.5855155482815
1181	1	2022	143
1181	1	1990	163
1181	3	1990	46
1181	3	2022	31
1182	1	2022	241
1182	1	1990	239
1182	3	1990	39
1182	3	2022	14.9158660564894
1183	1	2022	501
1183	1	1990	735
1183	3	1990	61
1183	3	2022	87.4252410754664
1184	1	2022	113
1184	1	1990	124
1184	3	1990	10
1184	3	2022	13
1185	1	2022	724
1185	1	1990	775
1185	3	1990	60
1185	3	2022	61.4571428571428
1186	1	2022	371
1186	1	1990	367
1186	3	1990	16
1186	3	2022	65.6447923674391
1187	1	2022	179
1187	1	1990	214
1187	3	1990	24
1187	3	2022	5.08693309824664
1188	1	2022	644
1188	1	1990	605
1188	3	1990	57
1188	3	2022	88.2603796480887
1189	1	2022	1565
1189	1	1990	1370
1189	3	1990	73
1189	3	2022	143.737568990869
1190	1	2022	1182
1190	1	1990	1323
1190	3	1990	76
1190	3	2022	114
1191	1	2022	12814
1191	1	1990	14706
1191	3	1990	617
1191	3	2022	1154.76249026002
1192	1	2022	292
1192	1	1990	287
1192	3	1990	55
1192	3	2022	40.0222388805598
1193	1	2022	94
1193	1	1990	100
1193	3	1990	16
1193	3	2022	30.962962962963
1194	1	2022	319
1194	1	1990	404
1194	3	1990	28
1194	3	2022	75.9966777408644
1195	1	2022	477
1195	1	1990	449
1195	3	1990	26
1195	3	2022	22.6852749823852
1196	1	2022	383
1196	1	1990	361
1196	3	1990	80
1196	3	2022	78.8421891141728
1197	1	2022	356
1197	1	1990	336
1197	3	1990	65
1197	3	2022	76.6169154228856
1198	1	2022	319
1198	1	1990	458
1198	3	1990	19
1198	3	2022	44.5208766597346
1199	1	2022	241
1199	1	1990	231
1199	3	1990	9
1199	3	2022	36.1884816753926
1200	1	2022	642
1200	1	1990	964
1200	3	1990	77
1200	3	2022	149.756493506493
1201	1	2022	371
1201	1	1990	344
1201	3	1990	28
1201	3	2022	32.358208955224
1202	1	2022	136
1202	1	1990	225
1202	3	1990	17
1202	3	2022	28.6666666666667
1203	1	2022	143
1203	1	1990	193
1203	3	1990	17
1203	3	2022	27.0011098779134
1204	1	2022	207
1204	1	1990	276
1204	3	1990	40
1204	3	2022	13.8064659977703
1205	1	2022	55
1205	1	1990	40
1205	3	1990	15
1205	3	2022	3.125
1206	1	2022	236
1206	1	1990	303
1206	3	1990	25
1206	3	2022	27
1207	1	2022	720
1207	1	1990	1034
1207	3	1990	69
1207	3	2022	132.379310344828
1208	1	2022	291
1208	1	1990	375
1208	3	1990	32
1208	3	2022	57.9351230425056
1209	1	2022	409
1209	1	1990	486
1209	3	1990	34
1209	3	2022	58.0450445271842
1210	1	2022	240
1210	1	1990	245
1210	3	1990	59
1210	3	2022	46.3900456992896
1211	1	2022	532
1211	1	1990	748
1211	3	1990	65
1211	3	2022	103.41448692153
1212	1	2022	284
1212	1	1990	314
1212	3	1990	21
1212	3	2022	44
1213	1	2022	175
1213	1	1990	206
1213	3	1990	16
1213	3	2022	35.7106918238994
1214	1	2022	43
1214	1	1990	44
1214	3	1990	8
1214	3	2022	11.4888888888889
1215	1	2022	179
1215	1	1990	268
1215	3	1990	34
1215	3	2022	18.4
1216	1	2022	68
1216	1	1990	100
1216	3	1990	8
1216	3	2022	9
1217	1	2022	181
1217	1	1990	274
1217	3	1990	17
1217	3	2022	16.0919540229885
1218	1	2022	642
1218	1	1990	781
1218	3	1990	46
1218	3	2022	62.1297071129707
1219	1	2022	94
1219	1	1990	84
1219	3	1990	11
1219	3	2022	16.8309327846365
1220	1	2022	198
1220	1	1990	262
1220	3	1990	35
1220	3	2022	44.4074074074076
1221	1	2022	123
1221	1	1990	142
1221	3	1990	7
1221	3	2022	19.5
1222	1	2022	56
1222	1	1990	96
1222	3	1990	7
1222	3	2022	5.69230769230769
1223	1	2022	525
1223	1	1990	668
1223	3	1990	67
1223	3	2022	76.4672131147544
1224	1	2022	661
1224	1	1990	907
1224	3	1990	62
1224	3	2022	71.2658464010669
1225	1	2022	372
1225	1	1990	448
1225	3	1990	41
1225	3	2022	14
1226	1	2022	370
1226	1	1990	356
1226	3	1990	34
1226	3	2022	52
1227	1	2022	217
1227	1	1990	248
1227	3	1990	20
1227	3	2022	26
1228	1	2022	276
1228	1	1990	331
1228	3	1990	58
1228	3	2022	30.7692307692308
1229	1	2022	523
1229	1	1990	629
1229	3	1990	70
1229	3	2022	75
1230	1	2022	161
1230	1	1990	195
1230	3	1990	25
1230	3	2022	20.1162790697674
1231	1	2022	558
1231	1	1990	573
1231	3	1990	58
1231	3	2022	16.1015076252723
1232	1	2022	433
1232	1	1990	446
1232	3	1990	42
1232	3	2022	45
1233	1	2022	667
1233	1	1990	721
1233	3	1990	69
1233	3	2022	72.1063903281518
1234	1	2022	279
1234	1	1990	295
1234	3	1990	42
1234	3	2022	42
1235	1	2022	495
1235	1	1990	477
1235	3	1990	30
1235	3	2022	31.7196156020351
1236	1	2022	228
1236	1	1990	264
1236	3	1990	15
1236	3	2022	15.1698113207547
1237	1	2022	301
1237	1	1990	355
1237	3	1990	28
1237	3	2022	35.3667166357593
1238	1	2022	238
1238	1	1990	277
1238	3	1990	52
1238	3	2022	51.4396551724137
1239	1	2022	97
1239	1	1990	111
1239	3	1990	21
1239	3	2022	26.5723270440252
1240	1	2022	250
1240	1	1990	278
1240	3	1990	25
1240	3	2022	46
1241	1	2022	823
1241	1	1990	801
1241	3	1990	76
1241	3	2022	62.6503781452188
1242	1	2022	151
1242	1	1990	162
1242	3	1990	15
1242	3	2022	7
1243	1	2022	422
1243	1	1990	506
1243	3	1990	57
1243	3	2022	75.3836317135545
1244	1	2022	68
1244	1	1990	85
1244	3	1990	8
1244	3	2022	9.79200875752597
1245	1	2022	715
1245	1	1990	682
1245	3	1990	62
1245	3	2022	89
1246	1	2022	359
1246	1	1990	350
1246	3	1990	25
1246	3	2022	37.208105253049
1247	1	2022	83
1247	1	1990	127
1247	3	1990	13
1247	3	2022	8
1248	1	2022	96
1248	1	1990	87
1248	3	1990	7
1248	3	2022	12
1249	1	2022	150
1249	1	1990	196
1249	3	1990	11
1249	3	2022	15
1250	1	2022	144
1250	1	1990	194
1250	3	1990	20
1250	3	2022	14.4339622641509
1251	1	2022	262
1251	1	1990	365
1251	3	1990	28
1251	3	2022	30
1252	1	2022	371
1252	1	1990	420
1252	3	1990	96
1252	3	2022	48.8611898016996
1253	1	2022	474
1253	1	1990	631
1253	3	1990	30
1253	3	2022	2.00455580865604
1254	1	2022	572
1254	1	1990	670
1254	3	1990	57
1254	3	2022	21.2464255352037
1255	1	2022	195
1255	1	1990	203
1255	3	1990	11
1255	3	2022	17.1188811188812
1256	1	2022	347
1256	1	1990	432
1256	3	1990	48
1256	3	2022	44
1257	1	2022	758
1257	1	1990	845
1257	3	1990	21
1257	3	2022	80.0000000000003
1258	1	2022	659
1258	1	1990	532
1258	3	1990	15
1258	3	2022	27.25
1259	1	2022	209
1259	1	1990	225
1259	3	1990	15
1259	3	2022	5.26281635301752
1260	1	2022	103
1260	1	1990	139
1260	3	1990	28
1260	3	2022	28.7928571428571
1261	1	2022	121
1261	1	1990	117
1261	3	1990	13
1261	3	2022	12.2971034482759
1262	1	2022	139
1262	1	1990	135
1262	3	1990	32
1262	3	2022	19
1263	1	2022	591
1263	1	1990	540
1263	3	1990	86
1263	3	2022	95.6943096545428
1264	1	2022	114
1264	1	1990	155
1264	3	1990	15
1264	3	2022	4
1265	1	2022	4928
1265	1	1990	5459
1265	3	1990	266
1265	3	2022	497.789961925685
1266	1	2022	1059
1266	1	1990	1115
1266	3	1990	71
1266	3	2022	81.9827477193826
1267	1	2022	186
1267	1	1990	209
1267	3	1990	31
1267	3	2022	35.3201842127198
1268	1	2022	290
1268	1	1990	350
1268	3	1990	29
1268	3	2022	33.0516431924882
1269	1	2022	453
1269	1	1990	534
1269	3	1990	19
1269	3	2022	13
1270	1	2022	152
1270	1	1990	236
1270	3	1990	25
1270	3	2022	32.8156424581006
1271	1	2022	163
1271	1	1990	206
1271	3	1990	18
1271	3	2022	18
1272	1	2022	88
1272	1	1990	69
1272	3	1990	10
1272	3	2022	7.22222222222222
1273	1	2022	95
1273	1	1990	117
1273	3	1990	9
1273	3	2022	14.0569105691057
1274	1	2022	317
1274	1	1990	379
1274	3	1990	43
1274	3	2022	46
1275	1	2022	150
1275	1	1990	133
1275	3	1990	2
1275	3	2022	6
1276	1	2022	180
1276	1	1990	234
1276	3	1990	19
1276	3	2022	16.2025316455696
1277	1	2022	203
1277	1	1990	215
1277	3	1990	37
1277	3	2022	32.2240293197459
1278	1	2022	1134
1278	1	1990	1241
1278	3	1990	102
1278	3	2022	87.4526876676781
1279	1	2022	162
1279	1	1990	205
1279	3	1990	24
1279	3	2022	43.7127071823205
1280	1	2022	176
1280	1	1990	175
1280	3	1990	14
1280	3	2022	22.85625
1281	1	2022	1433
1281	1	1990	1648
1281	3	1990	101
1281	3	2022	154.54609929078
1282	1	2022	2531
1282	1	1990	2250
1282	3	1990	58
1282	3	2022	157.458570418886
1283	1	2022	120
1283	1	1990	144
1283	3	1990	7
1283	3	2022	14.1505376344086
1284	1	2022	1079
1284	1	1990	709
1284	3	1990	22
1284	3	2022	30.8610337976767
1285	1	2022	252
1285	1	1990	180
1285	3	1990	29
1285	3	2022	14.6005549875858
1286	1	2022	361
1286	1	1990	328
1286	3	1990	45
1286	3	2022	70.2951597595698
1287	1	2022	145
1287	1	1990	156
1287	3	1990	24
1287	3	2022	15.0986842105263
1288	1	2022	355
1288	1	1990	406
1288	3	1990	36
1288	3	2022	53.3430420711977
1289	1	2022	160
1289	1	1990	238
1289	3	1990	30
1289	3	2022	37
1290	1	2022	211
1290	1	1990	237
1290	3	1990	17
1290	3	2022	19.1338028169015
1291	1	2022	225
1291	1	1990	296
1291	3	1990	31
1291	3	2022	45.6310679611651
1292	1	2022	218
1292	1	1990	211
1292	3	1990	14
1292	3	2022	23.2257231732865
1293	1	2022	150
1293	1	1990	174
1293	3	1990	24
1293	3	2022	28.6611111111112
1294	1	2022	144
1294	1	1990	193
1294	3	1990	26
1294	3	2022	19
1295	1	2022	678
1295	1	1990	478
1295	3	1990	23
1295	3	2022	22.6448691580409
1296	1	2022	165
1296	1	1990	184
1296	3	1990	30
1296	3	2022	20
1297	1	2022	398
1297	1	1990	446
1297	3	1990	16
1297	3	2022	28
1298	1	2022	192
1298	1	1990	186
1298	3	1990	29
1298	3	2022	24.477504638219
1299	1	2022	233
1299	1	1990	255
1299	3	1990	22
1299	3	2022	28.1028775146422
1300	1	2022	427
1300	1	1990	407
1300	3	1990	26
1300	3	2022	9.10266159695815
1301	1	2022	126
1301	1	1990	91
1301	3	1990	4
1301	3	2022	7.04861111111108
1302	1	2022	199
1302	1	1990	232
1302	3	1990	27
1302	3	2022	30
1303	1	2022	264
1303	1	1990	255
1303	3	1990	30
1303	3	2022	38
1304	1	2022	151
1304	1	1990	103
1304	3	1990	13
1304	3	2022	16
1305	1	2022	152
1305	1	1990	152
1305	3	1990	51
1305	3	2022	6.17061611374408
1306	1	2022	330
1306	1	1990	425
1306	3	1990	22
1306	3	2022	123
1307	1	2022	100
1307	1	1990	130
1307	3	1990	25
1307	3	2022	13.7954337899543
1308	1	2022	1126
1308	1	1990	1089
1308	3	1990	70
1308	3	2022	95
1309	1	2022	553
1309	1	1990	626
1309	3	1990	86
1309	3	2022	84.1303501945531
1310	1	2022	195
1310	1	1990	238
1310	3	1990	25
1310	3	2022	56.4627976190476
1311	1	2022	166
1311	1	1990	177
1311	3	1990	17
1311	3	2022	25
1312	1	2022	218
1312	1	1990	287
1312	3	1990	49
1312	3	2022	51.7259786476868
1313	1	2022	71
1313	1	1990	55
1313	3	1990	6
1313	3	2022	8
1314	1	2022	109
1314	1	1990	134
1314	3	1990	13
1314	3	2022	17
1315	1	2022	164
1315	1	1990	186
1315	3	1990	15
1315	3	2022	6.24390243902439
1316	1	2022	211
1316	1	1990	254
1316	3	1990	50
1316	3	2022	25
1317	1	2022	196
1317	1	1990	164
1317	3	1990	9
1317	3	2022	13.0005636856368
1318	1	2022	289
1318	1	1990	352
1318	3	1990	60
1318	3	2022	69.4918719437495
1319	1	2022	165
1319	1	1990	218
1319	3	1990	41
1319	3	2022	30.1910828025477
1320	1	2022	213
1320	1	1990	302
1320	3	1990	34
1320	3	2022	14.1910175438596
1321	1	2022	119
1321	1	1990	165
1321	3	1990	13
1321	3	2022	28
1322	1	2022	150
1322	1	1990	230
1322	3	1990	22
1322	3	2022	23.1337209302325
1323	1	2022	721
1323	1	1990	635
1323	3	1990	47
1323	3	2022	78
1324	1	2022	256
1324	1	1990	310
1324	3	1990	36
1324	3	2022	52.5226130653266
1325	1	2022	55
1325	1	1990	58
1325	3	1990	2
1325	3	2022	4
1326	1	2022	368
1326	1	1990	443
1326	3	1990	31
1326	3	2022	46.3297491039426
1327	1	2022	629
1327	1	1990	736
1327	3	1990	80
1327	3	2022	89.0877868245742
1328	1	2022	409
1328	1	1990	527
1328	3	1990	36
1328	3	2022	36.1200000000001
1329	1	2022	198
1329	1	1990	238
1329	3	1990	19
1329	3	2022	42.7576123002713
1330	1	2022	193
1330	1	1990	198
1330	3	1990	13
1330	3	2022	33
1331	1	2022	147
1331	1	1990	179
1331	3	1990	25
1331	3	2022	20.1408450704226
1332	1	2022	570
1332	1	1990	698
1332	3	1990	50
1332	3	2022	61.5586080586083
1333	1	2022	1901
1333	1	1990	1879
1333	3	1990	68
1333	3	2022	122.442410091773
1334	1	2022	343
1334	1	1990	395
1334	3	1990	16
1334	3	2022	51.5168918918921
1335	1	2022	1729
1335	1	1990	2059
1335	3	1990	102
1335	3	2022	176
1336	1	2022	348
1336	1	1990	297
1336	3	1990	22
1336	3	2022	33.1392405063291
1337	1	2022	221
1337	1	1990	283
1337	3	1990	30
1337	3	2022	25
1338	1	2022	281
1338	1	1990	326
1338	3	1990	27
1338	3	2022	33.87265917603
1339	1	2022	119
1339	1	1990	154
1339	3	1990	26
1339	3	2022	32
1340	1	2022	154
1340	1	1990	206
1340	3	1990	28
1340	3	2022	28.9666753449622
1341	1	2022	170
1341	1	1990	190
1341	3	1990	17
1341	3	2022	8.54150354609929
1342	1	2022	252
1342	1	1990	361
1342	3	1990	61
1342	3	2022	82.0588235294122
1343	1	2022	132
1343	1	1990	85
1343	3	1990	27
1343	3	2022	11.2250084430936
1344	1	2022	714
1344	1	1990	814
1344	3	1990	48
1344	3	2022	30
1345	1	2022	322
1345	1	1990	297
1345	3	1990	13
1345	3	2022	23.5169086910783
1346	1	2022	124
1346	1	1990	71
1346	3	1990	10
1346	3	2022	5.1449275362319
1347	1	2022	201
1347	1	1990	183
1347	3	1990	15
1347	3	2022	14.159090909091
1348	1	2022	281
1348	1	1990	378
1348	3	1990	28
1348	3	2022	40.0308370044054
1349	1	2022	164
1349	1	1990	145
1349	3	1990	15
1349	3	2022	10.2941176470588
1350	1	2022	381
1350	1	1990	341
1350	3	1990	35
1350	3	2022	11.0426356589148
1351	1	2022	51
1351	1	1990	53
1351	3	1990	0
1351	3	2022	6.09677419354836
1352	1	2022	45
1352	1	1990	94
1352	3	1990	14
1352	3	2022	19
1353	1	2022	166
1353	1	1990	188
1353	3	1990	25
1353	3	2022	15.206106870229
1354	1	2022	635
1354	1	1990	693
1354	3	1990	26
1354	3	2022	43
1355	1	2022	1809
1355	1	1990	1342
1355	3	1990	39
1355	3	2022	71.5906492737651
1356	1	2022	300
1356	1	1990	275
1356	3	1990	26
1356	3	2022	6.86418661082388
1357	1	2022	384
1357	1	1990	302
1357	3	1990	18
1357	3	2022	12.6634891362915
1358	1	2022	195
1358	1	1990	203
1358	3	1990	11
1358	3	2022	18.7848446147297
1359	1	2022	543
1359	1	1990	489
1359	3	1990	2
1359	3	2022	17
1360	1	2022	595
1360	1	1990	559
1360	3	1990	50
1360	3	2022	46.4840914269326
1361	1	2022	266
1361	1	1990	269
1361	3	1990	6
1361	3	2022	25.3424657534246
1362	1	2022	1478
1362	1	1990	1099
1362	3	1990	10
1362	3	2022	59.4093789774748
1363	1	2022	1221
1363	1	1990	1050
1363	3	1990	27
1363	3	2022	56.87325582835
1364	1	2022	403
1364	1	1990	302
1364	3	1990	11
1364	3	2022	11.2669966291601
1365	1	2022	615
1365	1	1990	458
1365	3	1990	20
1365	3	2022	65.2996666927524
1366	1	2022	272
1366	1	1990	180
1366	3	1990	5
1366	3	2022	15.3470892351767
1367	1	2022	825
1367	1	1990	838
1367	3	1990	18
1367	3	2022	44.7773851590107
1368	1	2022	400
1368	1	1990	377
1368	3	1990	19
1368	3	2022	37.7141891689442
1369	1	2022	449
1369	1	1990	407
1369	3	1990	15
1369	3	2022	8.6730705396525
1370	1	2022	895
1370	1	1990	722
1370	3	1990	36
1370	3	2022	34
1371	1	2022	410
1371	1	1990	451
1371	3	1990	21
1371	3	2022	24.6802050329582
1372	1	2022	205
1372	1	1990	188
1372	3	1990	9
1372	3	2022	13
1373	1	2022	316
1373	1	1990	299
1373	3	1990	7
1373	3	2022	18.1881158554793
1374	1	2022	43
1374	1	1990	36
1374	3	1990	2
1374	3	2022	4
1375	1	2022	243
1375	1	1990	217
1375	3	1990	12
1375	3	2022	16.3774826059456
1376	1	2022	4365
1376	1	1990	3548
1376	3	1990	85
1376	3	2022	200.513432835821
1377	1	2022	356
1377	1	1990	328
1377	3	1990	13
1377	3	2022	18.1551724137931
1378	1	2022	1730
1378	1	1990	1887
1378	3	1990	97
1378	3	2022	148
1379	1	2022	558
1379	1	1990	439
1379	3	1990	12
1379	3	2022	32.0873266784496
1380	1	2022	706
1380	1	1990	653
1380	3	1990	29
1380	3	2022	9.31798594063745
1381	1	2022	308
1381	1	1990	209
1381	3	1990	15
1381	3	2022	14
1382	1	2022	372
1382	1	1990	328
1382	3	1990	49
1382	3	2022	26.7137254901961
1383	1	2022	281
1383	1	1990	206
1383	3	1990	18
1383	3	2022	11.1245062007429
1384	1	2022	1310
1384	1	1990	1657
1384	3	1990	128
1384	3	2022	159.776118607819
1385	1	2022	178
1385	1	1990	181
1385	3	1990	6
1385	3	2022	0
1386	1	2022	26852
1386	1	1990	26899
1386	3	1990	885
1386	3	2022	1650.34893250334
1387	1	2022	435
1387	1	1990	340
1387	3	1990	13
1387	3	2022	28.8472746595074
1388	1	2022	153
1388	1	1990	171
1388	3	1990	2
1388	3	2022	14.0825958702065
1389	1	2022	447
1389	1	1990	498
1389	3	1990	3
1389	3	2022	41.8164976912037
1390	1	2022	715
1390	1	1990	372
1390	3	1990	15
1390	3	2022	31.6808359351022
1391	1	2022	146
1391	1	1990	132
1391	3	1990	16
1391	3	2022	11.7247684534308
1392	1	2022	249
1392	1	1990	196
1392	3	1990	12
1392	3	2022	8.32182585347142
1393	1	2022	110
1393	1	1990	113
1393	3	1990	13
1393	3	2022	21
1394	1	2022	302
1394	1	1990	216
1394	3	1990	18
1394	3	2022	9
1395	1	2022	352
1395	1	1990	305
1395	3	1990	10
1395	3	2022	32
1396	1	2022	233
1396	1	1990	209
1396	3	1990	7
1396	3	2022	15
1397	1	2022	123
1397	1	1990	114
1397	3	1990	2
1397	3	2022	0
1398	1	2022	10628
1398	1	1990	8341
1398	3	1990	162
1398	3	2022	306.275794703108
1399	1	2022	589
1399	1	1990	466
1399	3	1990	14
1399	3	2022	45.4856755079882
1400	1	2022	793
1400	1	1990	811
1400	3	1990	34
1400	3	2022	56.1437048503613
1401	1	2022	240
1401	1	1990	230
1401	3	1990	11
1401	3	2022	13.3681104957806
1402	1	2022	72
1402	1	1990	55
1402	3	1990	9
1402	3	2022	7
1403	1	2022	237
1403	1	1990	174
1403	3	1990	12
1403	3	2022	11.9688888888889
1404	1	2022	352
1404	1	1990	287
1404	3	1990	12
1404	3	2022	19.5050494941566
1405	1	2022	67
1405	1	1990	52
1405	3	1990	5
1405	3	2022	14.5585585585586
1406	1	2022	132
1406	1	1990	155
1406	3	1990	9
1406	3	2022	5.30487804878051
1407	1	2022	175
1407	1	1990	214
1407	3	1990	9
1407	3	2022	11.312863225187
1408	1	2022	154
1408	1	1990	133
1408	3	1990	11
1408	3	2022	8.88702619520454
1409	1	2022	3748
1409	1	1990	3455
1409	3	1990	128
1409	3	2022	294
1410	1	2022	217
1410	1	1990	212
1410	3	1990	18
1410	3	2022	11.3916440217391
1411	1	2022	2638
1411	1	1990	2764
1411	3	1990	137
1411	3	2022	312.592431562595
1412	1	2022	1954
1412	1	1990	2003
1412	3	1990	76
1412	3	2022	161
1413	1	2022	385
1413	1	1990	267
1413	3	1990	14
1413	3	2022	18.4064249926319
1414	1	2022	505
1414	1	1990	569
1414	3	1990	26
1414	3	2022	66.7831715210354
1415	1	2022	372
1415	1	1990	530
1415	3	1990	5
1415	3	2022	66.8112676056337
1416	1	2022	373
1416	1	1990	289
1416	3	1990	22
1416	3	2022	32.2275106892092
1417	1	2022	541
1417	1	1990	441
1417	3	1990	10
1417	3	2022	36
1418	1	2022	324
1418	1	1990	305
1418	3	1990	7
1418	3	2022	22.5893871371686
1419	1	2022	418
1419	1	1990	281
1419	3	1990	7
1419	3	2022	21.2968308287458
1420	1	2022	398
1420	1	1990	403
1420	3	1990	29
1420	3	2022	14.5247505380551
1421	1	2022	461
1421	1	1990	502
1421	3	1990	10
1421	3	2022	32.3440860215054
1422	1	2022	655
1422	1	1990	594
1422	3	1990	13
1422	3	2022	52.1315262103153
1423	1	2022	1549
1423	1	1990	1219
1423	3	1990	27
1423	3	2022	91.2674422350367
1424	1	2022	212
1424	1	1990	175
1424	3	1990	8
1424	3	2022	4.76799999999998
1425	1	2022	101
1425	1	1990	131
1425	3	1990	7
1425	3	2022	3.74842767295597
1426	1	2022	151
1426	1	1990	120
1426	3	1990	3
1426	3	2022	15.1446723821188
1427	1	2022	449
1427	1	1990	408
1427	3	1990	4
1427	3	2022	12.8585387519432
1428	1	2022	805
1428	1	1990	519
1428	3	1990	24
1428	3	2022	19
1429	1	2022	336
1429	1	1990	278
1429	3	1990	22
1429	3	2022	13.6179580265431
1430	1	2022	611
1430	1	1990	597
1430	3	1990	32
1430	3	2022	17.5473085879611
1431	1	2022	1189
1431	1	1990	993
1431	3	1990	34
1431	3	2022	66
1432	1	2022	442
1432	1	1990	338
1432	3	1990	11
1432	3	2022	20.8285882767723
1433	1	2022	404
1433	1	1990	425
1433	3	1990	44
1433	3	2022	33.7344573234983
1434	1	2022	783
1434	1	1990	658
1434	3	1990	33
1434	3	2022	25.3214870236146
1435	1	2022	343
1435	1	1990	415
1435	3	1990	29
1435	3	2022	47.1294765840221
1436	1	2022	3077
1436	1	1990	2208
1436	3	1990	19
1436	3	2022	108.842552110703
1437	1	2022	511
1437	1	1990	544
1437	3	1990	50
1437	3	2022	32.5642997984875
1438	1	2022	287
1438	1	1990	331
1438	3	1990	13
1438	3	2022	28.1152340482484
1439	1	2022	4442
1439	1	1990	3718
1439	3	1990	99
1439	3	2022	194.503258922809
1440	1	2022	647
1440	1	1990	461
1440	3	1990	27
1440	3	2022	22.3468604885926
1441	1	2022	140
1441	1	1990	124
1441	3	1990	0
1441	3	2022	13.1274509803922
1442	1	2022	542
1442	1	1990	330
1442	3	1990	7
1442	3	2022	23.0043703771474
1443	1	2022	386
1443	1	1990	398
1443	3	1990	29
1443	3	2022	36.3941605839416
1444	1	2022	1058
1444	1	1990	703
1444	3	1990	17
1444	3	2022	37.6176016356238
1445	1	2022	102
1445	1	1990	126
1445	3	1990	15
1445	3	2022	10.1111111111111
1446	1	2022	57
1446	1	1990	85
1446	3	1990	4
1446	3	2022	12.5066666666667
1447	1	2022	75
1447	1	1990	87
1447	3	1990	3
1447	3	2022	10.1538461538462
1448	1	2022	84
1448	1	1990	69
1448	3	1990	3
1448	3	2022	2
1449	1	2022	73
1449	1	1990	71
1449	3	1990	19
1449	3	2022	18.147969924812
1450	1	2022	2162
1450	1	1990	1701
1450	3	1990	38
1450	3	2022	125.909845993734
1451	1	2022	181
1451	1	1990	181
1451	3	1990	10
1451	3	2022	9.12587412587411
1452	1	2022	551
1452	1	1990	464
1452	3	1990	4
1452	3	2022	15.0461538461538
1453	1	2022	226
1453	1	1990	310
1453	3	1990	30
1453	3	2022	23.9999999999999
1454	1	2022	555
1454	1	1990	590
1454	3	1990	20
1454	3	2022	58
1455	1	2022	69
1455	1	1990	71
1455	3	1990	1
1455	3	2022	2
1456	1	2022	87
1456	1	1990	81
1456	3	1990	4
1456	3	2022	3
1457	1	2022	123
1457	1	1990	123
1457	3	1990	5
1457	3	2022	4.0506329113924
1458	1	2022	248
1458	1	1990	255
1458	3	1990	13
1458	3	2022	23.8028154381591
1459	1	2022	279
1459	1	1990	228
1459	3	1990	5
1459	3	2022	8.50752125572269
1460	1	2022	165
1460	1	1990	130
1460	3	1990	17
1460	3	2022	13.0979801025023
1461	1	2022	495
1461	1	1990	376
1461	3	1990	16
1461	3	2022	32.3090770404272
1462	1	2022	865
1462	1	1990	907
1462	3	1990	10
1462	3	2022	24.1296187683285
1463	1	2022	76
1463	1	1990	56
1463	3	1990	12
1463	3	2022	8.78571428571428
1464	1	2022	255
1464	1	1990	191
1464	3	1990	15
1464	3	2022	20.3954492244659
1465	1	2022	1259
1465	1	1990	1515
1465	3	1990	82
1465	3	2022	104.095316899584
1466	1	2022	862
1466	1	1990	888
1466	3	1990	47
1466	3	2022	55
1467	1	2022	688
1467	1	1990	548
1467	3	1990	17
1467	3	2022	21.1265060240963
1468	1	2022	108
1468	1	1990	175
1468	3	1990	5
1468	3	2022	13
1469	1	2022	758
1469	1	1990	743
1469	3	1990	38
1469	3	2022	88.324409335818
1470	1	2022	7537
1470	1	1990	8403
1470	3	1990	118
1470	3	2022	437.808045934847
1471	1	2022	2326
1471	1	1990	1175
1471	3	1990	8
1471	3	2022	46.1007005926474
1472	1	2022	1563
1472	1	1990	1329
1472	3	1990	25
1472	3	2022	51.3876704440576
1473	1	2022	198
1473	1	1990	175
1473	3	1990	5
1473	3	2022	12
1474	1	2022	1234
1474	1	1990	904
1474	3	1990	46
1474	3	2022	34.9470621504966
1475	1	2022	715
1475	1	1990	781
1475	3	1990	60
1475	3	2022	59.2045573022188
1476	1	2022	104
1476	1	1990	81
1476	3	1990	2
1476	3	2022	1
1477	1	2022	1738
1477	1	1990	2336
1477	3	1990	36
1477	3	2022	128.650274975955
1478	1	2022	266
1478	1	1990	178
1478	3	1990	8
1478	3	2022	17.8717948717949
1479	1	2022	1116
1479	1	1990	1023
1479	3	1990	54
1479	3	2022	106.580056581583
1480	1	2022	315
1480	1	1990	201
1480	3	1990	3
1480	3	2022	5
1481	1	2022	556
1481	1	1990	477
1481	3	1990	22
1481	3	2022	34.4746202462503
1482	1	2022	101
1482	1	1990	125
1482	3	1990	1
1482	3	2022	18.6136363636363
1483	1	2022	901
1483	1	1990	1030
1483	3	1990	26
1483	3	2022	44.723555249871
1484	1	2022	404
1484	1	1990	266
1484	3	1990	8
1484	3	2022	15.5386852625852
1485	1	2022	349
1485	1	1990	240
1485	3	1990	4
1485	3	2022	17.554347826087
1486	1	2022	456
1486	1	1990	402
1486	3	1990	21
1486	3	2022	48
1487	1	2022	1147
1487	1	1990	866
1487	3	1990	57
1487	3	2022	31
1488	1	2022	846
1488	1	1990	628
1488	3	1990	29
1488	3	2022	58
1489	1	2022	426
1489	1	1990	431
1489	3	1990	21
1489	3	2022	25
1490	1	2022	395
1490	1	1990	411
1490	3	1990	31
1490	3	2022	32.111888111888
1491	1	2022	583
1491	1	1990	307
1491	3	1990	17
1491	3	2022	23.0027562270313
1492	1	2022	122
1492	1	1990	115
1492	3	1990	5
1492	3	2022	8.16243240485665
1493	1	2022	399
1493	1	1990	367
1493	3	1990	8
1493	3	2022	13.0662802110171
1494	1	2022	165
1494	1	1990	174
1494	3	1990	12
1494	3	2022	15
1495	1	2022	1195
1495	1	1990	1414
1495	3	1990	101
1495	3	2022	188
1496	1	2022	407
1496	1	1990	300
1496	3	1990	38
1496	3	2022	28
1497	1	2022	2553
1497	1	1990	2769
1497	3	1990	153
1497	3	2022	197.124672091542
1498	1	2022	410
1498	1	1990	392
1498	3	1990	26
1498	3	2022	15
1499	1	2022	547
1499	1	1990	493
1499	3	1990	23
1499	3	2022	27.7599246125337
1500	1	2022	1133
1500	1	1990	1098
1500	3	1990	29
1500	3	2022	88
1501	1	2022	137
1501	1	1990	158
1501	3	1990	10
1501	3	2022	9.69856130485539
1502	1	2022	308
1502	1	1990	228
1502	3	1990	10
1502	3	2022	7.21808556799446
1503	1	2022	36
1503	1	1990	62
1503	3	1990	0
1503	3	2022	5.6
1504	1	2022	669
1504	1	1990	586
1504	3	1990	17
1504	3	2022	22
1505	1	2022	797
1505	1	1990	568
1505	3	1990	12
1505	3	2022	15.3575727883539
1506	1	2022	298
1506	1	1990	364
1506	3	1990	23
1506	3	2022	18
1507	1	2022	1498
1507	1	1990	1278
1507	3	1990	38
1507	3	2022	96.1167156168946
1508	1	2022	320
1508	1	1990	220
1508	3	1990	7
1508	3	2022	13.5238095238096
1509	1	2022	163
1509	1	1990	164
1509	3	1990	8
1509	3	2022	4.30128205128205
1510	1	2022	333
1510	1	1990	212
1510	3	1990	27
1510	3	2022	19.3254798252995
1511	1	2022	553
1511	1	1990	535
1511	3	1990	23
1511	3	2022	49
1512	1	2022	454
1512	1	1990	383
1512	3	1990	10
1512	3	2022	38.9837787714012
1513	1	2022	273
1513	1	1990	186
1513	3	1990	7
1513	3	2022	7.0043374347172
1514	1	2022	173
1514	1	1990	120
1514	3	1990	15
1514	3	2022	6.28422857142856
1515	1	2022	97
1515	1	1990	104
1515	3	1990	8
1515	3	2022	7
1516	1	2022	441
1516	1	1990	440
1516	3	1990	29
1516	3	2022	12.4127541900198
1517	1	2022	1607
1517	1	1990	1383
1517	3	1990	36
1517	3	2022	76.9290953545231
1518	1	2022	107
1518	1	1990	123
1518	3	1990	0
1518	3	2022	8.26666666666665
1519	1	2022	508
1519	1	1990	538
1519	3	1990	48
1519	3	2022	39.0172993053375
1520	1	2022	758
1520	1	1990	708
1520	3	1990	0
1520	3	2022	24
1521	1	2022	362
1521	1	1990	463
1521	3	1990	12
1521	3	2022	21.9644012944984
1522	1	2022	538
1522	1	1990	488
1522	3	1990	49
1522	3	2022	46.9455986209913
1523	1	2022	148
1523	1	1990	209
1523	3	1990	14
1523	3	2022	17.1666666666667
1524	1	2022	668
1524	1	1990	526
1524	3	1990	15
1524	3	2022	23.2358974358974
1525	1	2022	106
1525	1	1990	129
1525	3	1990	4
1525	3	2022	12.4191087916499
1526	1	2022	675
1526	1	1990	545
1526	3	1990	26
1526	3	2022	21.9918405508568
1527	1	2022	247
1527	1	1990	165
1527	3	1990	18
1527	3	2022	17.125
1528	1	2022	128
1528	1	1990	129
1528	3	1990	34
1528	3	2022	11.4642857142857
1529	1	2022	814
1529	1	1990	1048
1529	3	1990	29
1529	3	2022	58.633812111801
1530	1	2022	437
1530	1	1990	389
1530	3	1990	24
1530	3	2022	18.3841463414633
1531	1	2022	748
1531	1	1990	638
1531	3	1990	61
1531	3	2022	60.1771883710526
1532	1	2022	178
1532	1	1990	143
1532	3	1990	4
1532	3	2022	11.5829059829061
1533	1	2022	818
1533	1	1990	1064
1533	3	1990	9
1533	3	2022	76.7403334727783
1534	1	2022	188
1534	1	1990	194
1534	3	1990	6
1534	3	2022	14
1535	1	2022	148
1535	1	1990	152
1535	3	1990	22
1535	3	2022	10
1536	1	2022	481
1536	1	1990	345
1536	3	1990	31
1536	3	2022	31.7517595442831
1537	1	2022	1140
1537	1	1990	1260
1537	3	1990	84
1537	3	2022	93.8392364729461
1538	1	2022	691
1538	1	1990	562
1538	3	1990	26
1538	3	2022	48.1250000000002
1539	1	2022	154
1539	1	1990	216
1539	3	1990	11
1539	3	2022	9.9009900990099
1540	1	2022	2687
1540	1	1990	2261
1540	3	1990	62
1540	3	2022	100.507754677248
1541	1	2022	2936
1541	1	1990	3029
1541	3	1990	144
1541	3	2022	226
1542	1	2022	692
1542	1	1990	539
1542	3	1990	23
1542	3	2022	37.0326863238996
1543	1	2022	2745
1543	1	1990	2010
1543	3	1990	69
1543	3	2022	98
1544	1	2022	1430
1544	1	1990	1093
1544	3	1990	36
1544	3	2022	92.806705688977
1545	1	2022	938
1545	1	1990	976
1545	3	1990	52
1545	3	2022	102.63354037267
1546	1	2022	501
1546	1	1990	527
1546	3	1990	17
1546	3	2022	33.4916629868409
1547	1	2022	1666
1547	1	1990	2047
1547	3	1990	53
1547	3	2022	146.366033255482
1548	1	2022	148
1548	1	1990	105
1548	3	1990	4
1548	3	2022	8.50195781230263
1549	1	2022	105
1549	1	1990	63
1549	3	1990	0
1549	3	2022	8.24426078971541
1550	1	2022	81
1550	1	1990	102
1550	3	1990	8
1550	3	2022	15.2056462056462
1551	1	2022	383
1551	1	1990	306
1551	3	1990	29
1551	3	2022	21.370315581854
1552	1	2022	974
1552	1	1990	635
1552	3	1990	5
1552	3	2022	18
1553	1	2022	1255
1553	1	1990	1174
1553	3	1990	28
1553	3	2022	44.5110731388307
1554	1	2022	133
1554	1	1990	121
1554	3	1990	3
1554	3	2022	7
1555	1	2022	339
1555	1	1990	335
1555	3	1990	5
1555	3	2022	6.07476635514023
1556	1	2022	430
1556	1	1990	427
1556	3	1990	27
1556	3	2022	4
1557	1	2022	260
1557	1	1990	270
1557	3	1990	7
1557	3	2022	26.7535226744848
1558	1	2022	873
1558	1	1990	946
1558	3	1990	33
1558	3	2022	97.2419349851112
1559	1	2022	191
1559	1	1990	105
1559	3	1990	7
1559	3	2022	12.1395348837209
1560	1	2022	256
1560	1	1990	234
1560	3	1990	2
1560	3	2022	9
1561	1	2022	445
1561	1	1990	297
1561	3	1990	7
1561	3	2022	16.8415160840633
1562	1	2022	163
1562	1	1990	192
1562	3	1990	10
1562	3	2022	10.3333333333334
1563	1	2022	285
1563	1	1990	363
1563	3	1990	5
1563	3	2022	12.1170731707317
1564	1	2022	541
1564	1	1990	488
1564	3	1990	31
1564	3	2022	26.2307692307693
1565	1	2022	839
1565	1	1990	598
1565	3	1990	13
1565	3	2022	43.8780495743264
1566	1	2022	2316
1566	1	1990	2668
1566	3	1990	141
1566	3	2022	272
1567	1	2022	179
1567	1	1990	185
1567	3	1990	4
1567	3	2022	6.2298801369863
1568	1	2022	587
1568	1	1990	473
1568	3	1990	19
1568	3	2022	14.7672253269534
1569	1	2022	3165
1569	1	1990	1939
1569	3	1990	25
1569	3	2022	96.7118437986366
1570	1	2022	225
1570	1	1990	204
1570	3	1990	6
1570	3	2022	22.681635732609
1571	1	2022	1666
1571	1	1990	1314
1571	3	1990	72
1571	3	2022	120.945370580811
1572	1	2022	876
1572	1	1990	958
1572	3	1990	31
1572	3	2022	45.7793808018317
1573	1	2022	290
1573	1	1990	302
1573	3	1990	9
1573	3	2022	36.315789473684
1574	1	2022	322
1574	1	1990	247
1574	3	1990	13
1574	3	2022	21
1575	1	2022	305
1575	1	1990	380
1575	3	1990	16
1575	3	2022	31.7319441347123
1576	1	2022	1911
1576	1	1990	1328
1576	3	1990	45
1576	3	2022	82
1577	1	2022	1520
1577	1	1990	1127
1577	3	1990	30
1577	3	2022	38.5117845117848
1578	1	2022	178
1578	1	1990	144
1578	3	1990	19
1578	3	2022	21.2156135336212
1579	1	2022	710
1579	1	1990	417
1579	3	1990	12
1579	3	2022	24
1580	1	2022	629
1580	1	1990	795
1580	3	1990	29
1580	3	2022	84.8650793650793
1581	1	2022	512
1581	1	1990	573
1581	3	1990	24
1581	3	2022	50.7788191818577
1582	1	2022	495
1582	1	1990	303
1582	3	1990	28
1582	3	2022	18
1583	1	2022	352
1583	1	1990	315
1583	3	1990	22
1583	3	2022	26.412498155526
1584	1	2022	819
1584	1	1990	902
1584	3	1990	34
1584	3	2022	46.8473940515324
1585	1	2022	396
1585	1	1990	325
1585	3	1990	10
1585	3	2022	22.312906300424
1586	1	2022	290
1586	1	1990	233
1586	3	1990	16
1586	3	2022	12.2130177514792
1587	1	2022	80
1587	1	1990	52
1587	3	1990	6
1587	3	2022	3.04761904761906
1588	1	2022	61
1588	1	1990	54
1588	3	1990	0
1588	3	2022	5
1589	1	2022	442
1589	1	1990	531
1589	3	1990	53
1589	3	2022	76
1590	1	2022	178
1590	1	1990	145
1590	3	1990	23
1590	3	2022	8
1591	1	2022	135
1591	1	1990	125
1591	3	1990	1
1591	3	2022	8.5669781931464
1592	1	2022	137
1592	1	1990	111
1592	3	1990	10
1592	3	2022	7.33018867924525
1593	1	2022	391
1593	1	1990	363
1593	3	1990	13
1593	3	2022	17.9250503307449
1594	1	2022	507
1594	1	1990	397
1594	3	1990	18
1594	3	2022	26.1586736605471
1595	1	2022	127
1595	1	1990	105
1595	3	1990	2
1595	3	2022	5.57711557711558
1596	1	2022	280
1596	1	1990	267
1596	3	1990	17
1596	3	2022	22.1037735849058
1597	1	2022	1405
1597	1	1990	1099
1597	3	1990	41
1597	3	2022	64
1598	1	2022	155
1598	1	1990	197
1598	3	1990	6
1598	3	2022	15.1607526331936
1599	1	2022	2760
1599	1	1990	2938
1599	3	1990	155
1599	3	2022	326.708254375761
1600	1	2022	502
1600	1	1990	338
1600	3	1990	30
1600	3	2022	27
1601	1	2022	268
1601	1	1990	216
1601	3	1990	12
1601	3	2022	11
1602	1	2022	5845
1602	1	1990	5481
1602	3	1990	177
1602	3	2022	385.530100172301
1603	1	2022	1203
1603	1	1990	1045
1603	3	1990	24
1603	3	2022	99.5737226277372
1604	1	2022	1155
1604	1	1990	1049
1604	3	1990	51
1604	3	2022	72
1605	1	2022	973
1605	1	1990	664
1605	3	1990	37
1605	3	2022	48.0823158191514
1606	1	2022	2778
1606	1	1990	2985
1606	3	1990	118
1606	3	2022	350.781521184279
1607	1	2022	350
1607	1	1990	275
1607	3	1990	17
1607	3	2022	19.6613182463589
1608	1	2022	376
1608	1	1990	285
1608	3	1990	21
1608	3	2022	26.2126745435016
1609	1	2022	292
1609	1	1990	299
1609	3	1990	2
1609	3	2022	15.1190476190476
1610	1	2022	233
1610	1	1990	275
1610	3	1990	11
1610	3	2022	22.958661828341
1611	1	2022	984
1611	1	1990	932
1611	3	1990	36
1611	3	2022	82.6400427557906
1612	1	2022	239
1612	1	1990	337
1612	3	1990	9
1612	3	2022	5.22870893492363
1613	1	2022	135
1613	1	1990	114
1613	3	1990	7
1613	3	2022	18.4641724793911
1614	1	2022	236
1614	1	1990	189
1614	3	1990	14
1614	3	2022	6
1615	1	2022	782
1615	1	1990	664
1615	3	1990	19
1615	3	2022	51.6473020276984
1616	1	2022	3663
1616	1	1990	2737
1616	3	1990	95
1616	3	2022	148.843290763001
1617	1	2022	3049
1617	1	1990	3558
1617	3	1990	144
1617	3	2022	298.881781098221
1618	1	2022	4720
1618	1	1990	3464
1618	3	1990	90
1618	3	2022	159.533741249645
1619	1	2022	45
1619	1	1990	72
1619	3	1990	0
1619	3	2022	1
1620	1	2022	809
1620	1	1990	676
1620	3	1990	45
1620	3	2022	47.5449692661174
1621	1	2022	245
1621	1	1990	258
1621	3	1990	7
1621	3	2022	13.1590258412344
1622	1	2022	318
1622	1	1990	246
1622	3	1990	13
1622	3	2022	29.718783206069
1623	1	2022	455
1623	1	1990	383
1623	3	1990	3
1623	3	2022	27.9769057740979
1624	1	2022	977
1624	1	1990	1106
1624	3	1990	65
1624	3	2022	117.027615994895
1625	1	2022	803
1625	1	1990	640
1625	3	1990	13
1625	3	2022	48
1626	1	2022	29876
1626	1	1990	30280
1626	3	1990	2056
1626	3	2022	2449.31919546784
1627	1	2022	187
1627	1	1990	210
1627	3	1990	22
1627	3	2022	9
1628	1	2022	594
1628	1	1990	372
1628	3	1990	13
1628	3	2022	26.8255499886601
1629	1	2022	784
1629	1	1990	680
1629	3	1990	11
1629	3	2022	49.6786811586215
1630	1	2022	198
1630	1	1990	117
1630	3	1990	10
1630	3	2022	5.09433962264148
1631	1	2022	118
1631	1	1990	130
1631	3	1990	2
1631	3	2022	5.04745666382495
1632	1	2022	1178
1632	1	1990	1471
1632	3	1990	57
1632	3	2022	127.256565656565
1633	1	2022	1416
1633	1	1990	1172
1633	3	1990	35
1633	3	2022	76
1634	1	2022	710
1634	1	1990	543
1634	3	1990	37
1634	3	2022	44
1635	1	2022	738
1635	1	1990	655
1635	3	1990	25
1635	3	2022	54
1636	1	2022	208
1636	1	1990	187
1636	3	1990	3
1636	3	2022	8
1637	1	2022	2515
1637	1	1990	2222
1637	3	1990	64
1637	3	2022	123
1638	1	2022	487
1638	1	1990	420
1638	3	1990	9
1638	3	2022	45.0558842866532
1639	1	2022	144
1639	1	1990	199
1639	3	1990	9
1639	3	2022	12
1640	1	2022	454
1640	1	1990	385
1640	3	1990	17
1640	3	2022	18
1641	1	2022	147
1641	1	1990	156
1641	3	1990	7
1641	3	2022	4.66666666666667
1642	1	2022	4362
1642	1	1990	3721
1642	3	1990	45
1642	3	2022	123
1643	1	2022	1086
1643	1	1990	692
1643	3	1990	19
1643	3	2022	41.2347305192048
1644	1	2022	530
1644	1	1990	439
1644	3	1990	17
1644	3	2022	11
1645	1	2022	384
1645	1	1990	421
1645	3	1990	24
1645	3	2022	36.123287671233
1646	1	2022	139
1646	1	1990	155
1646	3	1990	4
1646	3	2022	7.07070707070707
1647	1	2022	321
1647	1	1990	266
1647	3	1990	16
1647	3	2022	13.25
1648	1	2022	339
1648	1	1990	308
1648	3	1990	21
1648	3	2022	21.0954545454544
1649	1	2022	2367
1649	1	1990	2212
1649	3	1990	20
1649	3	2022	64
1650	1	2022	334
1650	1	1990	278
1650	3	1990	4
1650	3	2022	14.4589075749297
1651	1	2022	3770
1651	1	1990	4118
1651	3	1990	167
1651	3	2022	529.917607563887
1652	1	2022	331
1652	1	1990	424
1652	3	1990	29
1652	3	2022	55.1839959864396
1653	1	2022	3023
1653	1	1990	2860
1653	3	1990	174
1653	3	2022	196.394812422261
1654	1	2022	439
1654	1	1990	447
1654	3	1990	46
1654	3	2022	9.8321650791664
1655	1	2022	1662
1655	1	1990	1465
1655	3	1990	84
1655	3	2022	128.717349472434
1656	1	2022	321
1656	1	1990	282
1656	3	1990	12
1656	3	2022	12.2657971014493
1657	1	2022	102
1657	1	1990	113
1657	3	1990	6
1657	3	2022	10
1658	1	2022	317
1658	1	1990	300
1658	3	1990	15
1658	3	2022	25.7552314521243
1659	1	2022	443
1659	1	1990	325
1659	3	1990	3
1659	3	2022	10.2462819900642
1660	1	2022	1592
1660	1	1990	1416
1660	3	1990	91
1660	3	2022	33
1661	1	2022	629
1661	1	1990	505
1661	3	1990	14
1661	3	2022	8
1662	1	2022	245
1662	1	1990	173
1662	3	1990	7
1662	3	2022	22.8298830745639
1663	1	2022	885
1663	1	1990	529
1663	3	1990	24
1663	3	2022	26.8355788859726
1664	1	2022	168
1664	1	1990	176
1664	3	1990	27
1664	3	2022	7.76672384219554
1665	1	2022	1784
1665	1	1990	1756
1665	3	1990	30
1665	3	2022	79.519074741735
1666	1	2022	463
1666	1	1990	387
1666	3	1990	10
1666	3	2022	27.4913475843708
1667	1	2022	5309
1667	1	1990	4780
1667	3	1990	199
1667	3	2022	299.00832008379
1668	1	2022	347
1668	1	1990	338
1668	3	1990	13
1668	3	2022	24.4285714285714
1669	1	2022	357
1669	1	1990	232
1669	3	1990	17
1669	3	2022	22.7792165957995
1670	1	2022	157
1670	1	1990	124
1670	3	1990	5
1670	3	2022	15.6215239060584
1671	1	2022	1432
1671	1	1990	1630
1671	3	1990	67
1671	3	2022	118.901319112346
1672	1	2022	151
1672	1	1990	113
1672	3	1990	2
1672	3	2022	13
1673	1	2022	89
1673	1	1990	78
1673	3	1990	10
1673	3	2022	8.39024390243904
1674	1	2022	416
1674	1	1990	365
1674	3	1990	14
1674	3	2022	31.026506986028
1675	1	2022	506
1675	1	1990	408
1675	3	1990	26
1675	3	2022	58.1790287658521
1676	1	2022	215
1676	1	1990	271
1676	3	1990	16
1676	3	2022	27.0133044889129
1677	1	2022	526
1677	1	1990	584
1677	3	1990	29
1677	3	2022	52.4474762156451
1678	1	2022	172
1678	1	1990	153
1678	3	1990	5
1678	3	2022	7.79333333333333
1679	1	2022	32
1679	1	1990	40
1679	3	1990	0
1679	3	2022	3
1680	1	2022	226
1680	1	1990	231
1680	3	1990	15
1680	3	2022	4.05479452054796
1681	1	2022	195
1681	1	1990	222
1681	3	1990	21
1681	3	2022	28
1682	1	2022	496
1682	1	1990	433
1682	3	1990	8
1682	3	2022	34.9466357308585
1683	1	2022	336
1683	1	1990	229
1683	3	1990	10
1683	3	2022	12.2727272727272
1684	1	2022	532
1684	1	1990	372
1684	3	1990	12
1684	3	2022	35
1685	1	2022	85
1685	1	1990	94
1685	3	1990	9
1685	3	2022	8.09876543209878
1686	1	2022	144
1686	1	1990	142
1686	3	1990	14
1686	3	2022	18
1687	1	2022	373
1687	1	1990	310
1687	3	1990	3
1687	3	2022	7.40543133379241
1688	1	2022	1566
1688	1	1990	1593
1688	3	1990	109
1688	3	2022	156.35097412714
1689	1	2022	302
1689	1	1990	313
1689	3	1990	34
1689	3	2022	30
1690	1	2022	584
1690	1	1990	604
1690	3	1990	31
1690	3	2022	40.1666666666668
1691	1	2022	109
1691	1	1990	118
1691	3	1990	2
1691	3	2022	5.55555555555555
1692	1	2022	296
1692	1	1990	304
1692	3	1990	18
1692	3	2022	31
1693	1	2022	70
1693	1	1990	53
1693	3	1990	6
1693	3	2022	4
1694	1	2022	178
1694	1	1990	194
1694	3	1990	14
1694	3	2022	6
1695	1	2022	319
1695	1	1990	286
1695	3	1990	14
1695	3	2022	9.03675213675213
1696	1	2022	141
1696	1	1990	166
1696	3	1990	5
1696	3	2022	9.40902420074239
1697	1	2022	244
1697	1	1990	250
1697	3	1990	5
1697	3	2022	23.345744680851
1698	1	2022	252
1698	1	1990	285
1698	3	1990	7
1698	3	2022	17.9999999999999
1699	1	2022	1157
1699	1	1990	1000
1699	3	1990	37
1699	3	2022	39
1700	1	2022	497
1700	1	1990	559
1700	3	1990	16
1700	3	2022	32.3285124102213
1701	1	2022	166
1701	1	1990	122
1701	3	1990	6
1701	3	2022	5.9047619047619
1702	1	2022	893
1702	1	1990	735
1702	3	1990	10
1702	3	2022	77.4845424121145
1703	1	2022	280
1703	1	1990	180
1703	3	1990	4
1703	3	2022	7.0482411202186
1704	1	2022	279
1704	1	1990	258
1704	3	1990	15
1704	3	2022	14.2010869565217
1705	1	2022	207
1705	1	1990	150
1705	3	1990	10
1705	3	2022	4
1706	1	2022	176
1706	1	1990	108
1706	3	1990	16
1706	3	2022	2.06057098765432
1707	1	2022	482
1707	1	1990	508
1707	3	1990	1
1707	3	2022	29.6510502807124
1708	1	2022	906
1708	1	1990	787
1708	3	1990	43
1708	3	2022	39
1709	1	2022	893
1709	1	1990	523
1709	3	1990	13
1709	3	2022	39.5493878885733
1710	1	2022	243
1710	1	1990	207
1710	3	1990	12
1710	3	2022	21.2695831720222
1711	1	2022	192
1711	1	1990	212
1711	3	1990	16
1711	3	2022	13.078313253012
1712	1	2022	126
1712	1	1990	110
1712	3	1990	9
1712	3	2022	0
1713	1	2022	311
1713	1	1990	280
1713	3	1990	38
1713	3	2022	19
1714	1	2022	132
1714	1	1990	136
1714	3	1990	3
1714	3	2022	6.75694444444444
1715	1	2022	365
1715	1	1990	339
1715	3	1990	14
1715	3	2022	46.3568909578218
1716	1	2022	158
1716	1	1990	111
1716	3	1990	18
1716	3	2022	5.0438596491228
1717	1	2022	543
1717	1	1990	600
1717	3	1990	12
1717	3	2022	52
1718	1	2022	239
1718	1	1990	241
1718	3	1990	22
1718	3	2022	23.1306818181819
1719	1	2022	657
1719	1	1990	586
1719	3	1990	28
1719	3	2022	45
1720	1	2022	145
1720	1	1990	138
1720	3	1990	20
1720	3	2022	12.5583333333334
1721	1	2022	1022
1721	1	1990	938
1721	3	1990	38
1721	3	2022	60.1046698872786
1722	1	2022	1028
1722	1	1990	709
1722	3	1990	22
1722	3	2022	46
1723	1	2022	235
1723	1	1990	258
1723	3	1990	10
1723	3	2022	14.5283255845293
1724	1	2022	146
1724	1	1990	119
1724	3	1990	9
1724	3	2022	9.04512645637966
1725	1	2022	2072
1725	1	1990	1934
1725	3	1990	45
1725	3	2022	78
1726	1	2022	430
1726	1	1990	427
1726	3	1990	27
1726	3	2022	16
1727	1	2022	311
1727	1	1990	233
1727	3	1990	11
1727	3	2022	25.7267441860465
1728	1	2022	138
1728	1	1990	140
1728	3	1990	8
1728	3	2022	11.0924369747899
1729	1	2022	54
1729	1	1990	58
1729	3	1990	4
1729	3	2022	3.87096774193548
1730	1	2022	485
1730	1	1990	394
1730	3	1990	13
1730	3	2022	22.3571428571428
1731	1	2022	944
1731	1	1990	839
1731	3	1990	49
1731	3	2022	65
1732	1	2022	578
1732	1	1990	512
1732	3	1990	46
1732	3	2022	50.4446890486182
1733	1	2022	801
1733	1	1990	855
1733	3	1990	38
1733	3	2022	59.3443579766537
1734	1	2022	184
1734	1	1990	267
1734	3	1990	5
1734	3	2022	16
1735	1	2022	362
1735	1	1990	394
1735	3	1990	28
1735	3	2022	18.5100242868708
1736	1	2022	637
1736	1	1990	559
1736	3	1990	31
1736	3	2022	29.6489663297423
1737	1	2022	728
1737	1	1990	607
1737	3	1990	11
1737	3	2022	46.534413409073
1738	1	2022	203
1738	1	1990	151
1738	3	1990	8
1738	3	2022	3
1739	1	2022	140
1739	1	1990	152
1739	3	1990	4
1739	3	2022	4.04651162790696
1740	1	2022	273
1740	1	1990	303
1740	3	1990	35
1740	3	2022	35.311558767462
1741	1	2022	287
1741	1	1990	264
1741	3	1990	3
1741	3	2022	12.1333333333333
1742	1	2022	489
1742	1	1990	451
1742	3	1990	3
1742	3	2022	34.8370060098343
1743	1	2022	801
1743	1	1990	751
1743	3	1990	42
1743	3	2022	46
1744	1	2022	1619
1744	1	1990	1600
1744	3	1990	41
1744	3	2022	93
1745	1	2022	545
1745	1	1990	665
1745	3	1990	15
1745	3	2022	9.28451090887267
1746	1	2022	334
1746	1	1990	324
1746	3	1990	40
1746	3	2022	8.2691167753409
1747	1	2022	228
1747	1	1990	285
1747	3	1990	23
1747	3	2022	13.0747126436781
1748	1	2022	323
1748	1	1990	292
1748	3	1990	14
1748	3	2022	25.4839285714285
1749	1	2022	299
1749	1	1990	258
1749	3	1990	32
1749	3	2022	20.7460373370905
1750	1	2022	301
1750	1	1990	212
1750	3	1990	19
1750	3	2022	7
1751	1	2022	648
1751	1	1990	364
1751	3	1990	14
1751	3	2022	15.7847683456847
1752	1	2022	1013
1752	1	1990	772
1752	3	1990	17
1752	3	2022	31.4140975543401
1753	1	2022	349
1753	1	1990	372
1753	3	1990	28
1753	3	2022	27.3292682926829
1754	1	2022	150
1754	1	1990	129
1754	3	1990	11
1754	3	2022	15.3947368421052
1755	1	2022	160
1755	1	1990	142
1755	3	1990	5
1755	3	2022	15.2608695652173
1756	1	2022	191
1756	1	1990	218
1756	3	1990	20
1756	3	2022	12
1757	1	2022	187
1757	1	1990	136
1757	3	1990	1
1757	3	2022	0
1758	1	2022	1170
1758	1	1990	1174
1758	3	1990	43
1758	3	2022	52
1759	1	2022	333
1759	1	1990	208
1759	3	1990	1
1759	3	2022	18
1760	1	2022	533
1760	1	1990	555
1760	3	1990	41
1760	3	2022	20.5440154676636
1761	1	2022	277
1761	1	1990	347
1761	3	1990	24
1761	3	2022	18.4955463232776
1762	1	2022	142
1762	1	1990	120
1762	3	1990	7
1762	3	2022	4.04651162790696
1763	1	2022	944
1763	1	1990	771
1763	3	1990	27
1763	3	2022	40.2633054471389
1764	1	2022	428
1764	1	1990	464
1764	3	1990	37
1764	3	2022	24.8888888888889
1765	1	2022	482
1765	1	1990	413
1765	3	1990	21
1765	3	2022	23.8081501831503
1766	1	2022	1801
1766	1	1990	1476
1766	3	1990	44
1766	3	2022	55.5328801124918
1767	1	2022	363
1767	1	1990	452
1767	3	1990	34
1767	3	2022	18.0951830364991
1768	1	2022	376
1768	1	1990	443
1768	3	1990	18
1768	3	2022	14.775817621749
1769	1	2022	1127
1769	1	1990	1289
1769	3	1990	58
1769	3	2022	76.4606060606062
1770	1	2022	560
1770	1	1990	573
1770	3	1990	29
1770	3	2022	40.4646368786158
1771	1	2022	76
1771	1	1990	76
1771	3	1990	6
1771	3	2022	8
1772	1	2022	94
1772	1	1990	109
1772	3	1990	7
1772	3	2022	6.05882352941178
1773	1	2022	502
1773	1	1990	358
1773	3	1990	23
1773	3	2022	14.1569135235231
1774	1	2022	108
1774	1	1990	78
1774	3	1990	7
1774	3	2022	3.955296404276
1775	1	2022	331
1775	1	1990	332
1775	3	1990	8
1775	3	2022	12.096698598312
1776	1	2022	823
1776	1	1990	951
1776	3	1990	41
1776	3	2022	72.5406758448062
1777	1	2022	855
1777	1	1990	605
1777	3	1990	13
1777	3	2022	22.9741793062285
1778	1	2022	149
1778	1	1990	129
1778	3	1990	17
1778	3	2022	10.3658536585366
1779	1	2022	461
1779	1	1990	491
1779	3	1990	31
1779	3	2022	27
1780	1	2022	91
1780	1	1990	55
1780	3	1990	0
1780	3	2022	8.27118644067797
1781	1	2022	283
1781	1	1990	232
1781	3	1990	1
1781	3	2022	14.9155024361355
1782	1	2022	368
1782	1	1990	406
1782	3	1990	26
1782	3	2022	39.2934885931559
1783	1	2022	113
1783	1	1990	118
1783	3	1990	6
1783	3	2022	12.6113964294448
1784	1	2022	212
1784	1	1990	134
1784	3	1990	0
1784	3	2022	12.1509433962264
1785	1	2022	671
1785	1	1990	403
1785	3	1990	35
1785	3	2022	28.3630994152047
1786	1	2022	384
1786	1	1990	302
1786	3	1990	19
1786	3	2022	7
1787	1	2022	220
1787	1	1990	239
1787	3	1990	10
1787	3	2022	24.3597315436242
1788	1	2022	293
1788	1	1990	151
1788	3	1990	11
1788	3	2022	2.00689873259845
1789	1	2022	309
1789	1	1990	204
1789	3	1990	14
1789	3	2022	14.5469252951164
1790	1	2022	238
1790	1	1990	242
1790	3	1990	12
1790	3	2022	16.0969696969698
1791	1	2022	717
1791	1	1990	812
1791	3	1990	18
1791	3	2022	38.1919191919189
1792	1	2022	1184
1792	1	1990	964
1792	3	1990	40
1792	3	2022	126.406596887769
1793	1	2022	77
1793	1	1990	68
1793	3	1990	3
1793	3	2022	8.36923076923078
1794	1	2022	275
1794	1	1990	213
1794	3	1990	18
1794	3	2022	22.1351587773157
1795	1	2022	423
1795	1	1990	468
1795	3	1990	46
1795	3	2022	45
1796	1	2022	8786
1796	1	1990	9909
1796	3	1990	390
1796	3	2022	814.674012822554
1797	1	2022	1050
1797	1	1990	798
1797	3	1990	0
1797	3	2022	29.629191321499
1798	1	2022	364
1798	1	1990	478
1798	3	1990	33
1798	3	2022	16.2416918429003
1799	1	2022	412
1799	1	1990	378
1799	3	1990	31
1799	3	2022	15.6894456313111
1800	1	2022	174
1800	1	1990	107
1800	3	1990	0
1800	3	2022	3
1801	1	2022	205
1801	1	1990	189
1801	3	1990	11
1801	3	2022	3.82758620689655
1802	1	2022	715
1802	1	1990	737
1802	3	1990	70
1802	3	2022	59.2322063094797
1803	1	2022	947
1803	1	1990	853
1803	3	1990	42
1803	3	2022	113.179241381741
1804	1	2022	126
1804	1	1990	122
1804	3	1990	11
1804	3	2022	3.95995995995997
1805	1	2022	204
1805	1	1990	210
1805	3	1990	8
1805	3	2022	10.1639344262295
1806	1	2022	215
1806	1	1990	156
1806	3	1990	4
1806	3	2022	10.3358843537415
1807	1	2022	237
1807	1	1990	139
1807	3	1990	22
1807	3	2022	0.892584279004031
1808	1	2022	77
1808	1	1990	119
1808	3	1990	9
1808	3	2022	13.7391304347826
1809	1	2022	1251
1809	1	1990	799
1809	3	1990	53
1809	3	2022	78.5528044052174
1810	1	2022	256
1810	1	1990	185
1810	3	1990	2
1810	3	2022	3.11229946524063
1811	1	2022	314
1811	1	1990	164
1811	3	1990	1
1811	3	2022	11.1182795698925
1812	1	2022	259
1812	1	1990	227
1812	3	1990	13
1812	3	2022	15.512277918019
1813	1	2022	1079
1813	1	1990	904
1813	3	1990	43
1813	3	2022	38.0134304202329
1814	1	2022	1639
1814	1	1990	1297
1814	3	1990	50
1814	3	2022	58.6351900008509
1815	1	2022	102
1815	1	1990	78
1815	3	1990	15
1815	3	2022	3
1816	1	2022	70
1816	1	1990	72
1816	3	1990	3
1816	3	2022	6.23076923076922
1817	1	2022	1127
1817	1	1990	1011
1817	3	1990	34
1817	3	2022	58.6808916188545
1818	1	2022	405
1818	1	1990	313
1818	3	1990	14
1818	3	2022	15
1819	1	2022	99
1819	1	1990	123
1819	3	1990	23
1819	3	2022	11
1820	1	2022	35
1820	1	1990	47
1820	3	1990	5
1820	3	2022	0
1821	1	2022	6262
1821	1	1990	6004
1821	3	1990	196
1821	3	2022	348.373445868912
1822	1	2022	279
1822	1	1990	309
1822	3	1990	16
1822	3	2022	13.1214953271028
1823	1	2022	443
1823	1	1990	300
1823	3	1990	22
1823	3	2022	15
1824	1	2022	1267
1824	1	1990	1339
1824	3	1990	47
1824	3	2022	138.040838404327
1825	1	2022	2889
1825	1	1990	3590
1825	3	1990	155
1825	3	2022	324.089421450286
1826	1	2022	268
1826	1	1990	257
1826	3	1990	9
1826	3	2022	11
1827	1	2022	1757
1827	1	1990	1377
1827	3	1990	54
1827	3	2022	117.853417873837
1828	1	2022	549
1828	1	1990	695
1828	3	1990	18
1828	3	2022	47.4642163212433
1829	1	2022	638
1829	1	1990	654
1829	3	1990	46
1829	3	2022	22.1314741035857
1830	1	2022	7319
1830	1	1990	6660
1830	3	1990	116
1830	3	2022	350.381609752705
1831	1	2022	629
1831	1	1990	625
1831	3	1990	27
1831	3	2022	35.4069767441859
1832	1	2022	339
1832	1	1990	316
1832	3	1990	21
1832	3	2022	7.39449125668208
1833	1	2022	115
1833	1	1990	123
1833	3	1990	2
1833	3	2022	2.22420097216845
1834	1	2022	261
1834	1	1990	232
1834	3	1990	4
1834	3	2022	23.1360946745563
1835	1	2022	286
1835	1	1990	197
1835	3	1990	25
1835	3	2022	11.3621886394588
1836	1	2022	692
1836	1	1990	665
1836	3	1990	32
1836	3	2022	38.8862820521266
1837	1	2022	357
1837	1	1990	432
1837	3	1990	23
1837	3	2022	38.3923430876988
1838	1	2022	460
1838	1	1990	377
1838	3	1990	11
1838	3	2022	15
1839	1	2022	240
1839	1	1990	230
1839	3	1990	20
1839	3	2022	12.1450980392157
1840	1	2022	1058
1840	1	1990	1068
1840	3	1990	29
1840	3	2022	116.496308486706
1841	1	2022	135
1841	1	1990	185
1841	3	1990	25
1841	3	2022	16
1842	1	2022	36
1842	1	1990	38
1842	3	1990	1
1842	3	2022	2.06060606060606
1843	1	2022	1750
1843	1	1990	1422
1843	3	1990	58
1843	3	2022	49
1844	1	2022	188
1844	1	1990	190
1844	3	1990	8
1844	3	2022	24
1845	1	2022	546
1845	1	1990	706
1845	3	1990	35
1845	3	2022	91.9420289855076
1846	1	2022	325
1846	1	1990	213
1846	3	1990	10
1846	3	2022	2
1847	1	2022	235
1847	1	1990	219
1847	3	1990	7
1847	3	2022	3.31991763071102
1848	1	2022	247
1848	1	1990	192
1848	3	1990	14
1848	3	2022	27.74780224974
1849	1	2022	512
1849	1	1990	620
1849	3	1990	14
1849	3	2022	29.94497489458
1850	1	2022	285
1850	1	1990	252
1850	3	1990	27
1850	3	2022	9.44397515527952
1851	1	2022	870
1851	1	1990	813
1851	3	1990	28
1851	3	2022	86.5375592016529
1852	1	2022	464
1852	1	1990	568
1852	3	1990	52
1852	3	2022	77.8069049061174
1853	1	2022	956
1853	1	1990	735
1853	3	1990	33
1853	3	2022	42.5508196721314
1854	1	2022	671
1854	1	1990	827
1854	3	1990	45
1854	3	2022	73.940781264042
1855	1	2022	893
1855	1	1990	779
1855	3	1990	11
1855	3	2022	40
1856	1	2022	857
1856	1	1990	743
1856	3	1990	17
1856	3	2022	40.0767223065249
1857	1	2022	2030
1857	1	1990	1472
1857	3	1990	58
1857	3	2022	98.991756206023
1858	1	2022	804
1858	1	1990	656
1858	3	1990	61
1858	3	2022	45.3309950082571
1859	1	2022	17298
1859	1	1990	10195
1859	3	1990	182
1859	3	2022	361.047397263372
1860	1	2022	3291
1860	1	1990	2567
1860	3	1990	119
1860	3	2022	120
1861	1	2022	12614
1861	1	1990	7176
1861	3	1990	237
1861	3	2022	477.77535329206
1862	1	2022	896
1862	1	1990	758
1862	3	1990	74
1862	3	2022	46.643832297372
1863	1	2022	1355
1863	1	1990	757
1863	3	1990	8
1863	3	2022	28.6555483089018
1864	1	2022	591
1864	1	1990	471
1864	3	1990	20
1864	3	2022	35
1865	1	2022	10895
1865	1	1990	11770
1865	3	1990	676
1865	3	2022	247.095099077072
1866	1	2022	544
1866	1	1990	304
1866	3	1990	14
1866	3	2022	27.3927272727274
1867	1	2022	6477
1867	1	1990	3911
1867	3	1990	133
1867	3	2022	219.907341383016
1868	1	2022	4040
1868	1	1990	2729
1868	3	1990	52
1868	3	2022	35.1597525202299
1869	1	2022	8623
1869	1	1990	5530
1869	3	1990	37
1869	3	2022	151.515757467379
1870	1	2022	1120
1870	1	1990	895
1870	3	1990	41
1870	3	2022	17.232575126473
1871	1	2022	2058
1871	1	1990	1819
1871	3	1990	58
1871	3	2022	61
1872	1	2022	436
1872	1	1990	444
1872	3	1990	10
1872	3	2022	17.4155401775472
1873	1	2022	301
1873	1	1990	206
1873	3	1990	4
1873	3	2022	13.5339876408578
1874	1	2022	3744
1874	1	1990	2424
1874	3	1990	68
1874	3	2022	88.6849630432266
1875	1	2022	9550
1875	1	1990	2981
1875	3	1990	104
1875	3	2022	466.205433467946
1876	1	2022	137
1876	1	1990	112
1876	3	1990	9
1876	3	2022	5
1877	1	2022	1046
1877	1	1990	669
1877	3	1990	24
1877	3	2022	20
1878	1	2022	3108
1878	1	1990	1620
1878	3	1990	43
1878	3	2022	64.5124767682015
1879	1	2022	1402
1879	1	1990	696
1879	3	1990	11
1879	3	2022	16.7406899236564
1880	1	2022	287
1880	1	1990	144
1880	3	1990	11
1880	3	2022	6
1881	1	2022	443
1881	1	1990	221
1881	3	1990	14
1881	3	2022	17
1882	1	2022	520
1882	1	1990	272
1882	3	1990	12
1882	3	2022	10
1883	1	2022	277
1883	1	1990	234
1883	3	1990	22
1883	3	2022	12
1884	1	2022	1204
1884	1	1990	749
1884	3	1990	16
1884	3	2022	44
1885	1	2022	5713
1885	1	1990	2584
1885	3	1990	39
1885	3	2022	100.464149545489
1886	1	2022	2061
1886	1	1990	2058
1886	3	1990	66
1886	3	2022	111.254059639799
1887	1	2022	131
1887	1	1990	92
1887	3	1990	2
1887	3	2022	2
1888	1	2022	8132
1888	1	1990	6472
1888	3	1990	135
1888	3	2022	191.029519771159
1889	1	2022	936
1889	1	1990	633
1889	3	1990	17
1889	3	2022	33.3087367913092
1890	1	2022	455
1890	1	1990	447
1890	3	1990	21
1890	3	2022	22.2017114142725
1891	1	2022	737
1891	1	1990	747
1891	3	1990	15
1891	3	2022	42.0238385555224
1892	1	2022	4819
1892	1	1990	4379
1892	3	1990	238
1892	3	2022	326.952080250013
1893	1	2022	2466
1893	1	1990	1803
1893	3	1990	28
1893	3	2022	56.0152701906579
1894	1	2022	897
1894	1	1990	913
1894	3	1990	41
1894	3	2022	57.5969907804527
1895	1	2022	30968
1895	1	1990	22604
1895	3	1990	553
1895	3	2022	1060.60640224899
1896	1	2022	1257
1896	1	1990	910
1896	3	1990	45
1896	3	2022	29.156202316149
1897	1	2022	6205
1897	1	1990	2626
1897	3	1990	89
1897	3	2022	274.120992342257
1898	1	2022	326
1898	1	1990	134
1898	3	1990	5
1898	3	2022	12.3694452016694
1899	1	2022	211
1899	1	1990	187
1899	3	1990	6
1899	3	2022	17
1900	1	2022	330
1900	1	1990	325
1900	3	1990	11
1900	3	2022	14
1901	1	2022	1134
1901	1	1990	1020
1901	3	1990	53
1901	3	2022	40.7160878482219
1902	1	2022	1833
1902	1	1990	1490
1902	3	1990	78
1902	3	2022	87.5526237480325
1903	1	2022	292
1903	1	1990	142
1903	3	1990	3
1903	3	2022	7.36097620866527
1904	1	2022	2608
1904	1	1990	1611
1904	3	1990	13
1904	3	2022	57.5066189937514
1905	1	2022	670
1905	1	1990	384
1905	3	1990	9
1905	3	2022	12.4897249622323
1906	1	2022	11303
1906	1	1990	5908
1906	3	1990	95
1906	3	2022	239.776113782437
1907	1	2022	1163
1907	1	1990	809
1907	3	1990	17
1907	3	2022	49.8314084369184
1908	1	2022	236
1908	1	1990	180
1908	3	1990	7
1908	3	2022	9.43008849557521
1909	1	2022	320
1909	1	1990	203
1909	3	1990	11
1909	3	2022	8.82304263290179
1910	1	2022	449
1910	1	1990	403
1910	3	1990	51
1910	3	2022	32
1911	1	2022	16786
1911	1	1990	12843
1911	3	1990	165
1911	3	2022	279.264670811349
1912	1	2022	955
1912	1	1990	701
1912	3	1990	54
1912	3	2022	40
1913	1	2022	5017
1913	1	1990	4286
1913	3	1990	264
1913	3	2022	544
1914	1	2022	311
1914	1	1990	201
1914	3	1990	15
1914	3	2022	6.00000000000001
1915	1	2022	450
1915	1	1990	446
1915	3	1990	26
1915	3	2022	29.9377413127413
1916	1	2022	1048
1916	1	1990	679
1916	3	1990	10
1916	3	2022	24.9365579653612
1917	1	2022	802
1917	1	1990	618
1917	3	1990	22
1917	3	2022	32.468908337172
1918	1	2022	265328
1918	1	1990	210336
1918	3	1990	14622
1918	3	2022	12025.7282708849
1919	1	2022	45
1919	1	1990	55
1919	3	1990	5
1919	3	2022	5.11111111111111
1920	1	2022	3806
1920	1	1990	2841
1920	3	1990	36
1920	3	2022	76
1921	1	2022	99
1921	1	1990	119
1921	3	1990	16
1921	3	2022	9
1922	1	2022	2264
1922	1	1990	2158
1922	3	1990	145
1922	3	2022	204.137163751235
1923	1	2022	100
1923	1	1990	99
1923	3	1990	8
1923	3	2022	4.06779661016948
1924	1	2022	24262
1924	1	1990	21538
1924	3	1990	809
1924	3	2022	965.167980188176
1925	1	2022	881
1925	1	1990	188
1925	3	1990	11
1925	3	2022	16
1926	1	2022	1302
1926	1	1990	875
1926	3	1990	29
1926	3	2022	96.281524926686
1927	1	2022	259
1927	1	1990	193
1927	3	1990	5
1927	3	2022	5.69281045751635
1928	1	2022	1524
1928	1	1990	1260
1928	3	1990	132
1928	3	2022	192.750556792873
1929	1	2022	199
1929	1	1990	136
1929	3	1990	5
1929	3	2022	4
1930	1	2022	20382
1930	1	1990	8753
1930	3	1990	232
1930	3	2022	588.096285711974
1931	1	2022	826
1931	1	1990	666
1931	3	1990	24
1931	3	2022	21.6862152779981
1932	1	2022	2400
1932	1	1990	1123
1932	3	1990	45
1932	3	2022	44
1933	1	2022	512
1933	1	1990	341
1933	3	1990	13
1933	3	2022	13.1032257386957
1934	1	2022	345
1934	1	1990	263
1934	3	1990	3
1934	3	2022	4.93243243243244
1935	1	2022	6784
1935	1	1990	4137
1935	3	1990	50
1935	3	2022	128.334516894546
1936	1	2022	2727
1936	1	1990	2582
1936	3	1990	175
1936	3	2022	232.515599083138
1937	1	2022	1341
1937	1	1990	899
1937	3	1990	20
1937	3	2022	29.2331980691773
1938	1	2022	1034
1938	1	1990	743
1938	3	1990	17
1938	3	2022	21.2806483935596
1939	1	2022	1853
1939	1	1990	1035
1939	3	1990	30
1939	3	2022	50.8201987608813
1940	1	2022	3145
1940	1	1990	1932
1940	3	1990	33
1940	3	2022	63
1941	1	2022	351
1941	1	1990	232
1941	3	1990	10
1941	3	2022	16.4583650914634
1942	1	2022	418
1942	1	1990	388
1942	3	1990	19
1942	3	2022	33.6617776953454
1943	1	2022	620
1943	1	1990	379
1943	3	1990	15
1943	3	2022	31.2751869257382
1944	1	2022	520
1944	1	1990	427
1944	3	1990	16
1944	3	2022	31.5537848605578
1945	1	2022	5836
1945	1	1990	4976
1945	3	1990	33
1945	3	2022	93
1946	1	2022	798
1946	1	1990	602
1946	3	1990	26
1946	3	2022	34.3888146167557
1947	1	2022	243
1947	1	1990	188
1947	3	1990	13
1947	3	2022	15
1948	1	2022	1382
1948	1	1990	1707
1948	3	1990	43
1948	3	2022	91.3815436589739
1949	1	2022	8342
1949	1	1990	5842
1949	3	1990	70
1949	3	2022	115.387123192866
1950	1	2022	2415
1950	1	1990	1503
1950	3	1990	68
1950	3	2022	95.803228285934
1951	1	2022	511
1951	1	1990	369
1951	3	1990	5
1951	3	2022	19.1610169491526
1952	1	2022	4312
1952	1	1990	2867
1952	3	1990	23
1952	3	2022	93.7800713938837
1953	1	2022	1219
1953	1	1990	1186
1953	3	1990	62
1953	3	2022	46.3221259204854
1954	1	2022	1297
1954	1	1990	829
1954	3	1990	52
1954	3	2022	56.227503134373
1955	1	2022	369
1955	1	1990	395
1955	3	1990	20
1955	3	2022	21.0967741935485
1956	1	2022	51
1956	1	1990	64
1956	3	1990	2
1956	3	2022	10.6666666666667
1957	1	2022	4850
1957	1	1990	2773
1957	3	1990	81
1957	3	2022	111.330627802302
1958	1	2022	203
1958	1	1990	198
1958	3	1990	6
1958	3	2022	11
1959	1	2022	1539
1959	1	1990	1170
1959	3	1990	40
1959	3	2022	67
1960	1	2022	3320
1960	1	1990	3020
1960	3	1990	196
1960	3	2022	363
1961	1	2022	2689
1961	1	1990	1349
1961	3	1990	22
1961	3	2022	37
1962	1	2022	1096
1962	1	1990	945
1962	3	1990	27
1962	3	2022	79.5712533237962
1963	1	2022	134
1963	1	1990	138
1963	3	1990	8
1963	3	2022	8
1964	1	2022	144
1964	1	1990	110
1964	3	1990	4
1964	3	2022	8.19753086419752
1965	1	2022	2368
1965	1	1990	1135
1965	3	1990	42
1965	3	2022	120.732976022868
1966	1	2022	255
1966	1	1990	177
1966	3	1990	17
1966	3	2022	16.103874351932
1967	1	2022	402
1967	1	1990	211
1967	3	1990	6
1967	3	2022	15.4639175257732
1968	1	2022	212
1968	1	1990	212
1968	3	1990	19
1968	3	2022	14.3021582733812
1969	1	2022	2151
1969	1	1990	1700
1969	3	1990	31
1969	3	2022	33.4968682015079
1970	1	2022	26784
1970	1	1990	21363
1970	3	1990	583
1970	3	2022	927.632337779392
1971	1	2022	2131
1971	1	1990	1319
1971	3	1990	36
1971	3	2022	69
1972	1	2022	198
1972	1	1990	179
1972	3	1990	5
1972	3	2022	2
1973	1	2022	16757
1973	1	1990	16768
1973	3	1990	109
1973	3	2022	194.762418662139
1974	1	2022	2740
1974	1	1990	1580
1974	3	1990	53
1974	3	2022	34.756448670179
1975	1	2022	733
1975	1	1990	562
1975	3	1990	29
1975	3	2022	26.9230769230768
1976	1	2022	2310
1976	1	1990	1472
1976	3	1990	66
1976	3	2022	93.9023133178152
1977	1	2022	791
1977	1	1990	603
1977	3	1990	14
1977	3	2022	28
1978	1	2022	211
1978	1	1990	206
1978	3	1990	8
1978	3	2022	11.6190476190476
1979	1	2022	636
1979	1	1990	510
1979	3	1990	13
1979	3	2022	63.6253101736975
1980	1	2022	150
1980	1	1990	143
1980	3	1990	2
1980	3	2022	8
1981	1	2022	1077
1981	1	1990	583
1981	3	1990	2
1981	3	2022	18.9866223374281
1982	1	2022	217
1982	1	1990	164
1982	3	1990	11
1982	3	2022	14.3642225221173
1983	1	2022	538
1983	1	1990	399
1983	3	1990	11
1983	3	2022	15.2784058790277
1984	1	2022	70
1984	1	1990	108
1984	3	1990	7
1984	3	2022	9
1985	1	2022	268
1985	1	1990	195
1985	3	1990	18
1985	3	2022	17.2658486707567
1986	1	2022	122
1986	1	1990	93
1986	3	1990	6
1986	3	2022	1
1987	1	2022	243
1987	1	1990	230
1987	3	1990	18
1987	3	2022	16
1988	1	2022	224
1988	1	1990	138
1988	3	1990	23
1988	3	2022	11.882533420995
1989	1	2022	8695
1989	1	1990	6689
1989	3	1990	280
1989	3	2022	308.887181939112
1990	1	2022	92
1990	1	1990	70
1990	3	1990	2
1990	3	2022	6.38297872340426
1991	1	2022	4863
1991	1	1990	2508
1991	3	1990	51
1991	3	2022	123.946719461897
1992	1	2022	733
1992	1	1990	349
1992	3	1990	13
1992	3	2022	14.3277591973244
1993	1	2022	1877
1993	1	1990	1045
1993	3	1990	32
1993	3	2022	34.7732236189019
1994	1	2022	2637
1994	1	1990	1701
1994	3	1990	51
1994	3	2022	59.7601935262189
1995	1	2022	790
1995	1	1990	519
1995	3	1990	23
1995	3	2022	18.7205387205387
1996	1	2022	666
1996	1	1990	451
1996	3	1990	8
1996	3	2022	9.13611599795695
1997	1	2022	2326
1997	1	1990	1318
1997	3	1990	47
1997	3	2022	63.0515641087292
1998	1	2022	470
1998	1	1990	361
1998	3	1990	22
1998	3	2022	1.42671130952381
1999	1	2022	92
1999	1	1990	60
1999	3	1990	7
1999	3	2022	9
2000	1	2022	147
2000	1	1990	123
2000	3	1990	19
2000	3	2022	3.08472222222222
2001	1	2022	335
2001	1	1990	248
2001	3	1990	30
2001	3	2022	24.1621621621622
2002	1	2022	929
2002	1	1990	780
2002	3	1990	19
2002	3	2022	43
2003	1	2022	123
2003	1	1990	124
2003	3	1990	9
2003	3	2022	11.3975903614457
2004	1	2022	278
2004	1	1990	212
2004	3	1990	9
2004	3	2022	17.603831679781
2005	1	2022	2172
2005	1	1990	1731
2005	3	1990	100
2005	3	2022	144.365184174491
2006	1	2022	167
2006	1	1990	172
2006	3	1990	11
2006	3	2022	9.08571428571429
2007	1	2022	276
2007	1	1990	262
2007	3	1990	4
2007	3	2022	10.1538461538462
2008	1	2022	748
2008	1	1990	435
2008	3	1990	16
2008	3	2022	10
2009	1	2022	245
2009	1	1990	194
2009	3	1990	5
2009	3	2022	9.21951219512196
2010	1	2022	1598
2010	1	1990	1294
2010	3	1990	94
2010	3	2022	128.872444015996
2011	1	2022	591
2011	1	1990	526
2011	3	1990	19
2011	3	2022	29.4594224239051
2012	1	2022	755
2012	1	1990	596
2012	3	1990	25
2012	3	2022	50
2013	1	2022	24436
2013	1	1990	16391
2013	3	1990	224
2013	3	2022	597.101150136659
2014	1	2022	423
2014	1	1990	299
2014	3	1990	11
2014	3	2022	12
2015	1	2022	1634
2015	1	1990	1185
2015	3	1990	16
2015	3	2022	59.4149192543088
2016	1	2022	3504
2016	1	1990	2032
2016	3	1990	17
2016	3	2022	123
2017	1	2022	501
2017	1	1990	379
2017	3	1990	23
2017	3	2022	22.3213122965189
2018	1	2022	17939
2018	1	1990	16834
2018	3	1990	395
2018	3	2022	627.619044491163
2019	1	2022	598
2019	1	1990	466
2019	3	1990	18
2019	3	2022	33.9292981747544
2020	1	2022	106
2020	1	1990	85
2020	3	1990	10
2020	3	2022	4.375
2021	1	2022	746
2021	1	1990	715
2021	3	1990	17
2021	3	2022	19
2022	1	2022	223
2022	1	1990	136
2022	3	1990	3
2022	3	2022	8
2023	1	2022	265
2023	1	1990	250
2023	3	1990	17
2023	3	2022	7.00000000000003
2024	1	2022	178
2024	1	1990	172
2024	3	1990	6
2024	3	2022	11.0909090909091
2025	1	2022	1120
2025	1	1990	1067
2025	3	1990	58
2025	3	2022	55.7136693548392
2026	1	2022	785
2026	1	1990	687
2026	3	1990	38
2026	3	2022	46.8667647161806
2027	1	2022	363
2027	1	1990	273
2027	3	1990	30
2027	3	2022	18.5806451612903
2028	1	2022	2376
2028	1	1990	1773
2028	3	1990	40
2028	3	2022	129.29986578857
2029	1	2022	370
2029	1	1990	363
2029	3	1990	7
2029	3	2022	17
2030	1	2022	3109
2030	1	1990	2514
2030	3	1990	50
2030	3	2022	116.88419655807
2031	1	2022	202
2031	1	1990	152
2031	3	1990	11
2031	3	2022	3.61531986531987
2032	1	2022	277
2032	1	1990	295
2032	3	1990	14
2032	3	2022	15.1704545454546
2033	1	2022	737
2033	1	1990	809
2033	3	1990	48
2033	3	2022	29.5891613990608
2034	1	2022	1537
2034	1	1990	898
2034	3	1990	13
2034	3	2022	50.6630999924646
2035	1	2022	551
2035	1	1990	465
2035	3	1990	34
2035	3	2022	35
2036	1	2022	2026
2036	1	1990	1153
2036	3	1990	52
2036	3	2022	57.8395882267159
2037	1	2022	679
2037	1	1990	752
2037	3	1990	70
2037	3	2022	58.2132495612033
2038	1	2022	1340
2038	1	1990	1091
2038	3	1990	55
2038	3	2022	69.9876361877992
2039	1	2022	184
2039	1	1990	172
2039	3	1990	2
2039	3	2022	7.12389380530975
2040	1	2022	436
2040	1	1990	358
2040	3	1990	15
2040	3	2022	16.7351496604039
2041	1	2022	107
2041	1	1990	76
2041	3	1990	11
2041	3	2022	8.13777777777778
2042	1	2022	523
2042	1	1990	367
2042	3	1990	16
2042	3	2022	36
2043	1	2022	26186
2043	1	1990	21727
2043	3	1990	537
2043	3	2022	528.141959304361
2044	1	2022	1545
2044	1	1990	617
2044	3	1990	37
2044	3	2022	37.7047619047618
2045	1	2022	688
2045	1	1990	613
2045	3	1990	29
2045	3	2022	40.3968253968253
2046	1	2022	1209
2046	1	1990	1063
2046	3	1990	56
2046	3	2022	65.8554446137487
2047	1	2022	173
2047	1	1990	150
2047	3	1990	12
2047	3	2022	4.52906976744187
2048	1	2022	454
2048	1	1990	372
2048	3	1990	8
2048	3	2022	10.3386757703416
2049	1	2022	1637
2049	1	1990	1403
2049	3	1990	77
2049	3	2022	81
2050	1	2022	22643
2050	1	1990	11433
2050	3	1990	233
2050	3	2022	675.72156489727
2051	1	2022	11499
2051	1	1990	6974
2051	3	1990	139
2051	3	2022	216.530652668912
2052	1	2022	843
2052	1	1990	729
2052	3	1990	23
2052	3	2022	40.5673758865249
2053	1	2022	1530
2053	1	1990	721
2053	3	1990	27
2053	3	2022	66.7263198963746
2054	1	2022	4028
2054	1	1990	2072
2054	3	1990	101
2054	3	2022	227.837716003005
2055	1	2022	565
2055	1	1990	438
2055	3	1990	14
2055	3	2022	21.5675675675678
2056	1	2022	1403
2056	1	1990	1158
2056	3	1990	43
2056	3	2022	84.8249961362628
2057	1	2022	516
2057	1	1990	541
2057	3	1990	17
2057	3	2022	15.1242570198812
2058	1	2022	6347
2058	1	1990	3361
2058	3	1990	55
2058	3	2022	93.3115309778807
2059	1	2022	982
2059	1	1990	836
2059	3	1990	44
2059	3	2022	70.0650970127737
2060	1	2022	273
2060	1	1990	218
2060	3	1990	14
2060	3	2022	13.0844155844156
2061	1	2022	218
2061	1	1990	200
2061	3	1990	27
2061	3	2022	12.5780098280098
2062	1	2022	616
2062	1	1990	695
2062	3	1990	19
2062	3	2022	25.1943752028925
2063	1	2022	134
2063	1	1990	87
2063	3	1990	7
2063	3	2022	10
2064	1	2022	4423
2064	1	1990	2846
2064	3	1990	53
2064	3	2022	173.428389296812
2065	1	2022	5389
2065	1	1990	2405
2065	3	1990	88
2065	3	2022	123.345537472909
2066	1	2022	187
2066	1	1990	165
2066	3	1990	4
2066	3	2022	7.14
2067	1	2022	178
2067	1	1990	115
2067	3	1990	6
2067	3	2022	4
2068	1	2022	1591
2068	1	1990	1238
2068	3	1990	51
2068	3	2022	53
2069	1	2022	2739
2069	1	1990	1797
2069	3	1990	23
2069	3	2022	56.7798002425659
2070	1	2022	1335
2070	1	1990	893
2070	3	1990	52
2070	3	2022	48.7963649326766
2071	1	2022	1119
2071	1	1990	1003
2071	3	1990	39
2071	3	2022	62.6642857142855
2072	1	2022	631
2072	1	1990	715
2072	3	1990	20
2072	3	2022	25.2068085409432
2073	1	2022	228
2073	1	1990	193
2073	3	1990	17
2073	3	2022	9.44480769230769
2074	1	2022	102
2074	1	1990	115
2074	3	1990	13
2074	3	2022	8.41025641025641
2075	1	2022	2245
2075	1	1990	1418
2075	3	1990	55
2075	3	2022	63.2833898720062
2076	1	2022	2210
2076	1	1990	2024
2076	3	1990	52
2076	3	2022	112
2077	1	2022	7523
2077	1	1990	5842
2077	3	1990	123
2077	3	2022	476.292898865195
2078	1	2022	671
2078	1	1990	610
2078	3	1990	36
2078	3	2022	15.1331360946745
2079	1	2022	7315
2079	1	1990	3734
2079	3	1990	57
2079	3	2022	180.565159156676
2080	1	2022	545
2080	1	1990	476
2080	3	1990	10
2080	3	2022	22
2081	1	2022	288
2081	1	1990	253
2081	3	1990	16
2081	3	2022	5.0347222222222
2082	1	2022	41
2082	1	1990	40
2082	3	1990	8
2082	3	2022	3
2083	1	2022	2808
2083	1	1990	1679
2083	3	1990	53
2083	3	2022	97
2084	1	2022	3699
2084	1	1990	3142
2084	3	1990	54
2084	3	2022	156
2085	1	2022	229
2085	1	1990	171
2085	3	1990	4
2085	3	2022	15.8506760728983
2086	1	2022	8051
2086	1	1990	5564
2086	3	1990	131
2086	3	2022	224.504745364675
2087	1	2022	880
2087	1	1990	454
2087	3	1990	28
2087	3	2022	27.993410711188
2088	1	2022	10723
2088	1	1990	8008
2088	3	1990	86
2088	3	2022	178.392169510419
2089	1	2022	491
2089	1	1990	360
2089	3	1990	27
2089	3	2022	28.9036240541617
2090	1	2022	5862
2090	1	1990	4661
2090	3	1990	178
2090	3	2022	383
2091	1	2022	590
2091	1	1990	594
2091	3	1990	29
2091	3	2022	19
2092	1	2022	558
2092	1	1990	503
2092	3	1990	41
2092	3	2022	34.7941176470588
2093	1	2022	24668
2093	1	1990	21012
2093	3	1990	1267
2093	3	2022	1373.98166371478
2094	1	2022	403
2094	1	1990	236
2094	3	1990	7
2094	3	2022	13
2095	1	2022	834
2095	1	1990	722
2095	3	1990	9
2095	3	2022	36.6002616309601
2096	1	2022	140
2096	1	1990	123
2096	3	1990	14
2096	3	2022	11.2558139534884
2097	1	2022	137
2097	1	1990	111
2097	3	1990	10
2097	3	2022	5
2098	1	2022	2801
2098	1	1990	1821
2098	3	1990	75
2098	3	2022	103
2099	1	2022	24654
2099	1	1990	21591
2099	3	1990	608
2099	3	2022	584.823113537595
2100	1	2022	314
2100	1	1990	315
2100	3	1990	12
2100	3	2022	11.3850837138508
2101	1	2022	697
2101	1	1990	425
2101	3	1990	14
2101	3	2022	13.0644976515065
2102	1	2022	940
2102	1	1990	348
2102	3	1990	5
2102	3	2022	8.90633032868355
2103	1	2022	1087
2103	1	1990	990
2103	3	1990	58
2103	3	2022	48
2104	1	2022	545
2104	1	1990	319
2104	3	1990	3
2104	3	2022	13.8437632135306
2105	1	2022	244
2105	1	1990	199
2105	3	1990	15
2105	3	2022	3.02040816326532
2106	1	2022	5466
2106	1	1990	2837
2106	3	1990	43
2106	3	2022	121.8771544891
2107	1	2022	433
2107	1	1990	290
2107	3	1990	20
2107	3	2022	9
2108	1	2022	319
2108	1	1990	255
2108	3	1990	11
2108	3	2022	6.26778824029166
2109	1	2022	1391
2109	1	1990	1026
2109	3	1990	26
2109	3	2022	32.539560519619
2110	1	2022	1137
2110	1	1990	476
2110	3	1990	18
2110	3	2022	39.7003802073558
2111	1	2022	1146
2111	1	1990	1414
2111	3	1990	87
2111	3	2022	87
2112	1	2022	4575
2112	1	1990	2648
2112	3	1990	74
2112	3	2022	100.423738177301
2113	1	2022	297
2113	1	1990	136
2113	3	1990	8
2113	3	2022	2.01652459016393
2114	1	2022	1059
2114	1	1990	818
2114	3	1990	35
2114	3	2022	31
2115	1	2022	839
2115	1	1990	527
2115	3	1990	19
2115	3	2022	23.6475701974744
2116	1	2022	2844
2116	1	1990	2584
2116	3	1990	80
2116	3	2022	165.096146052909
2117	1	2022	373
2117	1	1990	380
2117	3	1990	19
2117	3	2022	23.6085510843223
2118	1	2022	191
2118	1	1990	83
2118	3	1990	3
2118	3	2022	4.79166666666667
2119	1	2022	211
2119	1	1990	158
2119	3	1990	18
2119	3	2022	9.81436642453592
2120	1	2022	1237
2120	1	1990	806
2120	3	1990	25
2120	3	2022	27.4035707713423
2121	1	2022	7959
2121	1	1990	5732
2121	3	1990	38
2121	3	2022	167
2122	1	2022	3581
2122	1	1990	1652
2122	3	1990	26
2122	3	2022	70.9839600432569
2123	1	2022	99
2123	1	1990	92
2123	3	1990	10
2123	3	2022	10.1666666666667
2124	1	2022	137
2124	1	1990	138
2124	3	1990	7
2124	3	2022	2.02020202020203
2125	1	2022	217
2125	1	1990	268
2125	3	1990	31
2125	3	2022	18.8315326130452
2126	1	2022	228
2126	1	1990	230
2126	3	1990	12
2126	3	2022	12
2127	1	2022	781
2127	1	1990	453
2127	3	1990	12
2127	3	2022	18.888727580974
2128	1	2022	545
2128	1	1990	402
2128	3	1990	17
2128	3	2022	30.7920861018162
2129	1	2022	77136
2129	1	1990	57273
2129	3	1990	1709
2129	3	2022	1496.01035378191
2130	1	2022	299
2130	1	1990	295
2130	3	1990	21
2130	3	2022	10
2131	1	2022	223
2131	1	1990	172
2131	3	1990	0
2131	3	2022	6
2132	1	2022	11756
2132	1	1990	3786
2132	3	1990	96
2132	3	2022	201.182739093124
2133	1	2022	465
2133	1	1990	363
2133	3	1990	19
2133	3	2022	17.0865501828525
2134	1	2022	656
2134	1	1990	531
2134	3	1990	12
2134	3	2022	34.741323246121
2135	1	2022	278
2135	1	1990	257
2135	3	1990	5
2135	3	2022	14.3500000000001
2136	1	2022	1585
2136	1	1990	1537
2136	3	1990	59
2136	3	2022	128.281066353569
2137	1	2022	1520
2137	1	1990	1802
2137	3	1990	67
2137	3	2022	129.665482170158
2138	1	2022	171
2138	1	1990	160
2138	3	1990	8
2138	3	2022	5.55555555555556
2139	1	2022	134
2139	1	1990	100
2139	3	1990	4
2139	3	2022	8.72727272727273
2140	1	2022	3506
2140	1	1990	1903
2140	3	1990	32
2140	3	2022	72.1859911855763
2141	1	2022	531
2141	1	1990	505
2141	3	1990	15
2141	3	2022	27
2142	1	2022	89
2142	1	1990	72
2142	3	1990	5
2142	3	2022	3.14035087719299
2143	1	2022	1022
2143	1	1990	915
2143	3	1990	51
2143	3	2022	56.5261639711545
2144	1	2022	1917
2144	1	1990	1326
2144	3	1990	58
2144	3	2022	105.865496420777
2145	1	2022	1056
2145	1	1990	866
2145	3	1990	24
2145	3	2022	31.5344490233256
2146	1	2022	389
2146	1	1990	341
2146	3	1990	13
2146	3	2022	20.6116388215836
2147	1	2022	1102
2147	1	1990	650
2147	3	1990	31
2147	3	2022	47.6093294460643
2148	1	2022	612
2148	1	1990	520
2148	3	1990	24
2148	3	2022	28.4033685644429
2149	1	2022	324
2149	1	1990	463
2149	3	1990	33
2149	3	2022	33.1486247637052
2150	1	2022	838
2150	1	1990	1036
2150	3	1990	14
2150	3	2022	26.9999999999999
2151	1	2022	147
2151	1	1990	118
2151	3	1990	12
2151	3	2022	13.268817204301
2152	1	2022	506
2152	1	1990	312
2152	3	1990	29
2152	3	2022	28.2196078431372
2153	1	2022	559
2153	1	1990	252
2153	3	1990	19
2153	3	2022	4.37739401415311
2154	1	2022	1698
2154	1	1990	858
2154	3	1990	33
2154	3	2022	58.5922444576128
2155	1	2022	289
2155	1	1990	206
2155	3	1990	13
2155	3	2022	12.1185105621196
2156	1	2022	487
2156	1	1990	418
2156	3	1990	16
2156	3	2022	34
2157	1	2022	188
2157	1	1990	112
2157	3	1990	3
2157	3	2022	5.37728937728937
2158	1	2022	1192
2158	1	1990	934
2158	3	1990	56
2158	3	2022	64.722882181045
2159	1	2022	10407
2159	1	1990	5481
2159	3	1990	76
2159	3	2022	183.696017778982
2160	1	2022	5165
2160	1	1990	5670
2160	3	1990	306
2160	3	2022	352.464641485651
2161	1	2022	1633
2161	1	1990	1118
2161	3	1990	52
2161	3	2022	47.8993994652274
2162	1	2022	899
2162	1	1990	1046
2162	3	1990	62
2162	3	2022	127.401263823065
2163	1	2022	1185
2163	1	1990	864
2163	3	1990	17
2163	3	2022	50.7811533711006
2164	1	2022	66874
2164	1	1990	51055
2164	3	1990	1161
2164	3	2022	1280.19675738759
2165	1	2022	446
2165	1	1990	471
2165	3	1990	22
2165	3	2022	38.9925027423332
2166	1	2022	738
2166	1	1990	565
2166	3	1990	15
2166	3	2022	23
2167	1	2022	2191
2167	1	1990	1039
2167	3	1990	19
2167	3	2022	41.52483211789
2168	1	2022	7198
2168	1	1990	5078
2168	3	1990	46
2168	3	2022	88.0485344207161
2169	1	2022	967
2169	1	1990	517
2169	3	1990	23
2169	3	2022	23.6424076018197
2170	1	2022	4447
2170	1	1990	3512
2170	3	1990	87
2170	3	2022	255.704221137618
2171	1	2022	942
2171	1	1990	964
2171	3	1990	38
2171	3	2022	47.4346249708987
2172	1	2022	220
2172	1	1990	191
2172	3	1990	9
2172	3	2022	12.0251851851852
2173	1	2022	3300
2173	1	1990	2261
2173	3	1990	72
2173	3	2022	170.884785523868
2174	1	2022	608
2174	1	1990	867
2174	3	1990	62
2174	3	2022	62
2175	1	2022	275
2175	1	1990	206
2175	3	1990	7
2175	3	2022	14.3134328358209
2176	1	2022	3485
2176	1	1990	2355
2176	3	1990	23
2176	3	2022	72.9870683746575
2177	1	2022	456
2177	1	1990	361
2177	3	1990	18
2177	3	2022	16
2178	1	2022	876
2178	1	1990	668
2178	3	1990	25
2178	3	2022	32.5217313289398
2179	1	2022	3418
2179	1	1990	1230
2179	3	1990	40
2179	3	2022	134.408367064403
2180	1	2022	2638
2180	1	1990	2008
2180	3	1990	33
2180	3	2022	121
2181	1	2022	617
2181	1	1990	371
2181	3	1990	4
2181	3	2022	5
2182	1	2022	1059
2182	1	1990	985
2182	3	1990	52
2182	3	2022	61
2183	1	2022	2140
2183	1	1990	1992
2183	3	1990	123
2183	3	2022	133.177172980946
2184	1	2022	1457
2184	1	1990	1268
2184	3	1990	26
2184	3	2022	53.5903557097191
2185	1	2022	2417
2185	1	1990	1875
2185	3	1990	46
2185	3	2022	101.294269114547
2186	1	2022	828
2186	1	1990	1038
2186	3	1990	55
2186	3	2022	74.9269435914014
2187	1	2022	924
2187	1	1990	649
2187	3	1990	24
2187	3	2022	34.1201438145842
2188	1	2022	522
2188	1	1990	573
2188	3	1990	23
2188	3	2022	38
2189	1	2022	394
2189	1	1990	281
2189	3	1990	5
2189	3	2022	10
2190	1	2022	411
2190	1	1990	330
2190	3	1990	17
2190	3	2022	26.5473684210526
2191	1	2022	309
2191	1	1990	244
2191	3	1990	24
2191	3	2022	21
2192	1	2022	1357
2192	1	1990	1129
2192	3	1990	61
2192	3	2022	45.8369803063458
2193	1	2022	2216
2193	1	1990	1866
2193	3	1990	43
2193	3	2022	49.2269424743413
2194	1	2022	1253
2194	1	1990	978
2194	3	1990	38
2194	3	2022	85.6674680142606
2195	1	2022	1626
2195	1	1990	1263
2195	3	1990	58
2195	3	2022	93.5735461801598
2196	1	2022	4441
2196	1	1990	4273
2196	3	1990	334
2196	3	2022	306.415067971959
2197	1	2022	196
2197	1	1990	188
2197	3	1990	15
2197	3	2022	14
2198	1	2022	195
2198	1	1990	164
2198	3	1990	8
2198	3	2022	14
2199	1	2022	1483
2199	1	1990	1379
2199	3	1990	50
2199	3	2022	62.1528962743669
2200	1	2022	412
2200	1	1990	322
2200	3	1990	14
2200	3	2022	13
2201	1	2022	1793
2201	1	1990	647
2201	3	1990	6
2201	3	2022	48.8027586206897
2202	1	2022	479
2202	1	1990	262
2202	3	1990	25
2202	3	2022	23.4107142857143
2203	1	2022	281
2203	1	1990	213
2203	3	1990	14
2203	3	2022	6
2204	1	2022	310
2204	1	1990	335
2204	3	1990	14
2204	3	2022	22.8973025674358
2205	1	2022	544
2205	1	1990	509
2205	3	1990	23
2205	3	2022	32
2206	1	2022	1315
2206	1	1990	1210
2206	3	1990	39
2206	3	2022	46.9434350573621
2207	1	2022	4718
2207	1	1990	2899
2207	3	1990	37
2207	3	2022	80.6681421342091
2208	1	2022	368
2208	1	1990	407
2208	3	1990	6
2208	3	2022	17.823092603378
2209	1	2022	195
2209	1	1990	265
2209	3	1990	15
2209	3	2022	13.2951680672269
2210	1	2022	12786
2210	1	1990	6341
2210	3	1990	201
2210	3	2022	276.38617629251
2211	1	2022	438
2211	1	1990	421
2211	3	1990	6
2211	3	2022	20.3478260869566
2212	1	2022	670
2212	1	1990	667
2212	3	1990	8
2212	3	2022	32.2585220773278
2213	1	2022	582
2213	1	1990	547
2213	3	1990	35
2213	3	2022	14
2214	1	2022	60
2214	1	1990	92
2214	3	1990	6
2214	3	2022	9.2
2215	1	2022	581
2215	1	1990	396
2215	3	1990	12
2215	3	2022	35.5407984956981
2216	1	2022	843
2216	1	1990	630
2216	3	1990	33
2216	3	2022	42
2217	1	2022	380
2217	1	1990	278
2217	3	1990	15
2217	3	2022	9.04368932038836
2218	1	2022	7764
2218	1	1990	4332
2218	3	1990	24
2218	3	2022	99.4961948146945
2219	1	2022	81
2219	1	1990	89
2219	3	1990	1
2219	3	2022	2.14285714285714
2220	1	2022	1484
2220	1	1990	1278
2220	3	1990	64
2220	3	2022	47.1911547821297
2221	1	2022	314
2221	1	1990	280
2221	3	1990	8
2221	3	2022	11.1437908496733
2222	1	2022	1800
2222	1	1990	1474
2222	3	1990	67
2222	3	2022	93
2223	1	2022	3460
2223	1	1990	2321
2223	3	1990	48
2223	3	2022	47
2224	1	2022	1889
2224	1	1990	1765
2224	3	1990	78
2224	3	2022	146.546626984128
2225	1	2022	286
2225	1	1990	337
2225	3	1990	43
2225	3	2022	23.3516890479924
2226	1	2022	390
2226	1	1990	547
2226	3	1990	23
2226	3	2022	74.6986301369863
2227	1	2022	601
2227	1	1990	564
2227	3	1990	32
2227	3	2022	57.839783842531
2228	1	2022	193
2228	1	1990	201
2228	3	1990	14
2228	3	2022	10
2229	1	2022	1528
2229	1	1990	946
2229	3	1990	34
2229	3	2022	39.2877386444398
2230	1	2022	754
2230	1	1990	713
2230	3	1990	53
2230	3	2022	56.8275862068965
2231	1	2022	3128
2231	1	1990	2906
2231	3	1990	240
2231	3	2022	219.518838151412
2232	1	2022	424
2232	1	1990	361
2232	3	1990	18
2232	3	2022	23.4244471098205
2233	1	2022	326
2233	1	1990	256
2233	3	1990	7
2233	3	2022	14.5912005965697
2234	1	2022	841
2234	1	1990	804
2234	3	1990	85
2234	3	2022	46.6688483355149
2235	1	2022	5916
2235	1	1990	3909
2235	3	1990	100
2235	3	2022	165.527562464374
2236	1	2022	1689
2236	1	1990	2799
2236	3	1990	79
2236	3	2022	211.194252459712
2237	1	2022	1629
2237	1	1990	1918
2237	3	1990	151
2237	3	2022	194
2238	1	2022	181
2238	1	1990	387
2238	3	1990	28
2238	3	2022	58.9477800121293
2239	1	2022	4922
2239	1	1990	3930
2239	3	1990	131
2239	3	2022	98.6479182422554
2240	1	2022	169
2240	1	1990	109
2240	3	1990	1
2240	3	2022	6.07894736842104
2241	1	2022	291
2241	1	1990	244
2241	3	1990	24
2241	3	2022	8
2242	1	2022	338
2242	1	1990	369
2242	3	1990	20
2242	3	2022	20.1826711504131
2243	1	2022	146
2243	1	1990	122
2243	3	1990	9
2243	3	2022	4.05489679402723
2244	1	2022	2561
2244	1	1990	2745
2244	3	1990	259
2244	3	2022	548.327227417381
2245	1	2022	138
2245	1	1990	151
2245	3	1990	8
2245	3	2022	6
2246	1	2022	193
2246	1	1990	189
2246	3	1990	7
2246	3	2022	5.0862068965517
2247	1	2022	495
2247	1	1990	428
2247	3	1990	16
2247	3	2022	21.5290832263294
2248	1	2022	367
2248	1	1990	370
2248	3	1990	16
2248	3	2022	19.2638888888889
2249	1	2022	970
2249	1	1990	550
2249	3	1990	18
2249	3	2022	28.0123287671233
2250	1	2022	390
2250	1	1990	205
2250	3	1990	9
2250	3	2022	6.36308784383321
2251	1	2022	147
2251	1	1990	145
2251	3	1990	6
2251	3	2022	9.10344827586204
2252	1	2022	1345
2252	1	1990	1020
2252	3	1990	35
2252	3	2022	73
2253	1	2022	2290
2253	1	1990	1813
2253	3	1990	41
2253	3	2022	63.1089083831299
2254	1	2022	398
2254	1	1990	314
2254	3	1990	8
2254	3	2022	10
2255	1	2022	1981
2255	1	1990	1204
2255	3	1990	23
2255	3	2022	93.3699848171604
2256	1	2022	966
2256	1	1990	658
2256	3	1990	24
2256	3	2022	22
2257	1	2022	3068
2257	1	1990	1608
2257	3	1990	36
2257	3	2022	54.9914881928957
2258	1	2022	380
2258	1	1990	291
2258	3	1990	4
2258	3	2022	16.4183244552058
2259	1	2022	80
2259	1	1990	97
2259	3	1990	6
2259	3	2022	4.26016260162602
2260	1	2022	124
2260	1	1990	234
2260	3	1990	15
2260	3	2022	16.5611429564009
2261	1	2022	450
2261	1	1990	405
2261	3	1990	3
2261	3	2022	24
2262	1	2022	9702
2262	1	1990	3879
2262	3	1990	45
2262	3	2022	114.166382850421
2263	1	2022	621
2263	1	1990	873
2263	3	1990	57
2263	3	2022	119.009816052131
2264	1	2022	4950
2264	1	1990	3338
2264	3	1990	82
2264	3	2022	155.643529993523
2265	1	2022	1553
2265	1	1990	1140
2265	3	1990	18
2265	3	2022	51.6095275628515
2266	1	2022	229
2266	1	1990	377
2266	3	1990	27
2266	3	2022	46
2267	1	2022	257
2267	1	1990	216
2267	3	1990	7
2267	3	2022	15.077519379845
2268	1	2022	82
2268	1	1990	79
2268	3	1990	6
2268	3	2022	8
2269	1	2022	316
2269	1	1990	239
2269	3	1990	13
2269	3	2022	7
2270	1	2022	298
2270	1	1990	195
2270	3	1990	7
2270	3	2022	12
2271	1	2022	230
2271	1	1990	103
2271	3	1990	0
2271	3	2022	1.95316804407714
2272	1	2022	10057
2272	1	1990	6207
2272	3	1990	123
2272	3	2022	182
2273	1	2022	2097
2273	1	1990	1808
2273	3	1990	47
2273	3	2022	45.2398988748655
2274	1	2022	2000
2274	1	1990	1459
2274	3	1990	98
2274	3	2022	93
2275	1	2022	1235
2275	1	1990	799
2275	3	1990	17
2275	3	2022	44
2276	1	2022	2149
2276	1	1990	1640
2276	3	1990	59
2276	3	2022	121
2277	1	2022	2046
2277	1	1990	1349
2277	3	1990	25
2277	3	2022	56.27134310354
2278	1	2022	1637
2278	1	1990	1015
2278	3	1990	36
2278	3	2022	51
2279	1	2022	238
2279	1	1990	167
2279	3	1990	13
2279	3	2022	5.36288713526019
2280	1	2022	1166
2280	1	1990	798
2280	3	1990	42
2280	3	2022	35.8810312494524
2281	1	2022	546
2281	1	1990	359
2281	3	1990	15
2281	3	2022	11
2282	1	2022	160
2282	1	1990	104
2282	3	1990	16
2282	3	2022	17.1931818181819
2283	1	2022	563
2283	1	1990	426
2283	3	1990	28
2283	3	2022	23.8886831386967
2284	1	2022	845
2284	1	1990	529
2284	3	1990	34
2284	3	2022	35.1304347826088
2285	1	2022	159
2285	1	1990	242
2285	3	1990	9
2285	3	2022	16.9972153972154
2286	1	2022	2408
2286	1	1990	1897
2286	3	1990	91
2286	3	2022	150.753965523319
2287	1	2022	3361
2287	1	1990	2033
2287	3	1990	21
2287	3	2022	67.3211455108359
2288	1	2022	32749
2288	1	1990	22064
2288	3	1990	228
2288	3	2022	372.380745626745
2289	1	2022	249
2289	1	1990	211
2289	3	1990	11
2289	3	2022	19.6354784946237
2290	1	2022	515
2290	1	1990	608
2290	3	1990	29
2290	3	2022	28.459595959596
2291	1	2022	879
2291	1	1990	471
2291	3	1990	8
2291	3	2022	18.7391583533998
2292	1	2022	212
2292	1	1990	222
2292	3	1990	11
2292	3	2022	9.07964601769908
2293	1	2022	1817
2293	1	1990	846
2293	3	1990	18
2293	3	2022	60
2294	1	2022	512
2294	1	1990	409
2294	3	1990	10
2294	3	2022	18.9571190835559
2295	1	2022	639
2295	1	1990	361
2295	3	1990	15
2295	3	2022	6.38974358974363
2296	1	2022	1032
2296	1	1990	831
2296	3	1990	44
2296	3	2022	32.4374869168962
2297	1	2022	185
2297	1	1990	304
2297	3	1990	15
2297	3	2022	28.7222222222222
2298	1	2022	595
2298	1	1990	597
2298	3	1990	23
2298	3	2022	35.5404620147654
2299	1	2022	383
2299	1	1990	394
2299	3	1990	14
2299	3	2022	21.2739130434783
2300	1	2022	498
2300	1	1990	389
2300	3	1990	10
2300	3	2022	5.06147540983611
2301	1	2022	1277
2301	1	1990	1249
2301	3	1990	19
2301	3	2022	71.0662119143331
2302	1	2022	282
2302	1	1990	251
2302	3	1990	11
2302	3	2022	19.1158536585366
2303	1	2022	1218
2303	1	1990	799
2303	3	1990	18
2303	3	2022	27.9894076906663
2304	1	2022	2704
2304	1	1990	947
2304	3	1990	26
2304	3	2022	92.8799377530195
2305	1	2022	256
2305	1	1990	312
2305	3	1990	26
2305	3	2022	28.638936049802
2306	1	2022	427
2306	1	1990	426
2306	3	1990	29
2306	3	2022	30.1181175020843
2307	1	2022	948
2307	1	1990	783
2307	3	1990	14
2307	3	2022	12
2308	1	2022	1262
2308	1	1990	1137
2308	3	1990	31
2308	3	2022	47.4330218068539
2309	1	2022	365
2309	1	1990	340
2309	3	1990	7
2309	3	2022	13
2310	1	2022	3468
2310	1	1990	1886
2310	3	1990	103
2310	3	2022	163.442872841639
2311	1	2022	3668
2311	1	1990	1324
2311	3	1990	19
2311	3	2022	44
2312	1	2022	419
2312	1	1990	293
2312	3	1990	13
2312	3	2022	23.213295587661
2313	1	2022	701
2313	1	1990	799
2313	3	1990	24
2313	3	2022	51.9904761904762
2314	1	2022	773
2314	1	1990	738
2314	3	1990	27
2314	3	2022	53
2315	1	2022	3161
2315	1	1990	2491
2315	3	1990	91
2315	3	2022	216.604060913706
2316	1	2022	251
2316	1	1990	177
2316	3	1990	3
2316	3	2022	3.16207063376874
2317	1	2022	1331
2317	1	1990	1613
2317	3	1990	67
2317	3	2022	81.9754290733308
2318	1	2022	234
2318	1	1990	224
2318	3	1990	8
2318	3	2022	9.36476191798652
2319	1	2022	271
2319	1	1990	220
2319	3	1990	7
2319	3	2022	6.14285714285712
2320	1	2022	4879
2320	1	1990	3520
2320	3	1990	70
2320	3	2022	132.309653744467
2321	1	2022	1825
2321	1	1990	1396
2321	3	1990	61
2321	3	2022	68.9752511332818
2322	1	2022	1890
2322	1	1990	1564
2322	3	1990	95
2322	3	2022	43.0608720494268
2323	1	2022	368
2323	1	1990	288
2323	3	1990	14
2323	3	2022	18.3606837606839
2324	1	2022	1016
2324	1	1990	963
2324	3	1990	20
2324	3	2022	36
2325	1	2022	334
2325	1	1990	377
2325	3	1990	11
2325	3	2022	25.9994909546558
2326	1	2022	359
2326	1	1990	306
2326	3	1990	18
2326	3	2022	10.5676320979964
2327	1	2022	1822
2327	1	1990	1282
2327	3	1990	53
2327	3	2022	130.760779923383
2328	1	2022	402
2328	1	1990	360
2328	3	1990	11
2328	3	2022	10.44483395708
2329	1	2022	2577
2329	1	1990	1461
2329	3	1990	77
2329	3	2022	77
2330	1	2022	344
2330	1	1990	427
2330	3	1990	17
2330	3	2022	26.3000000000001
2331	1	2022	1244
2331	1	1990	561
2331	3	1990	3
2331	3	2022	19.2830693225898
2332	1	2022	2771
2332	1	1990	1714
2332	3	1990	34
2332	3	2022	57.0547444673216
2333	1	2022	8128
2333	1	1990	3957
2333	3	1990	81
2333	3	2022	216
2334	1	2022	321
2334	1	1990	324
2334	3	1990	10
2334	3	2022	23.3467336683417
2335	1	2022	471
2335	1	1990	388
2335	3	1990	11
2335	3	2022	8
2336	1	2022	3446
2336	1	1990	1514
2336	3	1990	0
2336	3	2022	52.0486807098259
2337	1	2022	499
2337	1	1990	295
2337	3	1990	12
2337	3	2022	26.0839063964006
2338	1	2022	549
2338	1	1990	346
2338	3	1990	11
2338	3	2022	19.3653716867802
2339	1	2022	816
2339	1	1990	589
2339	3	1990	28
2339	3	2022	34.6398796225042
2340	1	2022	1594
2340	1	1990	1100
2340	3	1990	37
2340	3	2022	44.7463823305409
2341	1	2022	1874
2341	1	1990	1715
2341	3	1990	119
2341	3	2022	137.253300907445
2342	1	2022	330
2342	1	1990	264
2342	3	1990	5
2342	3	2022	14.792410573057
2343	1	2022	646
2343	1	1990	464
2343	3	1990	14
2343	3	2022	14.4445520112299
2344	1	2022	603
2344	1	1990	463
2344	3	1990	15
2344	3	2022	6
2345	1	2022	216
2345	1	1990	148
2345	3	1990	5
2345	3	2022	13.8481823114487
2346	1	2022	347
2346	1	1990	234
2346	3	1990	11
2346	3	2022	9
2347	1	2022	342
2347	1	1990	239
2347	3	1990	18
2347	3	2022	15.9157894736842
2348	1	2022	119
2348	1	1990	100
2348	3	1990	6
2348	3	2022	7
2349	1	2022	3011
2349	1	1990	2790
2349	3	1990	43
2349	3	2022	105.999889669397
2350	1	2022	414
2350	1	1990	402
2350	3	1990	23
2350	3	2022	20
2351	1	2022	184
2351	1	1990	195
2351	3	1990	9
2351	3	2022	10
2352	1	2022	1710
2352	1	1990	1352
2352	3	1990	55
2352	3	2022	56
2353	1	2022	1074
2353	1	1990	889
2353	3	1990	22
2353	3	2022	24.5200935341779
2354	1	2022	10966
2354	1	1990	6815
2354	3	1990	75
2354	3	2022	156.48743926857
2355	1	2022	288
2355	1	1990	250
2355	3	1990	20
2355	3	2022	14.8571428571429
2356	1	2022	756
2356	1	1990	599
2356	3	1990	19
2356	3	2022	40
2357	1	2022	45869
2357	1	1990	34485
2357	3	1990	1392
2357	3	2022	1602.65694247207
2358	1	2022	2045
2358	1	1990	1609
2358	3	1990	48
2358	3	2022	68.031761308951
2359	1	2022	298
2359	1	1990	201
2359	3	1990	3
2359	3	2022	4
2360	1	2022	1330
2360	1	1990	1261
2360	3	1990	45
2360	3	2022	59.8064856632396
2361	1	2022	127
2361	1	1990	133
2361	3	1990	9
2361	3	2022	15
2362	1	2022	9213
2362	1	1990	3607
2362	3	1990	59
2362	3	2022	462.461331888741
2363	1	2022	648
2363	1	1990	431
2363	3	1990	13
2363	3	2022	26.6169491525424
2364	1	2022	27141
2364	1	1990	20331
2364	3	1990	494
2364	3	2022	646.893707418695
2365	1	2022	882
2365	1	1990	689
2365	3	1990	18
2365	3	2022	39.0916182419725
2366	1	2022	376
2366	1	1990	309
2366	3	1990	10
2366	3	2022	9
2367	1	2022	475
2367	1	1990	393
2367	3	1990	13
2367	3	2022	17.75910269373
2368	1	2022	2860
2368	1	1990	1839
2368	3	1990	51
2368	3	2022	75.1386208777635
2369	1	2022	836
2369	1	1990	698
2369	3	1990	26
2369	3	2022	29
2370	1	2022	5188
2370	1	1990	3368
2370	3	1990	53
2370	3	2022	65.350998544434
2371	1	2022	257
2371	1	1990	153
2371	3	1990	2
2371	3	2022	7.11475409836065
2372	1	2022	467
2372	1	1990	351
2372	3	1990	28
2372	3	2022	28.5988955237548
2373	1	2022	544
2373	1	1990	392
2373	3	1990	15
2373	3	2022	45.4608999563132
2374	1	2022	4414
2374	1	1990	2491
2374	3	1990	66
2374	3	2022	120.105106184212
2375	1	2022	2820
2375	1	1990	1681
2375	3	1990	62
2375	3	2022	135
2376	1	2022	1146
2376	1	1990	658
2376	3	1990	9
2376	3	2022	27.9000306514201
2377	1	2022	907
2377	1	1990	656
2377	3	1990	31
2377	3	2022	30.7311004474016
2378	1	2022	1042
2378	1	1990	869
2378	3	1990	43
2378	3	2022	67.7013810201177
2379	1	2022	1389
2379	1	1990	1344
2379	3	1990	124
2379	3	2022	43.6595519113088
2380	1	2022	1308
2380	1	1990	1075
2380	3	1990	17
2380	3	2022	61.6739865717606
2381	1	2022	483
2381	1	1990	582
2381	3	1990	27
2381	3	2022	26.0044354838711
2382	1	2022	1140
2382	1	1990	777
2382	3	1990	52
2382	3	2022	60.979523659986
2383	1	2022	1291
2383	1	1990	1100
2383	3	1990	12
2383	3	2022	60.3479606060855
2384	1	2022	373
2384	1	1990	286
2384	3	1990	14
2384	3	2022	13.2228571428571
2385	1	2022	42185
2385	1	1990	25609
2385	3	1990	591
2385	3	2022	765.329118049305
2386	1	2022	408
2386	1	1990	314
2386	3	1990	33
2386	3	2022	14.9537023475054
2387	1	2022	1120
2387	1	1990	734
2387	3	1990	21
2387	3	2022	22.7230631364562
2388	1	2022	1283
2388	1	1990	926
2388	3	1990	11
2388	3	2022	25.7012604846192
2389	1	2022	2901
2389	1	1990	2185
2389	3	1990	21
2389	3	2022	58
2390	1	2022	5637
2390	1	1990	2420
2390	3	1990	28
2390	3	2022	101.743340016221
2391	1	2022	6215
2391	1	1990	6205
2391	3	1990	207
2391	3	2022	401.764022720225
2392	1	2022	1555
2392	1	1990	1481
2392	3	1990	46
2392	3	2022	98.3694238529031
2393	1	2022	266
2393	1	1990	103
2393	3	1990	6
2393	3	2022	11.1679389312977
2394	1	2022	2241
2394	1	1990	877
2394	3	1990	14
2394	3	2022	76.6790283201245
2395	1	2022	214
2395	1	1990	202
2395	3	1990	8
2395	3	2022	10.3525925925926
2396	1	2022	713
2396	1	1990	709
2396	3	1990	28
2396	3	2022	55.5378973105132
2397	1	2022	162
2397	1	1990	181
2397	3	1990	6
2397	3	2022	6
2398	1	2022	96
2398	1	1990	54
2398	3	1990	3
2398	3	2022	4.13114754098361
2399	1	2022	342
2399	1	1990	307
2399	3	1990	0
2399	3	2022	14.0493265306122
2400	1	2022	260
2400	1	1990	255
2400	3	1990	5
2400	3	2022	4.03252032520324
2401	1	2022	92
2401	1	1990	93
2401	3	1990	16
2401	3	2022	9
2402	1	2022	358
2402	1	1990	290
2402	3	1990	18
2402	3	2022	11
2403	1	2022	51
2403	1	1990	88
2403	3	1990	14
2403	3	2022	17.1434599156118
2404	1	2022	274
2404	1	1990	226
2404	3	1990	8
2404	3	2022	6
2405	1	2022	386
2405	1	1990	318
2405	3	1990	15
2405	3	2022	17
2406	1	2022	410
2406	1	1990	276
2406	3	1990	4
2406	3	2022	16.7831044158913
2407	1	2022	1117
2407	1	1990	562
2407	3	1990	15
2407	3	2022	36.1310396010136
2408	1	2022	629
2408	1	1990	610
2408	3	1990	16
2408	3	2022	33.0674452300285
2409	1	2022	973
2409	1	1990	377
2409	3	1990	8
2409	3	2022	8.74838709677419
2410	1	2022	393
2410	1	1990	326
2410	3	1990	8
2410	3	2022	27.3594831655129
2411	1	2022	333
2411	1	1990	350
2411	3	1990	7
2411	3	2022	19.1005291005292
2412	1	2022	267
2412	1	1990	225
2412	3	1990	8
2412	3	2022	11.2412808641975
2413	1	2022	868
2413	1	1990	823
2413	3	1990	7
2413	3	2022	38
2414	1	2022	402
2414	1	1990	242
2414	3	1990	6
2414	3	2022	10
2415	1	2022	154
2415	1	1990	120
2415	3	1990	8
2415	3	2022	2.025
2416	1	2022	244
2416	1	1990	227
2416	3	1990	2
2416	3	2022	6.50272628135223
2417	1	2022	325
2417	1	1990	238
2417	3	1990	8
2417	3	2022	14
2418	1	2022	53
2418	1	1990	40
2418	3	1990	5
2418	3	2022	4.22857142857144
2419	1	2022	1233
2419	1	1990	1000
2419	3	1990	39
2419	3	2022	41.8490694764456
2420	1	2022	222
2420	1	1990	101
2420	3	1990	12
2420	3	2022	9.38297872340427
2421	1	2022	164
2421	1	1990	128
2421	3	1990	13
2421	3	2022	5.34835210680017
2422	1	2022	616
2422	1	1990	400
2422	3	1990	15
2422	3	2022	18
2423	1	2022	582
2423	1	1990	399
2423	3	1990	9
2423	3	2022	25.1227105749941
2424	1	2022	3733
2424	1	1990	1471
2424	3	1990	37
2424	3	2022	155.477850807913
2425	1	2022	1913
2425	1	1990	1240
2425	3	1990	16
2425	3	2022	51.4377098503071
2426	1	2022	109
2426	1	1990	111
2426	3	1990	0
2426	3	2022	5
2427	1	2022	133
2427	1	1990	135
2427	3	1990	14
2427	3	2022	7.53623188405797
2428	1	2022	402
2428	1	1990	305
2428	3	1990	12
2428	3	2022	10
2429	1	2022	123
2429	1	1990	94
2429	3	1990	1
2429	3	2022	3
2430	1	2022	350
2430	1	1990	206
2430	3	1990	7
2430	3	2022	11.4304738562091
2431	1	2022	787
2431	1	1990	505
2431	3	1990	24
2431	3	2022	44.3482231601475
2432	1	2022	1022
2432	1	1990	544
2432	3	1990	24
2432	3	2022	37
2433	1	2022	15412
2433	1	1990	9054
2433	3	1990	308
2433	3	2022	451.481256136003
2434	1	2022	255
2434	1	1990	274
2434	3	1990	4
2434	3	2022	15
2435	1	2022	372
2435	1	1990	331
2435	3	1990	12
2435	3	2022	10.8437649307214
2436	1	2022	205
2436	1	1990	149
2436	3	1990	7
2436	3	2022	4
2437	1	2022	847
2437	1	1990	503
2437	3	1990	7
2437	3	2022	19.8283126765635
2438	1	2022	205
2438	1	1990	186
2438	3	1990	12
2438	3	2022	7.05785123966944
2439	1	2022	319
2439	1	1990	305
2439	3	1990	25
2439	3	2022	20.0381816146008
2440	1	2022	273
2440	1	1990	279
2440	3	1990	6
2440	3	2022	14.4444444444445
2441	1	2022	1626
2441	1	1990	834
2441	3	1990	2
2441	3	2022	25.1186316196366
2442	1	2022	727
2442	1	1990	656
2442	3	1990	51
2442	3	2022	20
2443	1	2022	240
2443	1	1990	173
2443	3	1990	14
2443	3	2022	9
2444	1	2022	230
2444	1	1990	211
2444	3	1990	12
2444	3	2022	19.38
2445	1	2022	778
2445	1	1990	506
2445	3	1990	5
2445	3	2022	19.8172043010754
2446	1	2022	145
2446	1	1990	143
2446	3	1990	16
2446	3	2022	4.59466666666668
2447	1	2022	1025
2447	1	1990	765
2447	3	1990	31
2447	3	2022	51.089425742479
2448	1	2022	518
2448	1	1990	280
2448	3	1990	6
2448	3	2022	5.52948210674404
2449	1	2022	869
2449	1	1990	526
2449	3	1990	3
2449	3	2022	20
2450	1	2022	172
2450	1	1990	153
2450	3	1990	11
2450	3	2022	9.19354838709681
2451	1	2022	9218
2451	1	1990	5089
2451	3	1990	258
2451	3	2022	188.712460100237
2452	1	2022	540
2452	1	1990	426
2452	3	1990	11
2452	3	2022	10.8492392807745
2453	1	2022	631
2453	1	1990	600
2453	3	1990	7
2453	3	2022	20.9033221351251
2454	1	2022	607
2454	1	1990	339
2454	3	1990	7
2454	3	2022	24.0734760155413
2455	1	2022	424
2455	1	1990	316
2455	3	1990	5
2455	3	2022	13.2096774193549
2456	1	2022	420
2456	1	1990	375
2456	3	1990	10
2456	3	2022	22
2457	1	2022	595
2457	1	1990	472
2457	3	1990	19
2457	3	2022	26.6371625811479
2458	1	2022	185
2458	1	1990	192
2458	3	1990	6
2458	3	2022	11
2459	1	2022	120
2459	1	1990	88
2459	3	1990	5
2459	3	2022	4
2460	1	2022	576
2460	1	1990	363
2460	3	1990	17
2460	3	2022	33.1393794899143
2461	1	2022	2510
2461	1	1990	1719
2461	3	1990	64
2461	3	2022	95.4781391223805
2462	1	2022	423
2462	1	1990	389
2462	3	1990	7
2462	3	2022	17
2463	1	2022	799
2463	1	1990	679
2463	3	1990	20
2463	3	2022	33.6810801165767
2464	1	2022	397
2464	1	1990	399
2464	3	1990	15
2464	3	2022	19.2349681273984
2465	1	2022	139
2465	1	1990	132
2465	3	1990	9
2465	3	2022	6.99839302112033
2466	1	2022	1126
2466	1	1990	873
2466	3	1990	26
2466	3	2022	44.0237080079343
2467	1	2022	416
2467	1	1990	279
2467	3	1990	11
2467	3	2022	10.9210735182518
2468	1	2022	246
2468	1	1990	156
2468	3	1990	3
2468	3	2022	4.03361344537816
2469	1	2022	118
2469	1	1990	133
2469	3	1990	2
2469	3	2022	10.3030303030304
2470	1	2022	742
2470	1	1990	594
2470	3	1990	5
2470	3	2022	24.4786324786326
2471	1	2022	434
2471	1	1990	345
2471	3	1990	8
2471	3	2022	23.7537710196911
2472	1	2022	558
2472	1	1990	402
2472	3	1990	11
2472	3	2022	21.1631011962891
2473	1	2022	336
2473	1	1990	286
2473	3	1990	13
2473	3	2022	11
2474	1	2022	21716
2474	1	1990	19309
2474	3	1990	1073
2474	3	2022	1692.76465907513
2475	1	2022	851
2475	1	1990	858
2475	3	1990	32
2475	3	2022	39.4719422121059
2476	1	2022	454
2476	1	1990	392
2476	3	1990	13
2476	3	2022	29.1174089068825
2477	1	2022	682
2477	1	1990	600
2477	3	1990	30
2477	3	2022	25.0968992248062
2478	1	2022	250
2478	1	1990	113
2478	3	1990	3
2478	3	2022	6.37116154873164
2479	1	2022	232
2479	1	1990	220
2479	3	1990	19
2479	3	2022	1.82832244008715
2480	1	2022	799
2480	1	1990	612
2480	3	1990	11
2480	3	2022	61.2419763609297
2481	1	2022	697
2481	1	1990	503
2481	3	1990	17
2481	3	2022	23.0709876543211
2482	1	2022	96
2482	1	1990	93
2482	3	1990	5
2482	3	2022	7.22580645161291
2483	1	2022	486
2483	1	1990	467
2483	3	1990	13
2483	3	2022	9
2484	1	2022	347
2484	1	1990	317
2484	3	1990	11
2484	3	2022	8.26086956521738
2485	1	2022	314
2485	1	1990	282
2485	3	1990	13
2485	3	2022	8.99923605805962
2486	1	2022	388
2486	1	1990	392
2486	3	1990	19
2486	3	2022	21.1151923898704
2487	1	2022	471
2487	1	1990	342
2487	3	1990	9
2487	3	2022	13.2482832795565
2488	1	2022	1282
2488	1	1990	1335
2488	3	1990	86
2488	3	2022	138
2489	1	2022	647
2489	1	1990	396
2489	3	1990	10
2489	3	2022	12
2490	1	2022	1552
2490	1	1990	857
2490	3	1990	46
2490	3	2022	46.1714703209365
2491	1	2022	426
2491	1	1990	373
2491	3	1990	22
2491	3	2022	33
2492	1	2022	215
2492	1	1990	189
2492	3	1990	4
2492	3	2022	8.70279146141214
2493	1	2022	925
2493	1	1990	368
2493	3	1990	8
2493	3	2022	26
2494	1	2022	436
2494	1	1990	446
2494	3	1990	5
2494	3	2022	22
2495	1	2022	763
2495	1	1990	723
2495	3	1990	16
2495	3	2022	35.2586206896549
2496	1	2022	708
2496	1	1990	459
2496	3	1990	18
2496	3	2022	31.6057943681954
2497	1	2022	98
2497	1	1990	102
2497	3	1990	4
2497	3	2022	3
2498	1	2022	530
2498	1	1990	437
2498	3	1990	10
2498	3	2022	20.4844796462406
2499	1	2022	364
2499	1	1990	243
2499	3	1990	3
2499	3	2022	9.336898395722
2500	1	2022	276
2500	1	1990	137
2500	3	1990	3
2500	3	2022	4.09068462401799
2501	1	2022	272
2501	1	1990	211
2501	3	1990	13
2501	3	2022	11.4428571428572
2502	1	2022	2414
2502	1	1990	2187
2502	3	1990	79
2502	3	2022	136.902728187655
2503	1	2022	1464
2503	1	1990	1310
2503	3	1990	48
2503	3	2022	86.0812097088213
2504	1	2022	4622
2504	1	1990	4449
2504	3	1990	108
2504	3	2022	237.814731237586
2505	1	2022	606
2505	1	1990	472
2505	3	1990	9
2505	3	2022	26.9549263123032
2506	1	2022	273
2506	1	1990	240
2506	3	1990	3
2506	3	2022	10.0751879699248
2507	1	2022	991
2507	1	1990	628
2507	3	1990	3
2507	3	2022	27.4209354120268
2508	1	2022	1189
2508	1	1990	694
2508	3	1990	13
2508	3	2022	32.302657113002
2509	1	2022	141
2509	1	1990	126
2509	3	1990	11
2509	3	2022	5
2510	1	2022	1395
2510	1	1990	1280
2510	3	1990	27
2510	3	2022	37.5152224874362
2511	1	2022	1909
2511	1	1990	1117
2511	3	1990	12
2511	3	2022	65.0159786030093
2512	1	2022	611
2512	1	1990	513
2512	3	1990	43
2512	3	2022	34
2513	1	2022	706
2513	1	1990	634
2513	3	1990	7
2513	3	2022	21.1929732845404
2514	1	2022	1003
2514	1	1990	581
2514	3	1990	17
2514	3	2022	29
2515	1	2022	168
2515	1	1990	138
2515	3	1990	7
2515	3	2022	3.07500000000001
2516	1	2022	680
2516	1	1990	731
2516	3	1990	50
2516	3	2022	59.8290109331297
2517	1	2022	1396
2517	1	1990	952
2517	3	1990	43
2517	3	2022	65.9836970024483
2518	1	2022	7095
2518	1	1990	2884
2518	3	1990	52
2518	3	2022	165.580849668532
2519	1	2022	2883
2519	1	1990	2816
2519	3	1990	73
2519	3	2022	127
2520	1	2022	849
2520	1	1990	666
2520	3	1990	46
2520	3	2022	50.2601647339743
2521	1	2022	148
2521	1	1990	160
2521	3	1990	6
2521	3	2022	2.13292847503374
2522	1	2022	288
2522	1	1990	193
2522	3	1990	10
2522	3	2022	15.1027397260274
2523	1	2022	286
2523	1	1990	170
2523	3	1990	0
2523	3	2022	12
2524	1	2022	603
2524	1	1990	536
2524	3	1990	16
2524	3	2022	17.4330207697572
2525	1	2022	190
2525	1	1990	171
2525	3	1990	27
2525	3	2022	16.3884992987377
2526	1	2022	286
2526	1	1990	221
2526	3	1990	15
2526	3	2022	11.38689048761
2527	1	2022	1086
2527	1	1990	646
2527	3	1990	25
2527	3	2022	27.1849943337811
2528	1	2022	305
2528	1	1990	367
2528	3	1990	6
2528	3	2022	9.03636363636366
2529	1	2022	240
2529	1	1990	242
2529	3	1990	7
2529	3	2022	8
2530	1	2022	588
2530	1	1990	550
2530	3	1990	10
2530	3	2022	34.6517571884984
2531	1	2022	167
2531	1	1990	165
2531	3	1990	10
2531	3	2022	4.23709585933068
2532	1	2022	367
2532	1	1990	339
2532	3	1990	7
2532	3	2022	20.1985537443314
2533	1	2022	78
2533	1	1990	71
2533	3	1990	2
2533	3	2022	5.18518518518519
2534	1	2022	376
2534	1	1990	439
2534	3	1990	14
2534	3	2022	33.1574264563662
2535	1	2022	2182
2535	1	1990	1330
2535	3	1990	60
2535	3	2022	80.1185136453919
2536	1	2022	425
2536	1	1990	268
2536	3	1990	2
2536	3	2022	13.3180147058824
2537	1	2022	1030
2537	1	1990	996
2537	3	1990	9
2537	3	2022	31.8937489096936
2538	1	2022	228
2538	1	1990	231
2538	3	1990	11
2538	3	2022	12.0983606557378
2539	1	2022	345
2539	1	1990	330
2539	3	1990	9
2539	3	2022	10.2702961526491
2540	1	2022	1550
2540	1	1990	980
2540	3	1990	25
2540	3	2022	113.271812080537
2541	1	2022	591
2541	1	1990	302
2541	3	1990	4
2541	3	2022	22.9663435333909
2542	1	2022	1704
2542	1	1990	1408
2542	3	1990	47
2542	3	2022	88.6552050019175
2543	1	2022	282
2543	1	1990	347
2543	3	1990	13
2543	3	2022	35.9957894736843
2544	1	2022	332
2544	1	1990	160
2544	3	1990	5
2544	3	2022	13
2545	1	2022	188
2545	1	1990	170
2545	3	1990	3
2545	3	2022	10.9974489795918
2546	1	2022	80
2546	1	1990	99
2546	3	1990	13
2546	3	2022	10
2547	1	2022	564
2547	1	1990	304
2547	3	1990	14
2547	3	2022	16
2548	1	2022	613
2548	1	1990	415
2548	3	1990	16
2548	3	2022	27
2549	1	2022	321
2549	1	1990	313
2549	3	1990	30
2549	3	2022	20.3242932988951
2550	1	2022	375
2550	1	1990	276
2550	3	1990	14
2550	3	2022	12.054054054054
2551	1	2022	77
2551	1	1990	80
2551	3	1990	4
2551	3	2022	5.125
2552	1	2022	653
2552	1	1990	680
2552	3	1990	39
2552	3	2022	16.0691144708424
2553	1	2022	2602
2553	1	1990	1218
2553	3	1990	34
2553	3	2022	69.0874466180436
2554	1	2022	128
2554	1	1990	122
2554	3	1990	13
2554	3	2022	6.1182692307692
2555	1	2022	230
2555	1	1990	176
2555	3	1990	8
2555	3	2022	1
2556	1	2022	129
2556	1	1990	103
2556	3	1990	13
2556	3	2022	13.0107526881721
2557	1	2022	270
2557	1	1990	322
2557	3	1990	2
2557	3	2022	26
2558	1	2022	133
2558	1	1990	120
2558	3	1990	0
2558	3	2022	6.71497584541063
2559	1	2022	85
2559	1	1990	58
2559	3	1990	1
2559	3	2022	2
2560	1	2022	457
2560	1	1990	384
2560	3	1990	0
2560	3	2022	13.7401869158878
2561	1	2022	99
2561	1	1990	100
2561	3	1990	12
2561	3	2022	7.81420765027323
2562	1	2022	301
2562	1	1990	338
2562	3	1990	0
2562	3	2022	10.902745745987
2563	1	2022	670
2563	1	1990	481
2563	3	1990	5
2563	3	2022	27
2564	1	2022	1970
2564	1	1990	1311
2564	3	1990	17
2564	3	2022	46.3861990305104
2565	1	2022	1206
2565	1	1990	872
2565	3	1990	26
2565	3	2022	34.4334630997177
2566	1	2022	1038
2566	1	1990	521
2566	3	1990	7
2566	3	2022	47.2179777645667
2567	1	2022	855
2567	1	1990	851
2567	3	1990	35
2567	3	2022	34.1873065065188
2568	1	2022	992
2568	1	1990	924
2568	3	1990	50
2568	3	2022	40.8681304456062
2569	1	2022	7449
2569	1	1990	6710
2569	3	1990	332
2569	3	2022	161.766460159884
2570	1	2022	346
2570	1	1990	380
2570	3	1990	16
2570	3	2022	22.111462150891
2571	1	2022	834
2571	1	1990	607
2571	3	1990	21
2571	3	2022	13.418855075548
2572	1	2022	1303
2572	1	1990	420
2572	3	1990	6
2572	3	2022	61
2573	1	2022	482
2573	1	1990	386
2573	3	1990	10
2573	3	2022	24.2827899124197
2574	1	2022	77
2574	1	1990	102
2574	3	1990	7
2574	3	2022	4.07692307692308
2575	1	2022	393
2575	1	1990	292
2575	3	1990	9
2575	3	2022	9.70056624292516
2576	1	2022	604
2576	1	1990	592
2576	3	1990	18
2576	3	2022	23.4567743462312
2577	1	2022	31455
2577	1	1990	28328
2577	3	1990	999
2577	3	2022	1243.9229879335
2578	1	2022	78
2578	1	1990	79
2578	3	1990	7
2578	3	2022	4.45333333333333
2579	1	2022	1223
2579	1	1990	1116
2579	3	1990	28
2579	3	2022	62.6690322792787
2580	1	2022	593
2580	1	1990	464
2580	3	1990	10
2580	3	2022	27.1862201365188
2581	1	2022	561
2581	1	1990	538
2581	3	1990	18
2581	3	2022	14
2582	1	2022	5005
2582	1	1990	5000
2582	3	1990	212
2582	3	2022	231.473610243531
2583	1	2022	168
2583	1	1990	172
2583	3	1990	7
2583	3	2022	8.08080808080808
2584	1	2022	268
2584	1	1990	218
2584	3	1990	8
2584	3	2022	12
2585	1	2022	755
2585	1	1990	574
2585	3	1990	31
2585	3	2022	34.1298189268758
2586	1	2022	1336
2586	1	1990	1327
2586	3	1990	31
2586	3	2022	77.9736054020898
2587	1	2022	3331
2587	1	1990	2204
2587	3	1990	45
2587	3	2022	138
2588	1	2022	316
2588	1	1990	262
2588	3	1990	0
2588	3	2022	19.4245810055865
2589	1	2022	267
2589	1	1990	256
2589	3	1990	3
2589	3	2022	6.14452798663324
2590	1	2022	249
2590	1	1990	219
2590	3	1990	6
2590	3	2022	5.38806752026809
2591	1	2022	304
2591	1	1990	289
2591	3	1990	10
2591	3	2022	19.1032608695653
2592	1	2022	1498
2592	1	1990	1063
2592	3	1990	12
2592	3	2022	30.598369420565
2593	1	2022	376
2593	1	1990	325
2593	3	1990	6
2593	3	2022	10.8116341631362
2594	1	2022	6194
2594	1	1990	3100
2594	3	1990	53
2594	3	2022	200.03201377032
2595	1	2022	1057
2595	1	1990	981
2595	3	1990	45
2595	3	2022	54.296050170159
2596	1	2022	789
2596	1	1990	503
2596	3	1990	15
2596	3	2022	24.8702811455763
2597	1	2022	1057
2597	1	1990	741
2597	3	1990	14
2597	3	2022	36.7700985202724
2598	1	2022	650
2598	1	1990	370
2598	3	1990	8
2598	3	2022	29
2599	1	2022	493
2599	1	1990	386
2599	3	1990	12
2599	3	2022	22.0866141732284
2600	1	2022	285
2600	1	1990	292
2600	3	1990	7
2600	3	2022	12.2896180290298
2601	1	2022	198
2601	1	1990	172
2601	3	1990	8
2601	3	2022	11.1078431372549
2602	1	2022	7463
2602	1	1990	4056
2602	3	1990	153
2602	3	2022	232
2603	1	2022	454
2603	1	1990	550
2603	3	1990	23
2603	3	2022	27
2604	1	2022	106
2604	1	1990	94
2604	3	1990	1
2604	3	2022	2
2605	1	2022	135
2605	1	1990	132
2605	3	1990	4
2605	3	2022	4
2606	1	2022	342
2606	1	1990	294
2606	3	1990	19
2606	3	2022	26
2607	1	2022	832
2607	1	1990	564
2607	3	1990	20
2607	3	2022	35
2608	1	2022	237
2608	1	1990	216
2608	3	1990	15
2608	3	2022	6.47787610619469
2609	1	2022	3693
2609	1	1990	3056
2609	3	1990	85
2609	3	2022	274.160655499525
2610	1	2022	189
2610	1	1990	221
2610	3	1990	4
2610	3	2022	9
2611	1	2022	198
2611	1	1990	181
2611	3	1990	9
2611	3	2022	6.53189235007417
2612	1	2022	1483
2612	1	1990	970
2612	3	1990	32
2612	3	2022	53.9277998431229
2613	1	2022	1605
2613	1	1990	1418
2613	3	1990	29
2613	3	2022	66.8957053104411
2614	1	2022	1737
2614	1	1990	1138
2614	3	1990	49
2614	3	2022	79.3785326179
2615	1	2022	2975
2615	1	1990	1887
2615	3	1990	78
2615	3	2022	94.9906023359991
2616	1	2022	1228
2616	1	1990	665
2616	3	1990	11
2616	3	2022	36.926243567753
2617	1	2022	219
2617	1	1990	191
2617	3	1990	12
2617	3	2022	7
2618	1	2022	3151
2618	1	1990	2596
2618	3	1990	48
2618	3	2022	113
2619	1	2022	879
2619	1	1990	616
2619	3	1990	23
2619	3	2022	32.915587529976
2620	1	2022	697
2620	1	1990	516
2620	3	1990	17
2620	3	2022	30
2621	1	2022	765
2621	1	1990	648
2621	3	1990	13
2621	3	2022	32.0028101336423
2622	1	2022	797
2622	1	1990	462
2622	3	1990	14
2622	3	2022	21.8507913145115
2623	1	2022	625
2623	1	1990	527
2623	3	1990	10
2623	3	2022	25.4237726098191
2624	1	2022	104
2624	1	1990	105
2624	3	1990	1
2624	3	2022	1.23809523809524
2625	1	2022	490
2625	1	1990	443
2625	3	1990	10
2625	3	2022	14.0573770491804
2626	1	2022	104
2626	1	1990	79
2626	3	1990	6
2626	3	2022	8
2627	1	2022	3115
2627	1	1990	2465
2627	3	1990	76
2627	3	2022	108.034225529827
2628	1	2022	1425
2628	1	1990	809
2628	3	1990	22
2628	3	2022	43.5631507728017
2629	1	2022	1987
2629	1	1990	1821
2629	3	1990	77
2629	3	2022	110
2630	1	2022	1191
2630	1	1990	1096
2630	3	1990	76
2630	3	2022	66.7870894342548
2631	1	2022	181
2631	1	1990	190
2631	3	1990	6
2631	3	2022	9.23456790123454
2632	1	2022	1913
2632	1	1990	1271
2632	3	1990	34
2632	3	2022	71.4960746765173
2633	1	2022	500
2633	1	1990	452
2633	3	1990	13
2633	3	2022	22
2634	1	2022	691
2634	1	1990	481
2634	3	1990	8
2634	3	2022	11.4050337240159
2635	1	2022	421
2635	1	1990	183
2635	3	1990	5
2635	3	2022	17.8708762191698
2636	1	2022	618
2636	1	1990	407
2636	3	1990	15
2636	3	2022	6.18367346938773
2637	1	2022	633
2637	1	1990	585
2637	3	1990	20
2637	3	2022	37.0956583461495
2638	1	2022	444
2638	1	1990	304
2638	3	1990	12
2638	3	2022	24.6697674418604
2639	1	2022	464
2639	1	1990	365
2639	3	1990	13
2639	3	2022	11.2975265304466
2640	1	2022	732
2640	1	1990	407
2640	3	1990	22
2640	3	2022	20.2126037707774
2641	1	2022	1457
2641	1	1990	773
2641	3	1990	25
2641	3	2022	38
2642	1	2022	251
2642	1	1990	131
2642	3	1990	3
2642	3	2022	3
2643	1	2022	418
2643	1	1990	426
2643	3	1990	18
2643	3	2022	19.9890909090909
2644	1	2022	410
2644	1	1990	260
2644	3	1990	6
2644	3	2022	15
2645	1	2022	2946
2645	1	1990	1434
2645	3	1990	36
2645	3	2022	82.6616590335849
2646	1	2022	312
2646	1	1990	241
2646	3	1990	17
2646	3	2022	12.1340782122905
2647	1	2022	407
2647	1	1990	309
2647	3	1990	7
2647	3	2022	19
2648	1	2022	1810
2648	1	1990	793
2648	3	1990	26
2648	3	2022	50.5083333333335
2649	1	2022	109
2649	1	1990	139
2649	3	1990	12
2649	3	2022	7.88235294117647
2650	1	2022	1738
2650	1	1990	1285
2650	3	1990	44
2650	3	2022	53.7385551994766
2651	1	2022	1015
2651	1	1990	917
2651	3	1990	40
2651	3	2022	56.1402250244156
2652	1	2022	735
2652	1	1990	420
2652	3	1990	11
2652	3	2022	23.2356250000001
2653	1	2022	1242
2653	1	1990	877
2653	3	1990	11
2653	3	2022	39.5211071913162
2654	1	2022	441
2654	1	1990	408
2654	3	1990	10
2654	3	2022	27
2655	1	2022	1228
2655	1	1990	815
2655	3	1990	26
2655	3	2022	37.3551341464084
2656	1	2022	1749
2656	1	1990	837
2656	3	1990	28
2656	3	2022	63.2443307068726
2657	1	2022	6123
2657	1	1990	3047
2657	3	1990	45
2657	3	2022	184.171584359959
2658	1	2022	1356
2658	1	1990	868
2658	3	1990	36
2658	3	2022	45.7549984663006
2659	1	2022	623
2659	1	1990	490
2659	3	1990	11
2659	3	2022	11.1156554580897
2660	1	2022	324
2660	1	1990	161
2660	3	1990	9
2660	3	2022	13.0823512424982
2661	1	2022	728
2661	1	1990	627
2661	3	1990	7
2661	3	2022	32.00599443374
2662	1	2022	982
2662	1	1990	597
2662	3	1990	30
2662	3	2022	33.7600245499181
2663	1	2022	14114
2663	1	1990	9452
2663	3	1990	283
2663	3	2022	387.183772438547
2664	1	2022	1729
2664	1	1990	938
2664	3	1990	17
2664	3	2022	38.7230475004448
2665	1	2022	9996
2665	1	1990	7075
2665	3	1990	139
2665	3	2022	334.296212851012
2666	1	2022	5038
2666	1	1990	4536
2666	3	1990	144
2666	3	2022	273
2667	1	2022	3384
2667	1	1990	1775
2667	3	1990	48
2667	3	2022	130
2668	1	2022	8051
2668	1	1990	5075
2668	3	1990	90
2668	3	2022	379.88937043377
2669	1	2022	628
2669	1	1990	502
2669	3	1990	30
2669	3	2022	12.2594850948509
2670	1	2022	1131
2670	1	1990	1009
2670	3	1990	13
2670	3	2022	51
2671	1	2022	4662
2671	1	1990	1695
2671	3	1990	48
2671	3	2022	195.014001289651
2672	1	2022	1151
2672	1	1990	940
2672	3	1990	28
2672	3	2022	39.9101430529547
2673	1	2022	241
2673	1	1990	161
2673	3	1990	7
2673	3	2022	3.64667956157318
2674	1	2022	105
2674	1	1990	92
2674	3	1990	2
2674	3	2022	10
2675	1	2022	1806
2675	1	1990	684
2675	3	1990	6
2675	3	2022	41.7035489540898
2676	1	2022	1605
2676	1	1990	887
2676	3	1990	17
2676	3	2022	55.849310420465
2677	1	2022	1099
2677	1	1990	618
2677	3	1990	26
2677	3	2022	67.5979994979681
2678	1	2022	1568
2678	1	1990	1253
2678	3	1990	23
2678	3	2022	59.958051420839
2679	1	2022	1298
2679	1	1990	630
2679	3	1990	25
2679	3	2022	84.2063581714636
2680	1	2022	3914
2680	1	1990	1630
2680	3	1990	968
2680	3	2022	86.3176393704257
2681	1	2022	221
2681	1	1990	161
2681	3	1990	9
2681	3	2022	8.9356705241661
2682	1	2022	401
2682	1	1990	328
2682	3	1990	3
2682	3	2022	11.0531400966184
2683	1	2022	193
2683	1	1990	169
2683	3	1990	7
2683	3	2022	3.79487179487179
2684	1	2022	1022
2684	1	1990	616
2684	3	1990	1
2684	3	2022	17.4093190685966
2685	1	2022	137
2685	1	1990	82
2685	3	1990	0
2685	3	2022	4
2686	1	2022	361
2686	1	1990	403
2686	3	1990	16
2686	3	2022	17.2519090662713
2687	1	2022	3669
2687	1	1990	2829
2687	3	1990	152
2687	3	2022	165.29125837269
2688	1	2022	193
2688	1	1990	179
2688	3	1990	9
2688	3	2022	3.40022191400833
2689	1	2022	636
2689	1	1990	569
2689	3	1990	39
2689	3	2022	37.9348296536131
2690	1	2022	1162
2690	1	1990	883
2690	3	1990	28
2690	3	2022	52.666639519661
2691	1	2022	887
2691	1	1990	696
2691	3	1990	33
2691	3	2022	22.3793103448275
2692	1	2022	1131
2692	1	1990	1119
2692	3	1990	24
2692	3	2022	54.5322073841321
2693	1	2022	8445
2693	1	1990	5283
2693	3	1990	173
2693	3	2022	268.923931925996
2694	1	2022	680
2694	1	1990	396
2694	3	1990	5
2694	3	2022	15.4270392295663
2695	1	2022	12900
2695	1	1990	9099
2695	3	1990	140
2695	3	2022	260.430249725827
2696	1	2022	3174
2696	1	1990	2769
2696	3	1990	121
2696	3	2022	226.570891514501
2697	1	2022	1331
2697	1	1990	966
2697	3	1990	47
2697	3	2022	41
2698	1	2022	763
2698	1	1990	485
2698	3	1990	22
2698	3	2022	16.3202665117892
2699	1	2022	841
2699	1	1990	746
2699	3	1990	30
2699	3	2022	34.4969660194178
2700	1	2022	3455
2700	1	1990	1307
2700	3	1990	16
2700	3	2022	123.558638176428
2701	1	2022	309
2701	1	1990	257
2701	3	1990	6
2701	3	2022	14
2702	1	2022	285
2702	1	1990	226
2702	3	1990	9
2702	3	2022	12
2703	1	2022	610
2703	1	1990	403
2703	3	1990	14
2703	3	2022	26
2704	1	2022	242
2704	1	1990	261
2704	3	1990	5
2704	3	2022	12.3597397627248
2705	1	2022	188
2705	1	1990	184
2705	3	1990	16
2705	3	2022	6.0399042972415
2706	1	2022	238
2706	1	1990	193
2706	3	1990	10
2706	3	2022	7
2707	1	2022	249
2707	1	1990	190
2707	3	1990	2
2707	3	2022	1.00869565217391
2708	1	2022	283
2708	1	1990	301
2708	3	1990	5
2708	3	2022	20.3658536585365
2709	1	2022	1451
2709	1	1990	859
2709	3	1990	31
2709	3	2022	31.1422240449399
2710	1	2022	224
2710	1	1990	208
2710	3	1990	17
2710	3	2022	10.2254853062593
2711	1	2022	1682
2711	1	1990	1210
2711	3	1990	65
2711	3	2022	102
2712	1	2022	508
2712	1	1990	391
2712	3	1990	5
2712	3	2022	21.4254750736232
2713	1	2022	313
2713	1	1990	273
2713	3	1990	0
2713	3	2022	21.6631578947367
2714	1	2022	2487
2714	1	1990	2107
2714	3	1990	62
2714	3	2022	136.614026125821
2715	1	2022	2342
2715	1	1990	1586
2715	3	1990	27
2715	3	2022	77.3393102229712
2716	1	2022	1344
2716	1	1990	1207
2716	3	1990	65
2716	3	2022	77.054091539529
2717	1	2022	384
2717	1	1990	312
2717	3	1990	3
2717	3	2022	13.1346000682671
2718	1	2022	32193
2718	1	1990	30553
2718	3	1990	1813
2718	3	2022	3158.00140507978
2719	1	2022	106
2719	1	1990	110
2719	3	1990	4
2719	3	2022	9.29032258064517
2720	1	2022	476
2720	1	1990	381
2720	3	1990	16
2720	3	2022	16
2721	1	2022	3983
2721	1	1990	4169
2721	3	1990	162
2721	3	2022	462
2722	1	2022	486
2722	1	1990	455
2722	3	1990	30
2722	3	2022	41.7481877788483
2723	1	2022	609
2723	1	1990	583
2723	3	1990	9
2723	3	2022	37.4774193548385
2724	1	2022	167
2724	1	1990	152
2724	3	1990	21
2724	3	2022	4
2725	1	2022	109
2725	1	1990	78
2725	3	1990	8
2725	3	2022	11
2726	1	2022	258
2726	1	1990	219
2726	3	1990	10
2726	3	2022	13
2727	1	2022	222
2727	1	1990	190
2727	3	1990	14
2727	3	2022	9.04958677685952
2728	1	2022	200
2728	1	1990	202
2728	3	1990	19
2728	3	2022	10.1556396851152
2729	1	2022	325
2729	1	1990	266
2729	3	1990	20
2729	3	2022	15.0589965397924
2730	1	2022	316
2730	1	1990	269
2730	3	1990	11
2730	3	2022	12.3295135135136
2731	1	2022	207
2731	1	1990	151
2731	3	1990	7
2731	3	2022	10.4753246753247
2732	1	2022	2002
2732	1	1990	1828
2732	3	1990	95
2732	3	2022	149.161401309648
2733	1	2022	1177
2733	1	1990	826
2733	3	1990	6
2733	3	2022	35.3805461978037
2734	1	2022	419
2734	1	1990	311
2734	3	1990	2
2734	3	2022	9.27482322978456
2735	1	2022	174
2735	1	1990	183
2735	3	1990	3
2735	3	2022	8.89768669461264
2736	1	2022	1000
2736	1	1990	857
2736	3	1990	8
2736	3	2022	31
2737	1	2022	188
2737	1	1990	184
2737	3	1990	3
2737	3	2022	6.00000000000001
2738	1	2022	1498
2738	1	1990	1354
2738	3	1990	31
2738	3	2022	122.906918592168
2739	1	2022	504
2739	1	1990	430
2739	3	1990	17
2739	3	2022	21.8930424359525
2740	1	2022	329
2740	1	1990	340
2740	3	1990	11
2740	3	2022	15
2741	1	2022	1678
2741	1	1990	1050
2741	3	1990	17
2741	3	2022	41.2505537995016
2742	1	2022	552
2742	1	1990	548
2742	3	1990	5
2742	3	2022	42
2743	1	2022	236
2743	1	1990	195
2743	3	1990	9
2743	3	2022	5.03241672255757
2744	1	2022	2965
2744	1	1990	3032
2744	3	1990	57
2744	3	2022	136.781070986911
2745	1	2022	831
2745	1	1990	636
2745	3	1990	35
2745	3	2022	26.0922091206036
2746	1	2022	517
2746	1	1990	468
2746	3	1990	49
2746	3	2022	43.8113207547171
2747	1	2022	215
2747	1	1990	217
2747	3	1990	14
2747	3	2022	22.2943634423898
2748	1	2022	5784
2748	1	1990	4021
2748	3	1990	57
2748	3	2022	271.271346069308
2749	1	2022	6386
2749	1	1990	5362
2749	3	1990	75
2749	3	2022	223.064277856259
2750	1	2022	397
2750	1	1990	314
2750	3	1990	9
2750	3	2022	25
2751	1	2022	651
2751	1	1990	532
2751	3	1990	28
2751	3	2022	30.5550490084339
2752	1	2022	289
2752	1	1990	256
2752	3	1990	6
2752	3	2022	5
2753	1	2022	373
2753	1	1990	376
2753	3	1990	26
2753	3	2022	23.2169811320754
2754	1	2022	252
2754	1	1990	228
2754	3	1990	8
2754	3	2022	13.4955076192361
2755	1	2022	612
2755	1	1990	613
2755	3	1990	14
2755	3	2022	25.2100840336135
2756	1	2022	41
2756	1	1990	46
2756	3	1990	5
2756	3	2022	8.18048780487803
2757	1	2022	2103
2757	1	1990	1370
2757	3	1990	27
2757	3	2022	44.9654312039901
2758	1	2022	692
2758	1	1990	703
2758	3	1990	26
2758	3	2022	57
2759	1	2022	179
2759	1	1990	190
2759	3	1990	13
2759	3	2022	6.42755825734549
2760	1	2022	1246
2760	1	1990	1353
2760	3	1990	66
2760	3	2022	118
2761	1	2022	310
2761	1	1990	253
2761	3	1990	16
2761	3	2022	16
2762	1	2022	489
2762	1	1990	387
2762	3	1990	18
2762	3	2022	19.6681768949429
2763	1	2022	589
2763	1	1990	483
2763	3	1990	37
2763	3	2022	33.3267326732673
2764	1	2022	176
2764	1	1990	154
2764	3	1990	7
2764	3	2022	6.55415713196033
2765	1	2022	1366
2765	1	1990	1324
2765	3	1990	73
2765	3	2022	125.506417036762
2766	1	2022	2340
2766	1	1990	2465
2766	3	1990	104
2766	3	2022	222
2767	1	2022	128
2767	1	1990	120
2767	3	1990	4
2767	3	2022	9
2768	1	2022	2383
2768	1	1990	1597
2768	3	1990	23
2768	3	2022	71.8846263734016
2769	1	2022	4639
2769	1	1990	5048
2769	3	1990	66
2769	3	2022	421.871087332601
2770	1	2022	377
2770	1	1990	264
2770	3	1990	3
2770	3	2022	13.3700786847177
2771	1	2022	1830
2771	1	1990	1662
2771	3	1990	69
2771	3	2022	119.3475080323
2772	1	2022	516
2772	1	1990	513
2772	3	1990	21
2772	3	2022	39.027103721976
2773	1	2022	914
2773	1	1990	627
2773	3	1990	25
2773	3	2022	34.5478436819522
2774	1	2022	1359
2774	1	1990	1424
2774	3	1990	71
2774	3	2022	164.165769392157
2775	1	2022	273
2775	1	1990	102
2775	3	1990	11
2775	3	2022	22
2776	1	2022	263
2776	1	1990	272
2776	3	1990	16
2776	3	2022	11.3087022900764
2777	1	2022	1133
2777	1	1990	855
2777	3	1990	25
2777	3	2022	80.6282670813173
2778	1	2022	815
2778	1	1990	503
2778	3	1990	40
2778	3	2022	32.489072908075
2779	1	2022	413
2779	1	1990	340
2779	3	1990	15
2779	3	2022	11.1892516507703
2780	1	2022	158
2780	1	1990	155
2780	3	1990	10
2780	3	2022	11.2930951231289
2781	1	2022	246
2781	1	1990	244
2781	3	1990	8
2781	3	2022	16.225352112676
2782	1	2022	2576
2782	1	1990	2338
2782	3	1990	151
2782	3	2022	158.551751079121
2783	1	2022	810
2783	1	1990	643
2783	3	1990	7
2783	3	2022	46
2784	1	2022	405
2784	1	1990	301
2784	3	1990	17
2784	3	2022	16.3232323232322
2785	1	2022	1110
2785	1	1990	937
2785	3	1990	94
2785	3	2022	53.3492260613229
2786	1	2022	3106
2786	1	1990	2653
2786	3	1990	78
2786	3	2022	125.926118222442
2787	1	2022	837
2787	1	1990	869
2787	3	1990	13
2787	3	2022	32
2788	1	2022	254
2788	1	1990	290
2788	3	1990	4
2788	3	2022	20.4225352112676
2789	1	2022	108
2789	1	1990	114
2789	3	1990	3
2789	3	2022	3.26086956521739
2790	1	2022	193
2790	1	1990	205
2790	3	1990	6
2790	3	2022	16
2791	1	2022	366
2791	1	1990	427
2791	3	1990	28
2791	3	2022	13.0616113744076
2792	1	2022	1081
2792	1	1990	714
2792	3	1990	14
2792	3	2022	36.8121235343933
2793	1	2022	280
2793	1	1990	238
2793	3	1990	12
2793	3	2022	6.04054054054056
2794	1	2022	850
2794	1	1990	901
2794	3	1990	20
2794	3	2022	45.4444872378415
2795	1	2022	1353
2795	1	1990	1164
2795	3	1990	77
2795	3	2022	117.526527708604
2796	1	2022	537
2796	1	1990	399
2796	3	1990	13
2796	3	2022	31.2187918630614
2797	1	2022	157
2797	1	1990	117
2797	3	1990	1
2797	3	2022	12
2798	1	2022	714
2798	1	1990	550
2798	3	1990	16
2798	3	2022	16.2164930995472
2799	1	2022	216
2799	1	1990	240
2799	3	1990	8
2799	3	2022	13.5046070460704
2800	1	2022	108
2800	1	1990	97
2800	3	1990	12
2800	3	2022	7.11864406779659
2801	1	2022	261
2801	1	1990	206
2801	3	1990	20
2801	3	2022	16.3677411477411
2802	1	2022	268
2802	1	1990	286
2802	3	1990	19
2802	3	2022	27.7785339427798
2803	1	2022	1206
2803	1	1990	1200
2803	3	1990	93
2803	3	2022	148.618541033435
2804	1	2022	159
2804	1	1990	163
2804	3	1990	5
2804	3	2022	7.08139534883718
2805	1	2022	654
2805	1	1990	540
2805	3	1990	25
2805	3	2022	42.0981063335736
2806	1	2022	163
2806	1	1990	173
2806	3	1990	11
2806	3	2022	1.01914539400666
2807	1	2022	358
2807	1	1990	318
2807	3	1990	6
2807	3	2022	15.8232710177901
2808	1	2022	2392
2808	1	1990	1182
2808	3	1990	26
2808	3	2022	69.6079170593775
2809	1	2022	405
2809	1	1990	273
2809	3	1990	13
2809	3	2022	6.13953488372098
2810	1	2022	341
2810	1	1990	283
2810	3	1990	36
2810	3	2022	26.1065573770492
2811	1	2022	827
2811	1	1990	623
2811	3	1990	23
2811	3	2022	33.794117647059
2812	1	2022	857
2812	1	1990	769
2812	3	1990	26
2812	3	2022	44
2813	1	2022	202
2813	1	1990	171
2813	3	1990	4
2813	3	2022	14.8951855047455
2814	1	2022	1015
2814	1	1990	834
2814	3	1990	60
2814	3	2022	52.4107488413691
2815	1	2022	327
2815	1	1990	308
2815	3	1990	17
2815	3	2022	18
2816	1	2022	625
2816	1	1990	540
2816	3	1990	32
2816	3	2022	26.5012582863786
2817	1	2022	5480
2817	1	1990	4343
2817	3	1990	67
2817	3	2022	140.896801103785
2818	1	2022	1307
2818	1	1990	1150
2818	3	1990	55
2818	3	2022	50.7972222222222
2819	1	2022	732
2819	1	1990	625
2819	3	1990	34
2819	3	2022	67.829273844753
2820	1	2022	223
2820	1	1990	264
2820	3	1990	9
2820	3	2022	13.4882343774349
2821	1	2022	272
2821	1	1990	197
2821	3	1990	9
2821	3	2022	17
2822	1	2022	283
2822	1	1990	267
2822	3	1990	6
2822	3	2022	17.49652374031
2823	1	2022	4696
2823	1	1990	5882
2823	3	1990	385
2823	3	2022	552.427602043059
2824	1	2022	334
2824	1	1990	230
2824	3	1990	22
2824	3	2022	9
2825	1	2022	241
2825	1	1990	317
2825	3	1990	15
2825	3	2022	13
2826	1	2022	304
2826	1	1990	287
2826	3	1990	12
2826	3	2022	6.19175257731962
2827	1	2022	1641
2827	1	1990	1518
2827	3	1990	71
2827	3	2022	107.33105022831
2828	1	2022	589
2828	1	1990	527
2828	3	1990	18
2828	3	2022	36.0007187780774
2829	1	2022	470
2829	1	1990	452
2829	3	1990	19
2829	3	2022	18
2830	1	2022	147
2830	1	1990	108
2830	3	1990	14
2830	3	2022	9.10713031260978
2831	1	2022	403
2831	1	1990	296
2831	3	1990	19
2831	3	2022	8
2832	1	2022	247
2832	1	1990	217
2832	3	1990	7
2832	3	2022	5
2833	1	2022	1028
2833	1	1990	528
2833	3	1990	28
2833	3	2022	50
2834	1	2022	166
2834	1	1990	132
2834	3	1990	11
2834	3	2022	6
2835	1	2022	550
2835	1	1990	634
2835	3	1990	49
2835	3	2022	55.5414667732766
2836	1	2022	94
2836	1	1990	134
2836	3	1990	16
2836	3	2022	6.77419354838709
2837	1	2022	317
2837	1	1990	296
2837	3	1990	8
2837	3	2022	19
2838	1	2022	169
2838	1	1990	169
2838	3	1990	6
2838	3	2022	11
2839	1	2022	399
2839	1	1990	433
2839	3	1990	13
2839	3	2022	31.7264698234666
2840	1	2022	208
2840	1	1990	149
2840	3	1990	3
2840	3	2022	14
2841	1	2022	316
2841	1	1990	275
2841	3	1990	13
2841	3	2022	21.91985428051
2842	1	2022	101
2842	1	1990	89
2842	3	1990	2
2842	3	2022	4
2843	1	2022	814
2843	1	1990	731
2843	3	1990	42
2843	3	2022	49.1062820901716
2844	1	2022	1079
2844	1	1990	706
2844	3	1990	26
2844	3	2022	36.328474140856
2845	1	2022	274
2845	1	1990	280
2845	3	1990	12
2845	3	2022	10.7048571062412
2846	1	2022	343
2846	1	1990	347
2846	3	1990	28
2846	3	2022	24.3308547008547
2847	1	2022	686
2847	1	1990	513
2847	3	1990	9
2847	3	2022	11.2513340058184
2848	1	2022	221
2848	1	1990	163
2848	3	1990	9
2848	3	2022	14.1447028423773
2849	1	2022	555
2849	1	1990	400
2849	3	1990	45
2849	3	2022	61
2850	1	2022	361
2850	1	1990	452
2850	3	1990	42
2850	3	2022	35.8354725381752
2851	1	2022	395
2851	1	1990	526
2851	3	1990	12
2851	3	2022	40.2656432180331
2852	1	2022	141
2852	1	1990	125
2852	3	1990	15
2852	3	2022	8
2853	1	2022	1335
2853	1	1990	1042
2853	3	1990	88
2853	3	2022	76.9089291323171
2854	1	2022	1589
2854	1	1990	1257
2854	3	1990	57
2854	3	2022	109.149175703743
2855	1	2022	98
2855	1	1990	86
2855	3	1990	9
2855	3	2022	3.12374999999999
2856	1	2022	692
2856	1	1990	522
2856	3	1990	32
2856	3	2022	28.3518338300999
2857	1	2022	275
2857	1	1990	255
2857	3	1990	20
2857	3	2022	8.08556149732622
2858	1	2022	731
2858	1	1990	766
2858	3	1990	85
2858	3	2022	68
2859	1	2022	2297
2859	1	1990	2454
2859	3	1990	108
2859	3	2022	203.150646048939
2860	1	2022	559
2860	1	1990	572
2860	3	1990	8
2860	3	2022	33.4813341493268
2861	1	2022	3913
2861	1	1990	2983
2861	3	1990	65
2861	3	2022	176.153367706353
2862	1	2022	1430
2862	1	1990	747
2862	3	1990	12
2862	3	2022	42.659966548314
2863	1	2022	678
2863	1	1990	652
2863	3	1990	70
2863	3	2022	35.4838709677417
2864	1	2022	206
2864	1	1990	251
2864	3	1990	21
2864	3	2022	13
2865	1	2022	375
2865	1	1990	261
2865	3	1990	4
2865	3	2022	17.3736263736265
2866	1	2022	409
2866	1	1990	319
2866	3	1990	18
2866	3	2022	6
2867	1	2022	422
2867	1	1990	404
2867	3	1990	11
2867	3	2022	32
2868	1	2022	363
2868	1	1990	279
2868	3	1990	7
2868	3	2022	11.8400440498314
2869	1	2022	664
2869	1	1990	489
2869	3	1990	24
2869	3	2022	17.5157213676803
2870	1	2022	874
2870	1	1990	692
2870	3	1990	28
2870	3	2022	36.1312736522117
2871	1	2022	17361
2871	1	1990	17113
2871	3	1990	1027
2871	3	2022	1204.64025526395
2872	1	2022	165
2872	1	1990	67
2872	3	1990	10
2872	3	2022	6
2873	1	2022	1486
2873	1	1990	1220
2873	3	1990	75
2873	3	2022	79.5660277293733
2874	1	2022	175
2874	1	1990	126
2874	3	1990	13
2874	3	2022	3.85054321896427
2875	1	2022	118
2875	1	1990	104
2875	3	1990	2
2875	3	2022	10.1369863013699
2876	1	2022	201
2876	1	1990	186
2876	3	1990	8
2876	3	2022	5.83380207878417
2877	1	2022	611
2877	1	1990	455
2877	3	1990	5
2877	3	2022	20
2878	1	2022	99
2878	1	1990	141
2878	3	1990	12
2878	3	2022	18
2879	1	2022	1330
2879	1	1990	1255
2879	3	1990	72
2879	3	2022	47.1522991351558
2880	1	2022	1455
2880	1	1990	1455
2880	3	1990	158
2880	3	2022	169.686771133272
2881	1	2022	3082
2881	1	1990	3450
2881	3	1990	170
2881	3	2022	381.055220359156
2882	1	2022	1199
2882	1	1990	817
2882	3	1990	23
2882	3	2022	43.9789842381785
2883	1	2022	628
2883	1	1990	695
2883	3	1990	45
2883	3	2022	81.7883211678829
2884	1	2022	449
2884	1	1990	298
2884	3	1990	13
2884	3	2022	20.1801801801802
2885	1	2022	573
2885	1	1990	412
2885	3	1990	20
2885	3	2022	14.2944366732927
2886	1	2022	898
2886	1	1990	979
2886	3	1990	86
2886	3	2022	132.354474477297
2887	1	2022	741
2887	1	1990	789
2887	3	1990	47
2887	3	2022	57.3116317991632
2888	1	2022	2358
2888	1	1990	2431
2888	3	1990	117
2888	3	2022	187.741249404078
2889	1	2022	167
2889	1	1990	166
2889	3	1990	5
2889	3	2022	16.3092001849284
2890	1	2022	193
2890	1	1990	259
2890	3	1990	20
2890	3	2022	29.9999999999999
2891	1	2022	400
2891	1	1990	381
2891	3	1990	11
2891	3	2022	7
2892	1	2022	2104
2892	1	1990	2423
2892	3	1990	85
2892	3	2022	145
2893	1	2022	641
2893	1	1990	476
2893	3	1990	8
2893	3	2022	36.569037609517
2894	1	2022	271
2894	1	1990	259
2894	3	1990	29
2894	3	2022	19.5564232721593
2895	1	2022	233
2895	1	1990	309
2895	3	1990	28
2895	3	2022	13.3844580777096
2896	1	2022	222
2896	1	1990	227
2896	3	1990	17
2896	3	2022	14
2897	1	2022	255
2897	1	1990	207
2897	3	1990	7
2897	3	2022	15.0007891194355
2898	1	2022	2667
2898	1	1990	3094
2898	3	1990	62
2898	3	2022	150
2899	1	2022	744
2899	1	1990	658
2899	3	1990	18
2899	3	2022	50.1471838702608
2900	1	2022	324
2900	1	1990	246
2900	3	1990	15
2900	3	2022	10
2901	1	2022	286
2901	1	1990	306
2901	3	1990	16
2901	3	2022	28
2902	1	2022	139
2902	1	1990	120
2902	3	1990	8
2902	3	2022	3
2903	1	2022	562
2903	1	1990	611
2903	3	1990	27
2903	3	2022	40.179006098014
2904	1	2022	817
2904	1	1990	610
2904	3	1990	29
2904	3	2022	21
2905	1	2022	77
2905	1	1990	90
2905	3	1990	4
2905	3	2022	11
2906	1	2022	197
2906	1	1990	222
2906	3	1990	8
2906	3	2022	17
2907	1	2022	318
2907	1	1990	320
2907	3	1990	14
2907	3	2022	15.1694581280789
2908	1	2022	6937
2908	1	1990	7015
2908	3	1990	365
2908	3	2022	701.795046945982
2909	1	2022	239
2909	1	1990	303
2909	3	1990	13
2909	3	2022	25
2910	1	2022	252
2910	1	1990	162
2910	3	1990	14
2910	3	2022	14
2911	1	2022	314
2911	1	1990	260
2911	3	1990	2
2911	3	2022	9
2912	1	2022	334
2912	1	1990	316
2912	3	1990	6
2912	3	2022	31
2913	1	2022	115
2913	1	1990	127
2913	3	1990	10
2913	3	2022	7
2914	1	2022	9360
2914	1	1990	8875
2914	3	1990	220
2914	3	2022	448.07707140156
2915	1	2022	307
2915	1	1990	215
2915	3	1990	18
2915	3	2022	13.1364605543711
2916	1	2022	2495
2916	1	1990	2394
2916	3	1990	67
2916	3	2022	159
2917	1	2022	290
2917	1	1990	274
2917	3	1990	3
2917	3	2022	13.0167865707434
2918	1	2022	190
2918	1	1990	189
2918	3	1990	18
2918	3	2022	10
2919	1	2022	572
2919	1	1990	461
2919	3	1990	25
2919	3	2022	24.9005686277165
2920	1	2022	213
2920	1	1990	177
2920	3	1990	3
2920	3	2022	3.9
2921	1	2022	195
2921	1	1990	124
2921	3	1990	7
2921	3	2022	6.17327102803737
2922	1	2022	4192
2922	1	1990	4479
2922	3	1990	35
2922	3	2022	104.944636076435
2923	1	2022	1846
2923	1	1990	1864
2923	3	1990	123
2923	3	2022	162.667317375624
2924	1	2022	200
2924	1	1990	274
2924	3	1990	2
2924	3	2022	41
2925	1	2022	307
2925	1	1990	227
2925	3	1990	14
2925	3	2022	10.7006369426752
2926	1	2022	995
2926	1	1990	784
2926	3	1990	14
2926	3	2022	63.7791519434628
2927	1	2022	713
2927	1	1990	654
2927	3	1990	44
2927	3	2022	40
2928	1	2022	3776
2928	1	1990	3608
2928	3	1990	59
2928	3	2022	152
2929	1	2022	707
2929	1	1990	565
2929	3	1990	57
2929	3	2022	42.2772585669782
2930	1	2022	903
2930	1	1990	777
2930	3	1990	58
2930	3	2022	68.2539662500526
2931	1	2022	256
2931	1	1990	274
2931	3	1990	1
2931	3	2022	13.5416666666667
2932	1	2022	174
2932	1	1990	149
2932	3	1990	1
2932	3	2022	14.6022408963585
2933	1	2022	300
2933	1	1990	200
2933	3	1990	21
2933	3	2022	13.2150185791137
2934	1	2022	594
2934	1	1990	491
2934	3	1990	41
2934	3	2022	15
2935	1	2022	515
2935	1	1990	403
2935	3	1990	7
2935	3	2022	20.3247637292465
2936	1	2022	195
2936	1	1990	223
2936	3	1990	3
2936	3	2022	5.06900463181775
2937	1	2022	158
2937	1	1990	188
2937	3	1990	25
2937	3	2022	12.0967741935484
2938	1	2022	2091
2938	1	1990	980
2938	3	1990	11
2938	3	2022	41.4325049168605
2939	1	2022	529
2939	1	1990	531
2939	3	1990	17
2939	3	2022	35.1774891774891
2940	1	2022	180
2940	1	1990	153
2940	3	1990	16
2940	3	2022	6.25036440024006
2941	1	2022	714
2941	1	1990	534
2941	3	1990	19
2941	3	2022	27.295488385944
2942	1	2022	213
2942	1	1990	172
2942	3	1990	10
2942	3	2022	8.8
2943	1	2022	389
2943	1	1990	424
2943	3	1990	12
2943	3	2022	19.1687541550325
2944	1	2022	183
2944	1	1990	164
2944	3	1990	3
2944	3	2022	4.19687738004568
2945	1	2022	530
2945	1	1990	517
2945	3	1990	35
2945	3	2022	43.9397501314724
2946	1	2022	3183
2946	1	1990	2629
2946	3	1990	95
2946	3	2022	157.587954680978
2947	1	2022	703
2947	1	1990	452
2947	3	1990	7
2947	3	2022	28
2948	1	2022	474
2948	1	1990	464
2948	3	1990	36
2948	3	2022	31
2949	1	2022	100
2949	1	1990	87
2949	3	1990	7
2949	3	2022	5
2950	1	2022	498
2950	1	1990	330
2950	3	1990	12
2950	3	2022	17.4376463700234
2951	1	2022	1552
2951	1	1990	1238
2951	3	1990	23
2951	3	2022	66.6015348397499
2952	1	2022	862
2952	1	1990	689
2952	3	1990	28
2952	3	2022	26.6889927883132
2953	1	2022	266
2953	1	1990	233
2953	3	1990	12
2953	3	2022	14.2947368421053
2954	1	2022	683
2954	1	1990	557
2954	3	1990	14
2954	3	2022	52.8008591849929
2955	1	2022	501
2955	1	1990	631
2955	3	1990	25
2955	3	2022	52.4894002236324
2956	1	2022	383
2956	1	1990	308
2956	3	1990	10
2956	3	2022	17.1844745385943
2957	1	2022	86
2957	1	1990	63
2957	3	1990	10
2957	3	2022	7
2958	1	2022	1509
2958	1	1990	1204
2958	3	1990	25
2958	3	2022	71.4992251580176
2959	1	2022	255
2959	1	1990	245
2959	3	1990	15
2959	3	2022	19.4244604316547
2960	1	2022	560
2960	1	1990	381
2960	3	1990	20
2960	3	2022	12
2961	1	2022	459
2961	1	1990	501
2961	3	1990	18
2961	3	2022	17.2797576337399
2962	1	2022	157
2962	1	1990	159
2962	3	1990	14
2962	3	2022	10.8888888888889
2963	1	2022	326
2963	1	1990	225
2963	3	1990	16
2963	3	2022	19.0617424242424
2964	1	2022	6518
2964	1	1990	5938
2964	3	1990	189
2964	3	2022	516.058351046986
2965	1	2022	657
2965	1	1990	381
2965	3	1990	21
2965	3	2022	7.86674865038277
2966	1	2022	305
2966	1	1990	232
2966	3	1990	34
2966	3	2022	19.2146892655368
2967	1	2022	156
2967	1	1990	132
2967	3	1990	13
2967	3	2022	1
2968	1	2022	105
2968	1	1990	112
2968	3	1990	0
2968	3	2022	8.23062768350035
2969	1	2022	624
2969	1	1990	384
2969	3	1990	17
2969	3	2022	8.81779480630053
2970	1	2022	305
2970	1	1990	327
2970	3	1990	26
2970	3	2022	21.8995433789954
2971	1	2022	107
2971	1	1990	83
2971	3	1990	10
2971	3	2022	7.22857142857145
2972	1	2022	383
2972	1	1990	456
2972	3	1990	41
2972	3	2022	42.3900928792568
2973	1	2022	425
2973	1	1990	365
2973	3	1990	13
2973	3	2022	23
2974	1	2022	618
2974	1	1990	561
2974	3	1990	32
2974	3	2022	19.008986429228
2975	1	2022	1101
2975	1	1990	1348
2975	3	1990	28
2975	3	2022	73.1629955947136
2976	1	2022	377
2976	1	1990	347
2976	3	1990	31
2976	3	2022	33.7895537525355
2977	1	2022	185
2977	1	1990	199
2977	3	1990	8
2977	3	2022	21
2978	1	2022	276
2978	1	1990	215
2978	3	1990	17
2978	3	2022	28
2979	1	2022	871
2979	1	1990	635
2979	3	1990	4
2979	3	2022	28.4681574791931
2980	1	2022	358
2980	1	1990	244
2980	3	1990	12
2980	3	2022	11.844420770202
2981	1	2022	185
2981	1	1990	150
2981	3	1990	15
2981	3	2022	14.9233985260771
2982	1	2022	192
2982	1	1990	147
2982	3	1990	8
2982	3	2022	4.08888888888888
2983	1	2022	401
2983	1	1990	388
2983	3	1990	13
2983	3	2022	12.5663487440845
2984	1	2022	200
2984	1	1990	166
2984	3	1990	8
2984	3	2022	21.1794871794872
2985	1	2022	292
2985	1	1990	260
2985	3	1990	1
2985	3	2022	21.9308631421472
2986	1	2022	344
2986	1	1990	284
2986	3	1990	16
2986	3	2022	14.1676646706587
2987	1	2022	483
2987	1	1990	340
2987	3	1990	24
2987	3	2022	28.4433947981956
2988	1	2022	356
2988	1	1990	255
2988	3	1990	19
2988	3	2022	29.3143429143431
2989	1	2022	2388
2989	1	1990	2040
2989	3	1990	38
2989	3	2022	85.9529319120808
2990	1	2022	245
2990	1	1990	132
2990	3	1990	22
2990	3	2022	11.7209290795964
2991	1	2022	226
2991	1	1990	189
2991	3	1990	10
2991	3	2022	12.0715211499941
2992	1	2022	1187
2992	1	1990	1421
2992	3	1990	38
2992	3	2022	101.487603305785
2993	1	2022	287
2993	1	1990	289
2993	3	1990	18
2993	3	2022	16.1946651978913
2994	1	2022	855
2994	1	1990	732
2994	3	1990	45
2994	3	2022	33.375
2995	1	2022	87
2995	1	1990	68
2995	3	1990	3
2995	3	2022	3
2996	1	2022	242
2996	1	1990	142
2996	3	1990	9
2996	3	2022	4
2997	1	2022	525
2997	1	1990	372
2997	3	1990	16
2997	3	2022	23.5406584439632
2998	1	2022	482
2998	1	1990	312
2998	3	1990	24
2998	3	2022	29
2999	1	2022	565
2999	1	1990	463
2999	3	1990	33
2999	3	2022	36.5202312138728
3000	1	2022	638
3000	1	1990	422
3000	3	1990	20
3000	3	2022	31.4664351851852
3001	1	2022	569
3001	1	1990	685
3001	3	1990	51
3001	3	2022	48.2285714285711
3002	1	2022	385
3002	1	1990	425
3002	3	1990	6
3002	3	2022	24.411481641066
3003	1	2022	214
3003	1	1990	217
3003	3	1990	22
3003	3	2022	25
3004	1	2022	317
3004	1	1990	273
3004	3	1990	1
3004	3	2022	9.89281093765943
3005	1	2022	156
3005	1	1990	189
3005	3	1990	13
3005	3	2022	12.0975609756097
3006	1	2022	142
3006	1	1990	154
3006	3	1990	2
3006	3	2022	3.84823375857858
3007	1	2022	199
3007	1	1990	241
3007	3	1990	41
3007	3	2022	27
3008	1	2022	176
3008	1	1990	190
3008	3	1990	26
3008	3	2022	22
3009	1	2022	1178
3009	1	1990	822
3009	3	1990	12
3009	3	2022	51.4975951889705
3010	1	2022	1057
3010	1	1990	1021
3010	3	1990	31
3010	3	2022	65.0207070707071
3011	1	2022	659
3011	1	1990	718
3011	3	1990	69
3011	3	2022	107.389444628099
3012	1	2022	224
3012	1	1990	217
3012	3	1990	11
3012	3	2022	18
3013	1	2022	65
3013	1	1990	104
3013	3	1990	11
3013	3	2022	8
3014	1	2022	380
3014	1	1990	345
3014	3	1990	12
3014	3	2022	7.88454545454545
3015	1	2022	1112
3015	1	1990	933
3015	3	1990	37
3015	3	2022	58.4279603523033
3016	1	2022	209
3016	1	1990	138
3016	3	1990	14
3016	3	2022	6.11035357539242
3017	1	2022	225
3017	1	1990	194
3017	3	1990	9
3017	3	2022	11.9774011299435
3018	1	2022	448
3018	1	1990	450
3018	3	1990	35
3018	3	2022	19.8056667837489
3019	1	2022	9461
3019	1	1990	9334
3019	3	1990	397
3019	3	2022	641
3020	1	2022	140
3020	1	1990	104
3020	3	1990	3
3020	3	2022	8
3021	1	2022	742
3021	1	1990	839
3021	3	1990	28
3021	3	2022	45.6041069075476
3022	1	2022	140
3022	1	1990	132
3022	3	1990	8
3022	3	2022	5
3023	1	2022	404
3023	1	1990	339
3023	3	1990	6
3023	3	2022	12.450441920828
3024	1	2022	866
3024	1	1990	836
3024	3	1990	37
3024	3	2022	48.7382582920737
3025	1	2022	658
3025	1	1990	680
3025	3	1990	25
3025	3	2022	25
3026	1	2022	544
3026	1	1990	549
3026	3	1990	35
3026	3	2022	38.3904109589041
3027	1	2022	980
3027	1	1990	1336
3027	3	1990	32
3027	3	2022	80.8228487526925
3028	1	2022	109
3028	1	1990	130
3028	3	1990	11
3028	3	2022	8
3029	1	2022	411
3029	1	1990	366
3029	3	1990	34
3029	3	2022	24
3030	1	2022	321
3030	1	1990	244
3030	3	1990	23
3030	3	2022	22.2279792746114
3031	1	2022	22004
3031	1	1990	22782
3031	3	1990	1137
3031	3	2022	1927.46944952719
3032	1	2022	1265
3032	1	1990	1195
3032	3	1990	77
3032	3	2022	131.809421841542
3033	1	2022	474
3033	1	1990	511
3033	3	1990	25
3033	3	2022	30.9564428312159
3034	1	2022	1696
3034	1	1990	1631
3034	3	1990	24
3034	3	2022	51.2492941840768
3035	1	2022	378
3035	1	1990	410
3035	3	1990	27
3035	3	2022	20.080971659919
3036	1	2022	510
3036	1	1990	572
3036	3	1990	11
3036	3	2022	14.5588778146917
3037	1	2022	196
3037	1	1990	163
3037	3	1990	5
3037	3	2022	6.96416674449732
3038	1	2022	159
3038	1	1990	123
3038	3	1990	3
3038	3	2022	5
3039	1	2022	215
3039	1	1990	188
3039	3	1990	7
3039	3	2022	4.53565722585329
3040	1	2022	115
3040	1	1990	126
3040	3	1990	5
3040	3	2022	10.9983896940419
3041	1	2022	522
3041	1	1990	479
3041	3	1990	5
3041	3	2022	24
3042	1	2022	465
3042	1	1990	396
3042	3	1990	26
3042	3	2022	24.5111632892749
3043	1	2022	1042
3043	1	1990	645
3043	3	1990	9
3043	3	2022	18.6883466754611
3044	1	2022	262
3044	1	1990	263
3044	3	1990	7
3044	3	2022	9.05421686746986
3045	1	2022	2070
3045	1	1990	1069
3045	3	1990	10
3045	3	2022	78.9204553294241
3046	1	2022	695
3046	1	1990	531
3046	3	1990	18
3046	3	2022	33
3047	1	2022	114
3047	1	1990	110
3047	3	1990	1
3047	3	2022	5
3048	1	2022	128
3048	1	1990	161
3048	3	1990	2
3048	3	2022	12
3049	1	2022	167
3049	1	1990	173
3049	3	1990	13
3049	3	2022	7
3050	1	2022	665
3050	1	1990	539
3050	3	1990	31
3050	3	2022	60.5087331838565
3051	1	2022	207
3051	1	1990	273
3051	3	1990	6
3051	3	2022	14.1891891891892
3052	1	2022	327
3052	1	1990	433
3052	3	1990	13
3052	3	2022	16.9531195642481
3053	1	2022	305
3053	1	1990	309
3053	3	1990	10
3053	3	2022	16.5722212521584
3054	1	2022	466
3054	1	1990	381
3054	3	1990	10
3054	3	2022	21.3200791056311
3055	1	2022	224
3055	1	1990	222
3055	3	1990	8
3055	3	2022	9.08631578947366
3056	1	2022	724
3056	1	1990	514
3056	3	1990	14
3056	3	2022	21.5331010452962
3057	1	2022	138
3057	1	1990	103
3057	3	1990	9
3057	3	2022	5.1449275362319
3058	1	2022	895
3058	1	1990	760
3058	3	1990	13
3058	3	2022	26.0748630684116
3059	1	2022	42288
3059	1	1990	33041
3059	3	1990	774
3059	3	2022	1170.08446583855
3060	1	2022	94
3060	1	1990	121
3060	3	1990	10
3060	3	2022	9
3061	1	2022	383
3061	1	1990	310
3061	3	1990	10
3061	3	2022	17.1718570176579
3062	1	2022	178
3062	1	1990	120
3062	3	1990	0
3062	3	2022	5.35159817351599
3063	1	2022	134
3063	1	1990	139
3063	3	1990	7
3063	3	2022	6.67611336032388
3064	1	2022	658
3064	1	1990	588
3064	3	1990	22
3064	3	2022	20.363932521637
3065	1	2022	183
3065	1	1990	122
3065	3	1990	4
3065	3	2022	10.3370786516854
3066	1	2022	185
3066	1	1990	186
3066	3	1990	7
3066	3	2022	3.91666666666667
3067	1	2022	134
3067	1	1990	110
3067	3	1990	3
3067	3	2022	2.05882352941176
3068	1	2022	328
3068	1	1990	222
3068	3	1990	9
3068	3	2022	10.2739726027397
3069	1	2022	2364
3069	1	1990	1366
3069	3	1990	12
3069	3	2022	35.3655320510836
3070	1	2022	312
3070	1	1990	252
3070	3	1990	18
3070	3	2022	8.05405405405408
3071	1	2022	1235
3071	1	1990	965
3071	3	1990	27
3071	3	2022	25.1970612174956
3072	1	2022	3588
3072	1	1990	2506
3072	3	1990	44
3072	3	2022	128
3073	1	2022	246
3073	1	1990	185
3073	3	1990	4
3073	3	2022	15
3074	1	2022	1052
3074	1	1990	1137
3074	3	1990	96
3074	3	2022	38.2761448138626
3075	1	2022	846
3075	1	1990	546
3075	3	1990	6
3075	3	2022	19.1447788082347
3076	1	2022	699
3076	1	1990	695
3076	3	1990	14
3076	3	2022	21
3077	1	2022	274
3077	1	1990	197
3077	3	1990	3
3077	3	2022	7.30065876152833
3078	1	2022	80
3078	1	1990	79
3078	3	1990	7
3078	3	2022	5
3079	1	2022	67
3079	1	1990	98
3079	3	1990	1
3079	3	2022	6
3080	1	2022	392
3080	1	1990	372
3080	3	1990	18
3080	3	2022	19.3237404391809
3081	1	2022	238
3081	1	1990	314
3081	3	1990	11
3081	3	2022	17
3082	1	2022	134
3082	1	1990	68
3082	3	1990	2
3082	3	2022	5.37514019414472
3083	1	2022	231
3083	1	1990	254
3083	3	1990	8
3083	3	2022	11.1732283464567
3084	1	2022	92
3084	1	1990	123
3084	3	1990	2
3084	3	2022	1
3085	1	2022	435
3085	1	1990	365
3085	3	1990	20
3085	3	2022	10.3333333333332
3086	1	2022	105
3086	1	1990	102
3086	3	1990	2
3086	3	2022	4
3087	1	2022	198
3087	1	1990	138
3087	3	1990	0
3087	3	2022	3.16483516483515
3088	1	2022	816
3088	1	1990	817
3088	3	1990	13
3088	3	2022	11
3089	1	2022	136
3089	1	1990	145
3089	3	1990	7
3089	3	2022	6
3090	1	2022	1829
3090	1	1990	1640
3090	3	1990	35
3090	3	2022	107.761855057857
3091	1	2022	458
3091	1	1990	466
3091	3	1990	30
3091	3	2022	36.0596528328488
3092	1	2022	1100
3092	1	1990	669
3092	3	1990	9
3092	3	2022	14.4977777777778
3093	1	2022	2025
3093	1	1990	898
3093	3	1990	15
3093	3	2022	35.5112862318841
3094	1	2022	3446
3094	1	1990	3038
3094	3	1990	38
3094	3	2022	95
3095	1	2022	2238
3095	1	1990	2537
3095	3	1990	70
3095	3	2022	85.4182905806863
3096	1	2022	1052
3096	1	1990	807
3096	3	1990	3
3096	3	2022	57.5122841444266
3097	1	2022	492
3097	1	1990	601
3097	3	1990	26
3097	3	2022	42.3012553468476
3098	1	2022	4561
3098	1	1990	2653
3098	3	1990	64
3098	3	2022	185.232244016994
3099	1	2022	344
3099	1	1990	294
3099	3	1990	7
3099	3	2022	15
3100	1	2022	2055
3100	1	1990	1244
3100	3	1990	16
3100	3	2022	66.2889260000879
3101	1	2022	1997
3101	1	1990	1652
3101	3	1990	28
3101	3	2022	91.3619066137049
3102	1	2022	225
3102	1	1990	159
3102	3	1990	12
3102	3	2022	17.3221329952099
3103	1	2022	350
3103	1	1990	198
3103	3	1990	2
3103	3	2022	11
3104	1	2022	211
3104	1	1990	197
3104	3	1990	17
3104	3	2022	5
3105	1	2022	662
3105	1	1990	607
3105	3	1990	26
3105	3	2022	26.8468630299828
3106	1	2022	266
3106	1	1990	199
3106	3	1990	2
3106	3	2022	8.07339449541288
3107	1	2022	45
3107	1	1990	48
3107	3	1990	3
3107	3	2022	4.62962962962963
3108	1	2022	168
3108	1	1990	203
3108	3	1990	8
3108	3	2022	9.41981424148604
3109	1	2022	185
3109	1	1990	136
3109	3	1990	2
3109	3	2022	5.0609756097561
3110	1	2022	234
3110	1	1990	180
3110	3	1990	6
3110	3	2022	7.59399900645804
3111	1	2022	108
3111	1	1990	141
3111	3	1990	3
3111	3	2022	0
3112	1	2022	833
3112	1	1990	406
3112	3	1990	4
3112	3	2022	13.3659602649006
3113	1	2022	235
3113	1	1990	274
3113	3	1990	12
3113	3	2022	4
3114	1	2022	143
3114	1	1990	146
3114	3	1990	4
3114	3	2022	9
3115	1	2022	213
3115	1	1990	205
3115	3	1990	12
3115	3	2022	7.17422222222223
3116	1	2022	134
3116	1	1990	165
3116	3	1990	9
3116	3	2022	5.72712550607287
3117	1	2022	103
3117	1	1990	74
3117	3	1990	7
3117	3	2022	1.0062893081761
3118	1	2022	1133
3118	1	1990	791
3118	3	1990	13
3118	3	2022	58.5678132240241
3119	1	2022	867
3119	1	1990	777
3119	3	1990	28
3119	3	2022	32.3747318653419
3120	1	2022	313
3120	1	1990	209
3120	3	1990	1
3120	3	2022	11.2374100719424
3121	1	2022	131
3121	1	1990	122
3121	3	1990	14
3121	3	2022	6
3122	1	2022	117
3122	1	1990	113
3122	3	1990	1
3122	3	2022	8.86363636363637
3123	1	2022	504
3123	1	1990	365
3123	3	1990	9
3123	3	2022	14.1212121212121
3124	1	2022	355
3124	1	1990	426
3124	3	1990	21
3124	3	2022	25.7660676147314
3125	1	2022	645
3125	1	1990	788
3125	3	1990	24
3125	3	2022	48.8371965139567
3126	1	2022	1905
3126	1	1990	1188
3126	3	1990	18
3126	3	2022	59.7254411749204
3127	1	2022	584
3127	1	1990	470
3127	3	1990	9
3127	3	2022	17.9245807071893
3128	1	2022	187
3128	1	1990	160
3128	3	1990	13
3128	3	2022	7
3129	1	2022	627
3129	1	1990	455
3129	3	1990	14
3129	3	2022	20.4932324208003
3130	1	2022	65
3130	1	1990	76
3130	3	1990	2
3130	3	2022	5.86929330831772
3131	1	2022	96
3131	1	1990	105
3131	3	1990	1
3131	3	2022	4
3132	1	2022	3317
3132	1	1990	1056
3132	3	1990	15
3132	3	2022	111.190759927755
3133	1	2022	585
3133	1	1990	402
3133	3	1990	16
3133	3	2022	32.1159999999999
3134	1	2022	53312
3134	1	1990	40051
3134	3	1990	1795
3134	3	2022	1756.44354776428
3135	1	2022	207
3135	1	1990	204
3135	3	1990	4
3135	3	2022	11
3136	1	2022	574
3136	1	1990	554
3136	3	1990	26
3136	3	2022	29
3137	1	2022	263
3137	1	1990	292
3137	3	1990	16
3137	3	2022	16.7441860465117
3138	1	2022	505
3138	1	1990	386
3138	3	1990	3
3138	3	2022	18
3139	1	2022	69
3139	1	1990	72
3139	3	1990	4
3139	3	2022	3.67479674796749
3140	1	2022	911
3140	1	1990	702
3140	3	1990	28
3140	3	2022	59.0788556124264
3141	1	2022	1987
3141	1	1990	1587
3141	3	1990	24
3141	3	2022	51.8209255380886
3142	1	2022	228
3142	1	1990	204
3142	3	1990	14
3142	3	2022	9.59748427672958
3143	1	2022	108
3143	1	1990	110
3143	3	1990	5
3143	3	2022	9
3144	1	2022	423
3144	1	1990	496
3144	3	1990	10
3144	3	2022	25.3807281021357
3145	1	2022	120
3145	1	1990	120
3145	3	1990	6
3145	3	2022	5.2112676056338
3146	1	2022	587
3146	1	1990	534
3146	3	1990	9
3146	3	2022	8
3147	1	2022	156
3147	1	1990	142
3147	3	1990	1
3147	3	2022	6.64204545454545
3148	1	2022	248
3148	1	1990	278
3148	3	1990	2
3148	3	2022	17.536837204207
3149	1	2022	146
3149	1	1990	103
3149	3	1990	0
3149	3	2022	2.66666666666667
3150	1	2022	48
3150	1	1990	85
3150	3	1990	4
3150	3	2022	6.1875
3151	1	2022	675
3151	1	1990	505
3151	3	1990	14
3151	3	2022	13
3152	1	2022	536
3152	1	1990	460
3152	3	1990	18
3152	3	2022	13.0515873015872
3153	1	2022	195
3153	1	1990	82
3153	3	1990	2
3153	3	2022	4.01709401709401
3154	1	2022	25810
3154	1	1990	28742
3154	3	1990	1356
3154	3	2022	559.793968598478
3155	1	2022	1347
3155	1	1990	1039
3155	3	1990	40
3155	3	2022	90.4426433915218
3156	1	2022	675
3156	1	1990	585
3156	3	1990	46
3156	3	2022	46.1525882551348
3157	1	2022	7674
3157	1	1990	4123
3157	3	1990	30
3157	3	2022	174
3158	1	2022	1109
3158	1	1990	1317
3158	3	1990	16
3158	3	2022	40
3159	1	2022	377
3159	1	1990	470
3159	3	1990	26
3159	3	2022	22
3160	1	2022	155
3160	1	1990	153
3160	3	1990	1
3160	3	2022	5
3161	1	2022	14037
3161	1	1990	12570
3161	3	1990	404
3161	3	2022	744.46481920545
3162	1	2022	1259
3162	1	1990	694
3162	3	1990	7
3162	3	2022	38.4488720219271
3163	1	2022	607
3163	1	1990	529
3163	3	1990	2
3163	3	2022	18.4632352941176
3164	1	2022	4570
3164	1	1990	4298
3164	3	1990	77
3164	3	2022	207.738796777354
3165	1	2022	1330
3165	1	1990	962
3165	3	1990	17
3165	3	2022	27
3166	1	2022	371
3166	1	1990	228
3166	3	1990	0
3166	3	2022	6.52257495590831
3167	1	2022	801
3167	1	1990	682
3167	3	1990	40
3167	3	2022	24.5986839122672
3168	1	2022	114
3168	1	1990	195
3168	3	1990	1
3168	3	2022	5
3169	1	2022	676
3169	1	1990	576
3169	3	1990	7
3169	3	2022	16.5378315609339
3170	1	2022	2878
3170	1	1990	1652
3170	3	1990	22
3170	3	2022	68.0726646564578
3171	1	2022	969
3171	1	1990	872
3171	3	1990	28
3171	3	2022	14.1217408489675
3172	1	2022	8934
3172	1	1990	6814
3172	3	1990	134
3172	3	2022	285.822909636687
3173	1	2022	391
3173	1	1990	323
3173	3	1990	16
3173	3	2022	9.2711598746081
3174	1	2022	857
3174	1	1990	600
3174	3	1990	3
3174	3	2022	26.2972132034631
3175	1	2022	158
3175	1	1990	97
3175	3	1990	0
3175	3	2022	9
3176	1	2022	156
3176	1	1990	125
3176	3	1990	4
3176	3	2022	5.04545454545456
3177	1	2022	506
3177	1	1990	297
3177	3	1990	7
3177	3	2022	11.6470588235294
3178	1	2022	341
3178	1	1990	231
3178	3	1990	6
3178	3	2022	7.25073462356873
3179	1	2022	2920
3179	1	1990	1745
3179	3	1990	45
3179	3	2022	56.9761761648407
3180	1	2022	850
3180	1	1990	833
3180	3	1990	42
3180	3	2022	31.2465208747516
3181	1	2022	227
3181	1	1990	236
3181	3	1990	16
3181	3	2022	4.75665748393021
3182	1	2022	134
3182	1	1990	151
3182	3	1990	10
3182	3	2022	5.12048192771085
3183	1	2022	98
3183	1	1990	94
3183	3	1990	3
3183	3	2022	5.0806451612903
3184	1	2022	1988
3184	1	1990	1155
3184	3	1990	29
3184	3	2022	41
3185	1	2022	81
3185	1	1990	79
3185	3	1990	0
3185	3	2022	5
3186	1	2022	211
3186	1	1990	182
3186	3	1990	13
3186	3	2022	4
3187	1	2022	104
3187	1	1990	111
3187	3	1990	5
3187	3	2022	3.75757575757576
3188	1	2022	477
3188	1	1990	369
3188	3	1990	22
3188	3	2022	13.6409608091024
3189	1	2022	1011
3189	1	1990	951
3189	3	1990	27
3189	3	2022	52.5561772790605
3190	1	2022	170
3190	1	1990	129
3190	3	1990	3
3190	3	2022	5.32275132275133
3191	1	2022	103
3191	1	1990	104
3191	3	1990	6
3191	3	2022	8.77221742881794
3192	1	2022	6715
3192	1	1990	4128
3192	3	1990	199
3192	3	2022	317.786987971302
3193	1	2022	1019
3193	1	1990	705
3193	3	1990	51
3193	3	2022	53.3209002884393
3194	1	2022	105
3194	1	1990	119
3194	3	1990	5
3194	3	2022	1.0952380952381
3195	1	2022	294
3195	1	1990	289
3195	3	1990	6
3195	3	2022	12
3196	1	2022	174
3196	1	1990	145
3196	3	1990	0
3196	3	2022	8
3197	1	2022	217
3197	1	1990	167
3197	3	1990	5
3197	3	2022	5
3198	1	2022	662
3198	1	1990	536
3198	3	1990	23
3198	3	2022	31.259776536313
3199	1	2022	200
3199	1	1990	212
3199	3	1990	6
3199	3	2022	10.0813008130081
3200	1	2022	271
3200	1	1990	159
3200	3	1990	5
3200	3	2022	6.97278911564628
3201	1	2022	293
3201	1	1990	185
3201	3	1990	5
3201	3	2022	9.68852459016393
3202	1	2022	159
3202	1	1990	129
3202	3	1990	5
3202	3	2022	9.1543378995434
3203	1	2022	51
3203	1	1990	43
3203	3	1990	5
3203	3	2022	6.17647058823528
3204	1	2022	141
3204	1	1990	157
3204	3	1990	5
3204	3	2022	3.05600268276325
3205	1	2022	152
3205	1	1990	161
3205	3	1990	4
3205	3	2022	4
3206	1	2022	644
3206	1	1990	600
3206	3	1990	9
3206	3	2022	14.5816638312643
3207	1	2022	456
3207	1	1990	393
3207	3	1990	15
3207	3	2022	7.0917236854438
3208	1	2022	137
3208	1	1990	151
3208	3	1990	3
3208	3	2022	6.12121212121209
3209	1	2022	213
3209	1	1990	159
3209	3	1990	2
3209	3	2022	14.1186440677967
3210	1	2022	336
3210	1	1990	225
3210	3	1990	11
3210	3	2022	15.2807320111143
3211	1	2022	78
3211	1	1990	64
3211	3	1990	2
3211	3	2022	7.15555555555554
3212	1	2022	675
3212	1	1990	349
3212	3	1990	0
3212	3	2022	23.8971688034188
3213	1	2022	624
3213	1	1990	358
3213	3	1990	5
3213	3	2022	17.3400000000001
3214	1	2022	59
3214	1	1990	89
3214	3	1990	10
3214	3	2022	4.9014705882353
3215	1	2022	220
3215	1	1990	260
3215	3	1990	6
3215	3	2022	9.15384615384618
3216	1	2022	245
3216	1	1990	273
3216	3	1990	11
3216	3	2022	8.16335664335668
3217	1	2022	1048
3217	1	1990	1193
3217	3	1990	25
3217	3	2022	51
3218	1	2022	5957
3218	1	1990	5849
3218	3	1990	206
3218	3	2022	234
3219	1	2022	237
3219	1	1990	193
3219	3	1990	12
3219	3	2022	8.91964285714286
3220	1	2022	2170
3220	1	1990	2047
3220	3	1990	52
3220	3	2022	87.5197711489083
3221	1	2022	112
3221	1	1990	116
3221	3	1990	8
3221	3	2022	10.4918032786885
3222	1	2022	95
3222	1	1990	85
3222	3	1990	7
3222	3	2022	3
3223	1	2022	376
3223	1	1990	319
3223	3	1990	6
3223	3	2022	24.4000000000001
3224	1	2022	89
3224	1	1990	96
3224	3	1990	5
3224	3	2022	4.90384615384616
3225	1	2022	119
3225	1	1990	152
3225	3	1990	10
3225	3	2022	8
3226	1	2022	189
3226	1	1990	194
3226	3	1990	6
3226	3	2022	3.72057139006807
3227	1	2022	1774
3227	1	1990	1322
3227	3	1990	12
3227	3	2022	26.3065527825973
3228	1	2022	144
3228	1	1990	166
3228	3	1990	11
3228	3	2022	6.13737373737374
3229	1	2022	184
3229	1	1990	146
3229	3	1990	4
3229	3	2022	8.80105401844532
3230	1	2022	230
3230	1	1990	209
3230	3	1990	6
3230	3	2022	8.07207207207208
3231	1	2022	468
3231	1	1990	452
3231	3	1990	20
3231	3	2022	27.2378854625549
3232	1	2022	327
3232	1	1990	174
3232	3	1990	1
3232	3	2022	7.05384615384617
3233	1	2022	203
3233	1	1990	536
3233	3	1990	16
3233	3	2022	43.3024241105165
3234	1	2022	237
3234	1	1990	241
3234	3	1990	10
3234	3	2022	16
3235	1	2022	120
3235	1	1990	122
3235	3	1990	9
3235	3	2022	11.1466666666667
3236	1	2022	430
3236	1	1990	318
3236	3	1990	3
3236	3	2022	15.1522842639593
3237	1	2022	424
3237	1	1990	226
3237	3	1990	6
3237	3	2022	7.31482680005444
3238	1	2022	426
3238	1	1990	409
3238	3	1990	18
3238	3	2022	20
3239	1	2022	143
3239	1	1990	142
3239	3	1990	3
3239	3	2022	14.9417670682731
3240	1	2022	376
3240	1	1990	185
3240	3	1990	0
3240	3	2022	4.14583333333335
3241	1	2022	157
3241	1	1990	152
3241	3	1990	6
3241	3	2022	2.13230900554844
3242	1	2022	2094
3242	1	1990	1661
3242	3	1990	82
3242	3	2022	137.117224032439
3243	1	2022	501
3243	1	1990	522
3243	3	1990	8
3243	3	2022	9.13316699403658
3244	1	2022	110
3244	1	1990	108
3244	3	1990	1
3244	3	2022	4.57142857142857
3245	1	2022	1206
3245	1	1990	677
3245	3	1990	35
3245	3	2022	32.6273419390945
3246	1	2022	531
3246	1	1990	523
3246	3	1990	7
3246	3	2022	26.2677966101693
3247	1	2022	304
3247	1	1990	427
3247	3	1990	14
3247	3	2022	7.08045977011492
3248	1	2022	260
3248	1	1990	224
3248	3	1990	4
3248	3	2022	12.1777777777778
3249	1	2022	488
3249	1	1990	389
3249	3	1990	10
3249	3	2022	9.18955827511946
3250	1	2022	147
3250	1	1990	143
3250	3	1990	9
3250	3	2022	7.61518159176241
3251	1	2022	74
3251	1	1990	85
3251	3	1990	4
3251	3	2022	4
3252	1	2022	63
3252	1	1990	92
3252	3	1990	9
3252	3	2022	2.29378531073446
3253	1	2022	617
3253	1	1990	562
3253	3	1990	19
3253	3	2022	24.273537388609
3254	1	2022	619
3254	1	1990	630
3254	3	1990	17
3254	3	2022	37.6077670198514
3255	1	2022	203
3255	1	1990	138
3255	3	1990	3
3255	3	2022	7
3256	1	2022	676
3256	1	1990	602
3256	3	1990	17
3256	3	2022	22.2885245901639
3257	1	2022	276
3257	1	1990	229
3257	3	1990	12
3257	3	2022	9.82786885245904
3258	1	2022	127
3258	1	1990	105
3258	3	1990	0
3258	3	2022	1.91194968553459
3259	1	2022	5649
3259	1	1990	4724
3259	3	1990	74
3259	3	2022	182.123326247454
3260	1	2022	459
3260	1	1990	598
3260	3	1990	8
3260	3	2022	31
3261	1	2022	219
3261	1	1990	165
3261	3	1990	10
3261	3	2022	9
3262	1	2022	1331
3262	1	1990	1204
3262	3	1990	41
3262	3	2022	89.7612852447569
3263	1	2022	263
3263	1	1990	186
3263	3	1990	9
3263	3	2022	12.5694444444444
3264	1	2022	317
3264	1	1990	282
3264	3	1990	1
3264	3	2022	20
3265	1	2022	55
3265	1	1990	77
3265	3	1990	1
3265	3	2022	3.72549019607843
3266	1	2022	3595
3266	1	1990	3529
3266	3	1990	85
3266	3	2022	148.711789307883
3267	1	2022	2118
3267	1	1990	1482
3267	3	1990	50
3267	3	2022	81.8409680968094
3268	1	2022	140
3268	1	1990	124
3268	3	1990	4
3268	3	2022	7.63416477702192
3269	1	2022	186
3269	1	1990	151
3269	3	1990	16
3269	3	2022	5.04159616048698
3270	1	2022	490
3270	1	1990	369
3270	3	1990	11
3270	3	2022	29.2301365461846
3271	1	2022	75
3271	1	1990	62
3271	3	1990	4
3271	3	2022	4.1017316017316
3272	1	2022	218
3272	1	1990	128
3272	3	1990	1
3272	3	2022	6.77108433734941
3273	1	2022	262
3273	1	1990	201
3273	3	1990	10
3273	3	2022	7.6953242835596
3274	1	2022	540
3274	1	1990	574
3274	3	1990	13
3274	3	2022	30.096463022508
3275	1	2022	302
3275	1	1990	141
3275	3	1990	10
3275	3	2022	5.08547008547011
3276	1	2022	473
3276	1	1990	453
3276	3	1990	14
3276	3	2022	17.8610038610039
3277	1	2022	1315
3277	1	1990	1105
3277	3	1990	120
3277	3	2022	44.8144438791999
3278	1	2022	1054
3278	1	1990	670
3278	3	1990	25
3278	3	2022	38.809867178711
3279	1	2022	225
3279	1	1990	238
3279	3	1990	1
3279	3	2022	21.3273846153846
3280	1	2022	887
3280	1	1990	763
3280	3	1990	18
3280	3	2022	17.258883248731
3281	1	2022	418
3281	1	1990	381
3281	3	1990	9
3281	3	2022	15.1824635695603
3282	1	2022	570
3282	1	1990	440
3282	3	1990	32
3282	3	2022	21.2632098210382
3283	1	2022	605
3283	1	1990	443
3283	3	1990	13
3283	3	2022	24.3757142857143
3284	1	2022	7615
3284	1	1990	5399
3284	3	1990	200
3284	3	2022	336
3285	1	2022	325
3285	1	1990	267
3285	3	1990	9
3285	3	2022	4
3286	1	2022	85
3286	1	1990	99
3286	3	1990	3
3286	3	2022	5.0943396226415
3287	1	2022	751
3287	1	1990	588
3287	3	1990	16
3287	3	2022	42.2424242424245
3288	1	2022	18074
3288	1	1990	11578
3288	3	1990	264
3288	3	2022	668.224226757481
3289	1	2022	389
3289	1	1990	374
3289	3	1990	6
3289	3	2022	12
3290	1	2022	276
3290	1	1990	248
3290	3	1990	2
3290	3	2022	9.0703125
3291	1	2022	131
3291	1	1990	127
3291	3	1990	3
3291	3	2022	3.07142857142856
3292	1	2022	56
3292	1	1990	76
3292	3	1990	2
3292	3	2022	3
3293	1	2022	100
3293	1	1990	95
3293	3	1990	7
3293	3	2022	1.01923076923077
3294	1	2022	230
3294	1	1990	196
3294	3	1990	3
3294	3	2022	11.1067961165049
3295	1	2022	73
3295	1	1990	92
3295	3	1990	3
3295	3	2022	1.86666666666667
3296	1	2022	271
3296	1	1990	242
3296	3	1990	7
3296	3	2022	1.17777777777778
3297	1	2022	5134
3297	1	1990	2311
3297	3	1990	21
3297	3	2022	91.6164109770253
3298	1	2022	1008
3298	1	1990	792
3298	3	1990	21
3298	3	2022	19.8752298965632
3299	1	2022	540
3299	1	1990	527
3299	3	1990	11
3299	3	2022	22
3300	1	2022	150
3300	1	1990	146
3300	3	1990	3
3300	3	2022	6.27450980392158
3301	1	2022	892
3301	1	1990	751
3301	3	1990	5
3301	3	2022	41.9487045865606
3302	1	2022	366
3302	1	1990	240
3302	3	1990	4
3302	3	2022	6.65543898550965
3303	1	2022	671
3303	1	1990	674
3303	3	1990	30
3303	3	2022	23.651471272903
3304	1	2022	248
3304	1	1990	240
3304	3	1990	14
3304	3	2022	21.6040339569381
3305	1	2022	533
3305	1	1990	330
3305	3	1990	4
3305	3	2022	17.2119774069584
3306	1	2022	2204
3306	1	1990	1563
3306	3	1990	43
3306	3	2022	86.138637602968
3307	1	2022	441
3307	1	1990	498
3307	3	1990	24
3307	3	2022	30.3241755041823
3308	1	2022	149
3308	1	1990	144
3308	3	1990	2
3308	3	2022	6.06741573033708
3309	1	2022	1258
3309	1	1990	648
3309	3	1990	9
3309	3	2022	30.6519830407988
3310	1	2022	210
3310	1	1990	179
3310	3	1990	14
3310	3	2022	13.6830799735623
3311	1	2022	7063
3311	1	1990	7538
3311	3	1990	146
3311	3	2022	399.09490195996
3312	1	2022	200
3312	1	1990	221
3312	3	1990	5
3312	3	2022	6
3313	1	2022	428
3313	1	1990	455
3313	3	1990	3
3313	3	2022	15.953091684435
3314	1	2022	138
3314	1	1990	135
3314	3	1990	8
3314	3	2022	1.02368093061902
3315	1	2022	582
3315	1	1990	403
3315	3	1990	25
3315	3	2022	37.8666666666666
3316	1	2022	987
3316	1	1990	852
3316	3	1990	15
3316	3	2022	68
3317	1	2022	594
3317	1	1990	304
3317	3	1990	4
3317	3	2022	7.64857881136951
3318	1	2022	332
3318	1	1990	284
3318	3	1990	11
3318	3	2022	24.5164736855559
3319	1	2022	258
3319	1	1990	212
3319	3	1990	4
3319	3	2022	11.5478260869565
3320	1	2022	170
3320	1	1990	153
3320	3	1990	4
3320	3	2022	8.17021276595741
3321	1	2022	144
3321	1	1990	197
3321	3	1990	11
3321	3	2022	11
3322	1	2022	106
3322	1	1990	82
3322	3	1990	9
3322	3	2022	8
3323	1	2022	145
3323	1	1990	110
3323	3	1990	4
3323	3	2022	2.11111111111111
3324	1	2022	175
3324	1	1990	118
3324	3	1990	5
3324	3	2022	13.0872421695951
3325	1	2022	117
3325	1	1990	127
3325	3	1990	8
3325	3	2022	7.78088578088577
3326	1	2022	175
3326	1	1990	202
3326	3	1990	12
3326	3	2022	12.1111111111111
3327	1	2022	1034
3327	1	1990	864
3327	3	1990	22
3327	3	2022	26.064
3328	1	2022	1134
3328	1	1990	1295
3328	3	1990	41
3328	3	2022	40.8832046332047
3329	1	2022	468
3329	1	1990	510
3329	3	1990	4
3329	3	2022	3.52592592592593
3330	1	2022	155
3330	1	1990	181
3330	3	1990	8
3330	3	2022	7.4027536231884
3331	1	2022	2736
3331	1	1990	1496
3331	3	1990	14
3331	3	2022	45.4385934640759
3332	1	2022	531
3332	1	1990	463
3332	3	1990	12
3332	3	2022	25.8722461571531
3333	1	2022	710
3333	1	1990	724
3333	3	1990	13
3333	3	2022	30.8706607859661
3334	1	2022	199
3334	1	1990	171
3334	3	1990	16
3334	3	2022	6
3335	1	2022	251
3335	1	1990	210
3335	3	1990	8
3335	3	2022	10.1587301587302
3336	1	2022	211
3336	1	1990	194
3336	3	1990	9
3336	3	2022	6.56235827664401
3337	1	2022	479
3337	1	1990	513
3337	3	1990	7
3337	3	2022	2.03388333534064
3338	1	2022	144
3338	1	1990	170
3338	3	1990	6
3338	3	2022	1
3339	1	2022	303
3339	1	1990	241
3339	3	1990	7
3339	3	2022	3.06293706293706
3340	1	2022	287
3340	1	1990	307
3340	3	1990	4
3340	3	2022	11.2765344335131
3341	1	2022	446
3341	1	1990	406
3341	3	1990	7
3341	3	2022	28.5413631212562
3342	1	2022	1035
3342	1	1990	805
3342	3	1990	12
3342	3	2022	39
3343	1	2022	185
3343	1	1990	241
3343	3	1990	18
3343	3	2022	3.78864197530863
3344	1	2022	2123
3344	1	1990	1148
3344	3	1990	30
3344	3	2022	58
3345	1	2022	192
3345	1	1990	160
3345	3	1990	8
3345	3	2022	11
3346	1	2022	185
3346	1	1990	242
3346	3	1990	3
3346	3	2022	9.92156862745098
3347	1	2022	1178
3347	1	1990	1466
3347	3	1990	105
3347	3	2022	155.983521829912
3348	1	2022	248
3348	1	1990	186
3348	3	1990	0
3348	3	2022	8
3349	1	2022	337
3349	1	1990	286
3349	3	1990	16
3349	3	2022	10.2503223511627
3350	1	2022	114
3350	1	1990	116
3350	3	1990	2
3350	3	2022	1.03508771929825
3351	1	2022	1737
3351	1	1990	1503
3351	3	1990	42
3351	3	2022	87
3352	1	2022	195
3352	1	1990	187
3352	3	1990	10
3352	3	2022	14.3725961538462
3353	1	2022	126
3353	1	1990	117
3353	3	1990	4
3353	3	2022	7.6311475409836
3354	1	2022	184
3354	1	1990	208
3354	3	1990	12
3354	3	2022	5.82371942234011
3355	1	2022	1028
3355	1	1990	1087
3355	3	1990	13
3355	3	2022	29.4824439903847
3356	1	2022	1266
3356	1	1990	446
3356	3	1990	4
3356	3	2022	21.6282559052308
3357	1	2022	232
3357	1	1990	241
3357	3	1990	23
3357	3	2022	19.1444866920152
3358	1	2022	804
3358	1	1990	687
3358	3	1990	64
3358	3	2022	58.18041444105
3359	1	2022	168
3359	1	1990	134
3359	3	1990	8
3359	3	2022	10.1282051282051
3360	1	2022	211
3360	1	1990	182
3360	3	1990	6
3360	3	2022	4.90068806106542
3361	1	2022	9540
3361	1	1990	5793
3361	3	1990	91
3361	3	2022	184.613024599398
3362	1	2022	167
3362	1	1990	198
3362	3	1990	19
3362	3	2022	11.7098214900148
3363	1	2022	152
3363	1	1990	152
3363	3	1990	1
3363	3	2022	11.1410256410256
3364	1	2022	183
3364	1	1990	133
3364	3	1990	5
3364	3	2022	3.35390946502058
3365	1	2022	795
3365	1	1990	865
3365	3	1990	25
3365	3	2022	36.6286571103355
3366	1	2022	85
3366	1	1990	93
3366	3	1990	2
3366	3	2022	1
3367	1	2022	133
3367	1	1990	146
3367	3	1990	7
3367	3	2022	9.08695652173914
3368	1	2022	192
3368	1	1990	237
3368	3	1990	18
3368	3	2022	13.6818181818182
3369	1	2022	706
3369	1	1990	340
3369	3	1990	7
3369	3	2022	17.3354735152488
3370	1	2022	364
3370	1	1990	266
3370	3	1990	6
3370	3	2022	11.2763381730427
3371	1	2022	194
3371	1	1990	195
3371	3	1990	10
3371	3	2022	14
3372	1	2022	208
3372	1	1990	167
3372	3	1990	2
3372	3	2022	4.12858422939071
3373	1	2022	222
3373	1	1990	108
3373	3	1990	5
3373	3	2022	6.44665207784332
3374	1	2022	13708
3374	1	1990	9254
3374	3	1990	156
3374	3	2022	314.291156850467
3375	1	2022	493
3375	1	1990	432
3375	3	1990	11
3375	3	2022	15.3036437246963
3376	1	2022	871
3376	1	1990	521
3376	3	1990	7
3376	3	2022	16.2750014101826
3377	1	2022	141
3377	1	1990	175
3377	3	1990	11
3377	3	2022	6
3378	1	2022	415
3378	1	1990	272
3378	3	1990	16
3378	3	2022	14.4667526247928
3379	1	2022	1073
3379	1	1990	1014
3379	3	1990	34
3379	3	2022	84
3380	1	2022	130
3380	1	1990	127
3380	3	1990	7
3380	3	2022	2.14074214074214
3381	1	2022	136
3381	1	1990	137
3381	3	1990	2
3381	3	2022	7
3382	1	2022	106
3382	1	1990	106
3382	3	1990	2
3382	3	2022	6.97435897435897
3383	1	2022	64
3383	1	1990	65
3383	3	1990	1
3383	3	2022	2.07142857142858
3384	1	2022	265
3384	1	1990	294
3384	3	1990	3
3384	3	2022	15.2769791666667
3385	1	2022	926
3385	1	1990	933
3385	3	1990	32
3385	3	2022	48
3386	1	2022	206
3386	1	1990	214
3386	3	1990	31
3386	3	2022	19
3387	1	2022	184
3387	1	1990	132
3387	3	1990	8
3387	3	2022	4.05194805194804
3388	1	2022	399
3388	1	1990	213
3388	3	1990	13
3388	3	2022	5.98870501707381
3389	1	2022	322
3389	1	1990	376
3389	3	1990	13
3389	3	2022	16.8
3390	1	2022	594
3390	1	1990	476
3390	3	1990	27
3390	3	2022	45.551282051282
3391	1	2022	444
3391	1	1990	407
3391	3	1990	8
3391	3	2022	10
3392	1	2022	112
3392	1	1990	150
3392	3	1990	6
3392	3	2022	7
3393	1	2022	888
3393	1	1990	738
3393	3	1990	21
3393	3	2022	27.5087719298246
3394	1	2022	271
3394	1	1990	230
3394	3	1990	13
3394	3	2022	11.4621848739496
3395	1	2022	238
3395	1	1990	233
3395	3	1990	7
3395	3	2022	16.2397103870788
3396	1	2022	567
3396	1	1990	436
3396	3	1990	10
3396	3	2022	10.9566441441441
3397	1	2022	2975
3397	1	1990	3533
3397	3	1990	130
3397	3	2022	304.139225599238
3398	1	2022	88
3398	1	1990	103
3398	3	1990	3
3398	3	2022	4.15384615384616
3399	1	2022	1831
3399	1	1990	2079
3399	3	1990	13
3399	3	2022	37.1081630646879
3400	1	2022	1188
3400	1	1990	643
3400	3	1990	18
3400	3	2022	28
3401	1	2022	278
3401	1	1990	283
3401	3	1990	9
3401	3	2022	16.8752584780811
3402	1	2022	948
3402	1	1990	709
3402	3	1990	11
3402	3	2022	34.8729186808462
3403	1	2022	849
3403	1	1990	720
3403	3	1990	35
3403	3	2022	28.4125008939426
3404	1	2022	207
3404	1	1990	214
3404	3	1990	4
3404	3	2022	6.66707354287459
3405	1	2022	162
3405	1	1990	183
3405	3	1990	19
3405	3	2022	7.7089454408194
3406	1	2022	234
3406	1	1990	210
3406	3	1990	2
3406	3	2022	13.485426254657
3407	1	2022	279
3407	1	1990	258
3407	3	1990	12
3407	3	2022	14.2608695652174
3408	1	2022	328
3408	1	1990	358
3408	3	1990	2
3408	3	2022	10.1142857142858
3409	1	2022	140
3409	1	1990	122
3409	3	1990	5
3409	3	2022	3
3410	1	2022	281
3410	1	1990	183
3410	3	1990	3
3410	3	2022	8
3411	1	2022	1254
3411	1	1990	921
3411	3	1990	20
3411	3	2022	66.9166666666664
3412	1	2022	612
3412	1	1990	374
3412	3	1990	3
3412	3	2022	18.6021057132169
3413	1	2022	110
3413	1	1990	98
3413	3	1990	2
3413	3	2022	8
3414	1	2022	372
3414	1	1990	289
3414	3	1990	5
3414	3	2022	12.2962962962963
3415	1	2022	154
3415	1	1990	177
3415	3	1990	13
3415	3	2022	9.24180817986131
3416	1	2022	289
3416	1	1990	357
3416	3	1990	10
3416	3	2022	20
3417	1	2022	85
3417	1	1990	107
3417	3	1990	0
3417	3	2022	9.06249999999998
3418	1	2022	4436
3418	1	1990	4032
3418	3	1990	99
3418	3	2022	179.253386338296
3419	1	2022	81
3419	1	1990	94
3419	3	1990	6
3419	3	2022	2.42857142857143
3420	1	2022	134
3420	1	1990	106
3420	3	1990	5
3420	3	2022	8
3421	1	2022	1136
3421	1	1990	818
3421	3	1990	22
3421	3	2022	42.3951508314622
3422	1	2022	117
3422	1	1990	108
3422	3	1990	3
3422	3	2022	7
3423	1	2022	416
3423	1	1990	509
3423	3	1990	16
3423	3	2022	18.2780753968254
3424	1	2022	2420
3424	1	1990	1437
3424	3	1990	12
3424	3	2022	54.8488455200256
3425	1	2022	1121
3425	1	1990	986
3425	3	1990	29
3425	3	2022	44
3426	1	2022	81
3426	1	1990	82
3426	3	1990	4
3426	3	2022	4
3427	1	2022	189
3427	1	1990	186
3427	3	1990	11
3427	3	2022	10.2951388888889
3428	1	2022	314
3428	1	1990	379
3428	3	1990	10
3428	3	2022	20.0888038465313
3429	1	2022	4367
3429	1	1990	3094
3429	3	1990	52
3429	3	2022	120
3430	1	2022	613
3430	1	1990	389
3430	3	1990	16
3430	3	2022	17.3153504198453
3431	1	2022	5353
3431	1	1990	3021
3431	3	1990	57
3431	3	2022	79.2237800644189
3432	1	2022	69
3432	1	1990	46
3432	3	1990	1
3432	3	2022	3.7741935483871
3433	1	2022	818
3433	1	1990	698
3433	3	1990	20
3433	3	2022	21.5890113378091
3434	1	2022	5744
3434	1	1990	7460
3434	3	1990	473
3434	3	2022	525.951323078854
3435	1	2022	225
3435	1	1990	285
3435	3	1990	5
3435	3	2022	10.2607109227872
3436	1	2022	84
3436	1	1990	115
3436	3	1990	11
3436	3	2022	12
3437	1	2022	756
3437	1	1990	527
3437	3	1990	4
3437	3	2022	19.5070278257665
3438	1	2022	122
3438	1	1990	117
3438	3	1990	4
3438	3	2022	3
3439	1	2022	1547
3439	1	1990	1123
3439	3	1990	23
3439	3	2022	49.5558750930902
3440	1	2022	1046
3440	1	1990	1036
3440	3	1990	81
3440	3	2022	117.502654849247
3441	1	2022	3203
3441	1	1990	3294
3441	3	1990	97
3441	3	2022	236
3442	1	2022	125
3442	1	1990	160
3442	3	1990	6
3442	3	2022	6.52173913043478
3443	1	2022	1591
3443	1	1990	672
3443	3	1990	10
3443	3	2022	32.3949193702384
3444	1	2022	242
3444	1	1990	220
3444	3	1990	0
3444	3	2022	11.3055555555556
3445	1	2022	1274
3445	1	1990	1085
3445	3	1990	30
3445	3	2022	58.425383392442
3446	1	2022	10658
3446	1	1990	11067
3446	3	1990	552
3446	3	2022	750.526298627917
3447	1	2022	187
3447	1	1990	180
3447	3	1990	21
3447	3	2022	13.8738738738739
3448	1	2022	552
3448	1	1990	555
3448	3	1990	24
3448	3	2022	32.4733701534789
3449	1	2022	517
3449	1	1990	500
3449	3	1990	20
3449	3	2022	30.5748393021121
3450	1	2022	266
3450	1	1990	178
3450	3	1990	10
3450	3	2022	16.9641419566232
3451	1	2022	148
3451	1	1990	154
3451	3	1990	7
3451	3	2022	5.05555555555555
3452	1	2022	142
3452	1	1990	150
3452	3	1990	5
3452	3	2022	2.02564102564102
3453	1	2022	103
3453	1	1990	89
3453	3	1990	3
3453	3	2022	9
3454	1	2022	10836
3454	1	1990	10159
3454	3	1990	187
3454	3	2022	585.539083252898
3455	1	2022	548
3455	1	1990	434
3455	3	1990	16
3455	3	2022	10.2678571428571
3456	1	2022	89
3456	1	1990	100
3456	3	1990	6
3456	3	2022	12.32
3457	1	2022	332
3457	1	1990	307
3457	3	1990	23
3457	3	2022	18.4169884169884
3458	1	2022	52
3458	1	1990	48
3458	3	1990	2
3458	3	2022	3.21428571428573
3459	1	2022	228
3459	1	1990	266
3459	3	1990	9
3459	3	2022	15.2557251908397
3460	1	2022	876
3460	1	1990	692
3460	3	1990	31
3460	3	2022	29
3461	1	2022	224
3461	1	1990	219
3461	3	1990	5
3461	3	2022	7
3462	1	2022	552
3462	1	1990	309
3462	3	1990	11
3462	3	2022	19.8629528158295
3463	1	2022	1667
3463	1	1990	937
3463	3	1990	9
3463	3	2022	28.9149280034281
3464	1	2022	378
3464	1	1990	376
3464	3	1990	13
3464	3	2022	16.9242960237725
3465	1	2022	251
3465	1	1990	267
3465	3	1990	6
3465	3	2022	13.8305555555555
3466	1	2022	321
3466	1	1990	219
3466	3	1990	8
3466	3	2022	3
3467	1	2022	920
3467	1	1990	1029
3467	3	1990	17
3467	3	2022	32.0940489836354
3468	1	2022	447
3468	1	1990	365
3468	3	1990	11
3468	3	2022	16.2022716774499
3469	1	2022	78620
3469	1	1990	82157
3469	3	1990	3509
3469	3	2022	7857.97340278018
3470	1	2022	146
3470	1	1990	124
3470	3	1990	1
3470	3	2022	6.84961884961884
3471	1	2022	139
3471	1	1990	117
3471	3	1990	4
3471	3	2022	8
3472	1	2022	1860
3472	1	1990	1310
3472	3	1990	4
3472	3	2022	37.227545292982
3473	1	2022	165
3473	1	1990	172
3473	3	1990	2
3473	3	2022	9.21176470588229
3474	1	2022	297
3474	1	1990	176
3474	3	1990	2
3474	3	2022	9.08852459016396
3475	1	2022	98
3475	1	1990	81
3475	3	1990	5
3475	3	2022	7.15555555555554
3476	1	2022	258
3476	1	1990	227
3476	3	1990	10
3476	3	2022	6.14556097560974
3477	1	2022	2916
3477	1	1990	2683
3477	3	1990	78
3477	3	2022	104.110711718188
3478	1	2022	176
3478	1	1990	131
3478	3	1990	3
3478	3	2022	7.55555555555556
3479	1	2022	162
3479	1	1990	177
3479	3	1990	13
3479	3	2022	16.8955752212389
3480	1	2022	50
3480	1	1990	38
3480	3	1990	1
3480	3	2022	2.05797101449276
3481	1	2022	184
3481	1	1990	204
3481	3	1990	3
3481	3	2022	13
3482	1	2022	295
3482	1	1990	243
3482	3	1990	10
3482	3	2022	9.82839044054131
3483	1	2022	179
3483	1	1990	161
3483	3	1990	10
3483	3	2022	5.22222222222222
3484	1	2022	405
3484	1	1990	320
3484	3	1990	11
3484	3	2022	14.2198952879581
3485	1	2022	1089
3485	1	1990	1007
3485	3	1990	57
3485	3	2022	64
3486	1	2022	484
3486	1	1990	387
3486	3	1990	15
3486	3	2022	11.1420431420431
3487	1	2022	643
3487	1	1990	672
3487	3	1990	23
3487	3	2022	25.7796610169492
3488	1	2022	81
3488	1	1990	78
3488	3	1990	3
3488	3	2022	0
3489	1	2022	238
3489	1	1990	180
3489	3	1990	1
3489	3	2022	4
3490	1	2022	271
3490	1	1990	230
3490	3	1990	12
3490	3	2022	8.86639233574701
3491	1	2022	868
3491	1	1990	627
3491	3	1990	8
3491	3	2022	19.0911881607883
3492	1	2022	121
3492	1	1990	130
3492	3	1990	0
3492	3	2022	6.35380747126437
3493	1	2022	300
3493	1	1990	195
3493	3	1990	6
3493	3	2022	5.42857142857143
3494	1	2022	614
3494	1	1990	502
3494	3	1990	13
3494	3	2022	15
3495	1	2022	370
3495	1	1990	343
3495	3	1990	7
3495	3	2022	12.2105263157895
3496	1	2022	857
3496	1	1990	736
3496	3	1990	7
3496	3	2022	16.2742857142858
3497	1	2022	356
3497	1	1990	283
3497	3	1990	9
3497	3	2022	19.1025142520053
3498	1	2022	159
3498	1	1990	141
3498	3	1990	9
3498	3	2022	11.0421455938697
3499	1	2022	172
3499	1	1990	319
3499	3	1990	14
3499	3	2022	6
3500	1	2022	443
3500	1	1990	391
3500	3	1990	3
3500	3	2022	19
3501	1	2022	1540
3501	1	1990	1565
3501	3	1990	137
3501	3	2022	103
3502	1	2022	740
3502	1	1990	658
3502	3	1990	17
3502	3	2022	20.925856464116
3503	1	2022	179
3503	1	1990	151
3503	3	1990	3
3503	3	2022	12.0857142857143
3504	1	2022	198
3504	1	1990	209
3504	3	1990	5
3504	3	2022	14
3505	1	2022	224
3505	1	1990	182
3505	3	1990	8
3505	3	2022	8.6
3506	1	2022	634
3506	1	1990	522
3506	3	1990	8
3506	3	2022	11.2021857923497
3507	1	2022	14690
3507	1	1990	13031
3507	3	1990	367
3507	3	2022	460.215789606535
3508	1	2022	878
3508	1	1990	910
3508	3	1990	35
3508	3	2022	34.0750011281157
3509	1	2022	1487
3509	1	1990	1432
3509	3	1990	120
3509	3	2022	43.1859220260109
3510	1	2022	74
3510	1	1990	67
3510	3	1990	1
3510	3	2022	2.875
3511	1	2022	195
3511	1	1990	292
3511	3	1990	6
3511	3	2022	15.2189781021897
3512	1	2022	444
3512	1	1990	349
3512	3	1990	9
3512	3	2022	28
3513	1	2022	348
3513	1	1990	303
3513	3	1990	10
3513	3	2022	11.1189189189189
3514	1	2022	544
3514	1	1990	415
3514	3	1990	42
3514	3	2022	25.4290714807452
3515	1	2022	198
3515	1	1990	196
3515	3	1990	17
3515	3	2022	17.3008849557523
3516	1	2022	288
3516	1	1990	276
3516	3	1990	7
3516	3	2022	2
3517	1	2022	2155
3517	1	1990	1773
3517	3	1990	101
3517	3	2022	125
3518	1	2022	268
3518	1	1990	207
3518	3	1990	9
3518	3	2022	14.8858440031639
3519	1	2022	7238
3519	1	1990	3463
3519	3	1990	56
3519	3	2022	260
3520	1	2022	5779
3520	1	1990	3676
3520	3	1990	48
3520	3	2022	91.8264677262407
3521	1	2022	395
3521	1	1990	353
3521	3	1990	11
3521	3	2022	15.3333333333333
3522	1	2022	4642
3522	1	1990	4974
3522	3	1990	233
3522	3	2022	418.232290962421
3523	1	2022	312
3523	1	1990	262
3523	3	1990	7
3523	3	2022	14.8651791751182
3524	1	2022	585
3524	1	1990	573
3524	3	1990	17
3524	3	2022	22.400410798122
3525	1	2022	703
3525	1	1990	378
3525	3	1990	10
3525	3	2022	68
3526	1	2022	95
3526	1	1990	64
3526	3	1990	1
3526	3	2022	0
3527	1	2022	2736
3527	1	1990	2054
3527	3	1990	61
3527	3	2022	97.2419597169884
3528	1	2022	290
3528	1	1990	220
3528	3	1990	10
3528	3	2022	8.12030075187968
3529	1	2022	155
3529	1	1990	228
3529	3	1990	5
3529	3	2022	7.04117647058826
3530	1	2022	150
3530	1	1990	91
3530	3	1990	1
3530	3	2022	9.11864406779661
3531	1	2022	126
3531	1	1990	130
3531	3	1990	8
3531	3	2022	4
3532	1	2022	169
3532	1	1990	200
3532	3	1990	5
3532	3	2022	14.1296296296296
3533	1	2022	944
3533	1	1990	799
3533	3	1990	27
3533	3	2022	34.6245583236437
3534	1	2022	3542
3534	1	1990	1970
3534	3	1990	12
3534	3	2022	72.470152843287
3535	1	2022	276
3535	1	1990	213
3535	3	1990	13
3535	3	2022	13.6519120324976
3536	1	2022	1361
3536	1	1990	1366
3536	3	1990	49
3536	3	2022	97.8505706443282
3537	1	2022	210
3537	1	1990	167
3537	3	1990	9
3537	3	2022	4
3538	1	2022	228
3538	1	1990	199
3538	3	1990	6
3538	3	2022	3.02702702702703
3539	1	2022	391
3539	1	1990	359
3539	3	1990	4
3539	3	2022	9.58483033932134
3540	1	2022	156
3540	1	1990	190
3540	3	1990	13
3540	3	2022	9.89795918367347
3541	1	2022	1156
3541	1	1990	640
3541	3	1990	6
3541	3	2022	31.7242991005356
3542	1	2022	4411
3542	1	1990	2430
3542	3	1990	35
3542	3	2022	98.7001343647852
3543	1	2022	856
3543	1	1990	554
3543	3	1990	12
3543	3	2022	28.4921507064364
3544	1	2022	601
3544	1	1990	456
3544	3	1990	7
3544	3	2022	23.5518372703413
3545	1	2022	573
3545	1	1990	437
3545	3	1990	20
3545	3	2022	32
3546	1	2022	796
3546	1	1990	532
3546	3	1990	9
3546	3	2022	46.627365034718
3547	1	2022	422
3547	1	1990	303
3547	3	1990	13
3547	3	2022	18.4736842105263
3548	1	2022	840
3548	1	1990	462
3548	3	1990	10
3548	3	2022	17
3549	1	2022	1587
3549	1	1990	1022
3549	3	1990	17
3549	3	2022	44.6535758278387
3550	1	2022	1489
3550	1	1990	937
3550	3	1990	7
3550	3	2022	69.1415717905522
3551	1	2022	165
3551	1	1990	198
3551	3	1990	4
3551	3	2022	6.64985994397759
3552	1	2022	383
3552	1	1990	312
3552	3	1990	17
3552	3	2022	19.5757575757576
3553	1	2022	351
3553	1	1990	250
3553	3	1990	7
3553	3	2022	8.49999999999998
3554	1	2022	47
3554	1	1990	62
3554	3	1990	3
3554	3	2022	3
3555	1	2022	73
3555	1	1990	75
3555	3	1990	3
3555	3	2022	1
3556	1	2022	579
3556	1	1990	704
3556	3	1990	44
3556	3	2022	58
3557	1	2022	171
3557	1	1990	197
3557	3	1990	6
3557	3	2022	7
3558	1	2022	543
3558	1	1990	344
3558	3	1990	3
3558	3	2022	12.7339743589743
3559	1	2022	890
3559	1	1990	568
3559	3	1990	17
3559	3	2022	28.9060913705583
3560	1	2022	141
3560	1	1990	151
3560	3	1990	7
3560	3	2022	8.14586255259466
3561	1	2022	795
3561	1	1990	658
3561	3	1990	41
3561	3	2022	31.2194999549311
3562	1	2022	217
3562	1	1990	202
3562	3	1990	11
3562	3	2022	10
3563	1	2022	3006
3563	1	1990	1688
3563	3	1990	20
3563	3	2022	72.1697714263959
3564	1	2022	70
3564	1	1990	162
3564	3	1990	12
3564	3	2022	25
3565	1	2022	274
3565	1	1990	400
3565	3	1990	36
3565	3	2022	32.136212763075
3566	1	2022	77
3566	1	1990	61
3566	3	1990	2
3566	3	2022	2.33333333333333
3567	1	2022	10594
3567	1	1990	6098
3567	3	1990	79
3567	3	2022	420.068930110475
3568	1	2022	2342
3568	1	1990	1583
3568	3	1990	48
3568	3	2022	54.5580267921657
3569	1	2022	7684
3569	1	1990	4263
3569	3	1990	37
3569	3	2022	246.923437457635
3570	1	2022	164
3570	1	1990	156
3570	3	1990	5
3570	3	2022	9
3571	1	2022	1320
3571	1	1990	739
3571	3	1990	9
3571	3	2022	27
3572	1	2022	851
3572	1	1990	664
3572	3	1990	12
3572	3	2022	24.1567108753316
3573	1	2022	304
3573	1	1990	243
3573	3	1990	10
3573	3	2022	11.6581095596132
3574	1	2022	146
3574	1	1990	149
3574	3	1990	3
3574	3	2022	10
3575	1	2022	227
3575	1	1990	157
3575	3	1990	5
3575	3	2022	6.8989898989899
3576	1	2022	162
3576	1	1990	167
3576	3	1990	8
3576	3	2022	1
3577	1	2022	381
3577	1	1990	352
3577	3	1990	10
3577	3	2022	24.528864265928
3578	1	2022	456
3578	1	1990	361
3578	3	1990	10
3578	3	2022	12.3119650099095
3579	1	2022	2957
3579	1	1990	1570
3579	3	1990	8
3579	3	2022	74.198196465057
3580	1	2022	748
3580	1	1990	831
3580	3	1990	15
3580	3	2022	54.9064748201441
3581	1	2022	175
3581	1	1990	166
3581	3	1990	2
3581	3	2022	6
3582	1	2022	1078
3582	1	1990	1255
3582	3	1990	25
3582	3	2022	106.666174523729
3583	1	2022	312
3583	1	1990	296
3583	3	1990	7
3583	3	2022	7
3584	1	2022	5423
3584	1	1990	4119
3584	3	1990	35
3584	3	2022	188.529921618205
3585	1	2022	3295
3585	1	1990	3573
3585	3	1990	160
3585	3	2022	187
3586	1	2022	616
3586	1	1990	631
3586	3	1990	31
3586	3	2022	33
3587	1	2022	824
3587	1	1990	753
3587	3	1990	25
3587	3	2022	62
3588	1	2022	429
3588	1	1990	327
3588	3	1990	13
3588	3	2022	23.2233009708738
3589	1	2022	604
3589	1	1990	560
3589	3	1990	19
3589	3	2022	58.1213389121339
3590	1	2022	1249
3590	1	1990	1048
3590	3	1990	69
3590	3	2022	47.8543821615788
3591	1	2022	3229
3591	1	1990	3411
3591	3	1990	109
3591	3	2022	218
3592	1	2022	2590
3592	1	1990	2621
3592	3	1990	95
3592	3	2022	235
3593	1	2022	191
3593	1	1990	199
3593	3	1990	8
3593	3	2022	7.21538461538461
3594	1	2022	766
3594	1	1990	808
3594	3	1990	45
3594	3	2022	45.3337287224876
3595	1	2022	165
3595	1	1990	248
3595	3	1990	19
3595	3	2022	7.00000000000002
3596	1	2022	169
3596	1	1990	162
3596	3	1990	9
3596	3	2022	11.4241071428571
3597	1	2022	887
3597	1	1990	757
3597	3	1990	20
3597	3	2022	32.6844539455356
3598	1	2022	184
3598	1	1990	241
3598	3	1990	9
3598	3	2022	12.5151515151515
3599	1	2022	63
3599	1	1990	76
3599	3	1990	6
3599	3	2022	5
3600	1	2022	1952
3600	1	1990	1399
3600	3	1990	24
3600	3	2022	30.1707317933588
3601	1	2022	1111
3601	1	1990	1013
3601	3	1990	35
3601	3	2022	46.1582118722379
3602	1	2022	676
3602	1	1990	591
3602	3	1990	23
3602	3	2022	40
3603	1	2022	938
3603	1	1990	839
3603	3	1990	19
3603	3	2022	38.4127582656994
3604	1	2022	1772
3604	1	1990	1242
3604	3	1990	50
3604	3	2022	83.3177831685014
3605	1	2022	760
3605	1	1990	586
3605	3	1990	23
3605	3	2022	26.8789966555184
3606	1	2022	1882
3606	1	1990	1131
3606	3	1990	31
3606	3	2022	45
3607	1	2022	1175
3607	1	1990	1079
3607	3	1990	28
3607	3	2022	79
3608	1	2022	226
3608	1	1990	277
3608	3	1990	8
3608	3	2022	12
3609	1	2022	170
3609	1	1990	209
3609	3	1990	8
3609	3	2022	9
3610	1	2022	570
3610	1	1990	369
3610	3	1990	21
3610	3	2022	29.3295454545455
3611	1	2022	448
3611	1	1990	422
3611	3	1990	9
3611	3	2022	17.4917644930258
3612	1	2022	5681
3612	1	1990	4467
3612	3	1990	64
3612	3	2022	146
3613	1	2022	19860
3613	1	1990	17827
3613	3	1990	295
3613	3	2022	424.196016828168
3614	1	2022	596
3614	1	1990	523
3614	3	1990	7
3614	3	2022	14
3615	1	2022	99
3615	1	1990	74
3615	3	1990	2
3615	3	2022	2.4
3616	1	2022	753
3616	1	1990	699
3616	3	1990	30
3616	3	2022	38.7684960877074
3617	1	2022	1434
3617	1	1990	1428
3617	3	1990	51
3617	3	2022	116.424908424908
3618	1	2022	748
3618	1	1990	563
3618	3	1990	18
3618	3	2022	18.8585267292823
3619	1	2022	734
3619	1	1990	780
3619	3	1990	65
3619	3	2022	55
3620	1	2022	3834
3620	1	1990	3538
3620	3	1990	117
3620	3	2022	142
3621	1	2022	4795
3621	1	1990	4787
3621	3	1990	67
3621	3	2022	122.715415019763
3622	1	2022	2023
3622	1	1990	2001
3622	3	1990	74
3622	3	2022	126.449900988205
3623	1	2022	764
3623	1	1990	711
3623	3	1990	28
3623	3	2022	26
3624	1	2022	1791
3624	1	1990	1456
3624	3	1990	62
3624	3	2022	137.208262217242
3625	1	2022	982
3625	1	1990	910
3625	3	1990	19
3625	3	2022	45
3626	1	2022	415
3626	1	1990	365
3626	3	1990	13
3626	3	2022	15
3627	1	2022	456
3627	1	1990	404
3627	3	1990	16
3627	3	2022	12.1030042918454
3628	1	2022	171
3628	1	1990	194
3628	3	1990	14
3628	3	2022	19
3629	1	2022	2080
3629	1	1990	1749
3629	3	1990	41
3629	3	2022	73.916897641813
3630	1	2022	736
3630	1	1990	861
3630	3	1990	40
3630	3	2022	75
3631	1	2022	993
3631	1	1990	849
3631	3	1990	34
3631	3	2022	58
3632	1	2022	8585
3632	1	1990	7514
3632	3	1990	121
3632	3	2022	235.239868490938
3633	1	2022	2675
3633	1	1990	2769
3633	3	1990	42
3633	3	2022	64.8950079010905
3634	1	2022	7173
3634	1	1990	4661
3634	3	1990	25
3634	3	2022	182.793411254426
3635	1	2022	2387
3635	1	1990	2739
3635	3	1990	108
3635	3	2022	263.616635247184
3636	1	2022	456
3636	1	1990	548
3636	3	1990	30
3636	3	2022	40.2877697841727
3637	1	2022	133
3637	1	1990	161
3637	3	1990	9
3637	3	2022	6.62786596119931
3638	1	2022	1867
3638	1	1990	1179
3638	3	1990	27
3638	3	2022	47
3639	1	2022	547
3639	1	1990	579
3639	3	1990	31
3639	3	2022	39.3633540372672
3640	1	2022	1689
3640	1	1990	1311
3640	3	1990	30
3640	3	2022	82.6949152542376
3641	1	2022	164
3641	1	1990	180
3641	3	1990	5
3641	3	2022	8
3642	1	2022	843
3642	1	1990	878
3642	3	1990	34
3642	3	2022	59.5221238938051
3643	1	2022	949
3643	1	1990	873
3643	3	1990	6
3643	3	2022	29.9670139625419
3644	1	2022	352
3644	1	1990	318
3644	3	1990	22
3644	3	2022	16
3645	1	2022	925
3645	1	1990	924
3645	3	1990	28
3645	3	2022	42
3646	1	2022	571
3646	1	1990	664
3646	3	1990	28
3646	3	2022	9.02290076335881
3647	1	2022	1194
3647	1	1990	1079
3647	3	1990	14
3647	3	2022	30.7808599673942
3648	1	2022	2275
3648	1	1990	1870
3648	3	1990	43
3648	3	2022	145.767229321941
3649	1	2022	2341
3649	1	1990	2021
3649	3	1990	59
3649	3	2022	116
3650	1	2022	445
3650	1	1990	419
3650	3	1990	30
3650	3	2022	26
3651	1	2022	2403
3651	1	1990	2558
3651	3	1990	37
3651	3	2022	107.451632788645
3652	1	2022	544
3652	1	1990	405
3652	3	1990	13
3652	3	2022	13.1846476165792
3653	1	2022	452
3653	1	1990	443
3653	3	1990	25
3653	3	2022	40
3654	1	2022	408
3654	1	1990	401
3654	3	1990	23
3654	3	2022	52.8318979883666
3655	1	2022	213
3655	1	1990	236
3655	3	1990	18
3655	3	2022	24.2424242424242
3656	1	2022	3536
3656	1	1990	2744
3656	3	1990	42
3656	3	2022	79.2492519250121
3657	1	2022	288
3657	1	1990	282
3657	3	1990	25
3657	3	2022	22.324593067644
3658	1	2022	851
3658	1	1990	538
3658	3	1990	14
3658	3	2022	24.3512195121951
3659	1	2022	1562
3659	1	1990	956
3659	3	1990	23
3659	3	2022	64.2461538461539
3660	1	2022	540
3660	1	1990	664
3660	3	1990	21
3660	3	2022	51.7654613396697
3661	1	2022	1126
3661	1	1990	998
3661	3	1990	28
3661	3	2022	54.8538547904194
3662	1	2022	658
3662	1	1990	399
3662	3	1990	7
3662	3	2022	14.3708995744619
3663	1	2022	291
3663	1	1990	353
3663	3	1990	15
3663	3	2022	26.3291139240506
3664	1	2022	643
3664	1	1990	776
3664	3	1990	45
3664	3	2022	51
3665	1	2022	762
3665	1	1990	673
3665	3	1990	42
3665	3	2022	39.2527859791691
3666	1	2022	388
3666	1	1990	354
3666	3	1990	23
3666	3	2022	19
3667	1	2022	534
3667	1	1990	588
3667	3	1990	13
3667	3	2022	26
3668	1	2022	2261
3668	1	1990	2395
3668	3	1990	76
3668	3	2022	104.175897096486
3669	1	2022	103
3669	1	1990	141
3669	3	1990	5
3669	3	2022	10.0862068965517
3670	1	2022	1812
3670	1	1990	1406
3670	3	1990	23
3670	3	2022	40.1857231113752
3671	1	2022	426
3671	1	1990	314
3671	3	1990	7
3671	3	2022	13
3672	1	2022	839
3672	1	1990	716
3672	3	1990	21
3672	3	2022	25
3673	1	2022	976
3673	1	1990	648
3673	3	1990	10
3673	3	2022	16.2003249399929
3674	1	2022	1769
3674	1	1990	993
3674	3	1990	5
3674	3	2022	29.1886577156965
3675	1	2022	2968
3675	1	1990	2571
3675	3	1990	68
3675	3	2022	93
3676	1	2022	337
3676	1	1990	364
3676	3	1990	13
3676	3	2022	22
3677	1	2022	306
3677	1	1990	359
3677	3	1990	4
3677	3	2022	24.0854832104832
3678	1	2022	1180
3678	1	1990	918
3678	3	1990	14
3678	3	2022	37.1203443545717
3679	1	2022	539
3679	1	1990	526
3679	3	1990	22
3679	3	2022	27.031690140845
3680	1	2022	892
3680	1	1990	915
3680	3	1990	37
3680	3	2022	43
3681	1	2022	905
3681	1	1990	928
3681	3	1990	52
3681	3	2022	61.0003842156646
3682	1	2022	912
3682	1	1990	825
3682	3	1990	14
3682	3	2022	32.8951048951047
3683	1	2022	54
3683	1	1990	78
3683	3	1990	5
3683	3	2022	1.81862745098039
3684	1	2022	814
3684	1	1990	828
3684	3	1990	58
3684	3	2022	65.4416006174488
3685	1	2022	209
3685	1	1990	235
3685	3	1990	17
3685	3	2022	16.8712121212121
3686	1	2022	99
3686	1	1990	95
3686	3	1990	5
3686	3	2022	5.99999999999999
3687	1	2022	380
3687	1	1990	249
3687	3	1990	12
3687	3	2022	10
3688	1	2022	372
3688	1	1990	340
3688	3	1990	22
3688	3	2022	19.0757575757576
3689	1	2022	750
3689	1	1990	827
3689	3	1990	37
3689	3	2022	43.0587367940536
3690	1	2022	2013
3690	1	1990	2295
3690	3	1990	71
3690	3	2022	128.325823993231
3691	1	2022	147
3691	1	1990	148
3691	3	1990	10
3691	3	2022	6.94708994708994
3692	1	2022	845
3692	1	1990	830
3692	3	1990	55
3692	3	2022	57
3693	1	2022	302
3693	1	1990	308
3693	3	1990	32
3693	3	2022	27.2231404958678
3694	1	2022	157
3694	1	1990	174
3694	3	1990	7
3694	3	2022	16.1568627450981
3695	1	2022	359
3695	1	1990	354
3695	3	1990	11
3695	3	2022	32
3696	1	2022	679
3696	1	1990	795
3696	3	1990	29
3696	3	2022	44.1060240963857
3697	1	2022	1292
3697	1	1990	1098
3697	3	1990	29
3697	3	2022	24.0834782608697
3698	1	2022	122
3698	1	1990	143
3698	3	1990	11
3698	3	2022	10
3699	1	2022	533
3699	1	1990	336
3699	3	1990	18
3699	3	2022	12.7733848798164
3700	1	2022	175
3700	1	1990	180
3700	3	1990	2
3700	3	2022	12
3701	1	2022	621
3701	1	1990	503
3701	3	1990	18
3701	3	2022	15
3702	1	2022	2708
3702	1	1990	2717
3702	3	1990	40
3702	3	2022	84.3045428947381
3703	1	2022	562
3703	1	1990	527
3703	3	1990	32
3703	3	2022	21.8519061583578
3704	1	2022	250
3704	1	1990	266
3704	3	1990	8
3704	3	2022	9
3705	1	2022	130
3705	1	1990	194
3705	3	1990	10
3705	3	2022	11
3706	1	2022	901
3706	1	1990	770
3706	3	1990	30
3706	3	2022	22
3707	1	2022	220
3707	1	1990	269
3707	3	1990	27
3707	3	2022	39.4083769633507
3708	1	2022	2917
3708	1	1990	2378
3708	3	1990	68
3708	3	2022	153.834125950663
3709	1	2022	1028
3709	1	1990	874
3709	3	1990	38
3709	3	2022	76.0194425962466
3710	1	2022	5790
3710	1	1990	6518
3710	3	1990	179
3710	3	2022	372
3711	1	2022	479
3711	1	1990	587
3711	3	1990	26
3711	3	2022	45.1318823023718
3712	1	2022	856
3712	1	1990	895
3712	3	1990	33
3712	3	2022	48.8826853010938
3713	1	2022	211
3713	1	1990	216
3713	3	1990	14
3713	3	2022	9.60687022900763
3714	1	2022	5100
3714	1	1990	5096
3714	3	1990	150
3714	3	2022	260.970580930047
3715	1	2022	368
3715	1	1990	251
3715	3	1990	9
3715	3	2022	12.1297297297297
3716	1	2022	1662
3716	1	1990	1857
3716	3	1990	90
3716	3	2022	137.181324647122
3717	1	2022	4685
3717	1	1990	3161
3717	3	1990	69
3717	3	2022	111.021908819884
3718	1	2022	1702
3718	1	1990	1466
3718	3	1990	31
3718	3	2022	54.0109917597874
3719	1	2022	484
3719	1	1990	516
3719	3	1990	19
3719	3	2022	26.1811846689895
3720	1	2022	60074
3720	1	1990	57012
3720	3	1990	1710
3720	3	2022	2800.97067655063
3721	1	2022	5529
3721	1	1990	5080
3721	3	1990	75
3721	3	2022	163.521121802245
3722	1	2022	2334
3722	1	1990	2584
3722	3	1990	123
3722	3	2022	132
3723	1	2022	102
3723	1	1990	106
3723	3	1990	10
3723	3	2022	6
3724	1	2022	255
3724	1	1990	290
3724	3	1990	22
3724	3	2022	28.6556796030479
3725	1	2022	256
3725	1	1990	292
3725	3	1990	13
3725	3	2022	11.0807389162561
3726	1	2022	1685
3726	1	1990	1728
3726	3	1990	43
3726	3	2022	127.086206896551
3727	1	2022	10121
3727	1	1990	10809
3727	3	1990	331
3727	3	2022	535.37804902214
3728	1	2022	343
3728	1	1990	359
3728	3	1990	12
3728	3	2022	48
3729	1	2022	954
3729	1	1990	829
3729	3	1990	22
3729	3	2022	44.4814977032804
3730	1	2022	625
3730	1	1990	652
3730	3	1990	8
3730	3	2022	12.6277372262774
3731	1	2022	1113
3731	1	1990	1076
3731	3	1990	35
3731	3	2022	39.5788497217068
3732	1	2022	323
3732	1	1990	294
3732	3	1990	16
3732	3	2022	31.9758469216989
3733	1	2022	1069
3733	1	1990	1014
3733	3	1990	16
3733	3	2022	31.0373733414201
3734	1	2022	2052
3734	1	1990	1828
3734	3	1990	12
3734	3	2022	25
3735	1	2022	360
3735	1	1990	380
3735	3	1990	25
3735	3	2022	22.8888888888889
3736	1	2022	2249
3736	1	1990	1613
3736	3	1990	19
3736	3	2022	49.5164736074433
3737	1	2022	936
3737	1	1990	879
3737	3	1990	21
3737	3	2022	42.1640625
3738	1	2022	192
3738	1	1990	184
3738	3	1990	13
3738	3	2022	18.2608695652174
3739	1	2022	597
3739	1	1990	436
3739	3	1990	17
3739	3	2022	28
3740	1	2022	63
3740	1	1990	44
3740	3	1990	3
3740	3	2022	3
3741	1	2022	386
3741	1	1990	325
3741	3	1990	17
3741	3	2022	29.0855516233268
3742	1	2022	275
3742	1	1990	310
3742	3	1990	22
3742	3	2022	14.1830698445359
3743	1	2022	526
3743	1	1990	460
3743	3	1990	13
3743	3	2022	30.3896103896102
3744	1	2022	798
3744	1	1990	833
3744	3	1990	41
3744	3	2022	54
3745	1	2022	702
3745	1	1990	464
3745	3	1990	10
3745	3	2022	11.4140660602133
3746	1	2022	1421
3746	1	1990	1265
3746	3	1990	14
3746	3	2022	46.6220339742728
3747	1	2022	637
3747	1	1990	728
3747	3	1990	9
3747	3	2022	24
3748	1	2022	561
3748	1	1990	527
3748	3	1990	9
3748	3	2022	17
3749	1	2022	1662
3749	1	1990	1901
3749	3	1990	67
3749	3	2022	80.6021505376347
3750	1	2022	566
3750	1	1990	472
3750	3	1990	20
3750	3	2022	20.8538359078348
3751	1	2022	1131
3751	1	1990	949
3751	3	1990	19
3751	3	2022	30.6172479206186
3752	1	2022	277
3752	1	1990	260
3752	3	1990	22
3752	3	2022	14.7513614787959
3753	1	2022	373
3753	1	1990	312
3753	3	1990	18
3753	3	2022	17.2799892415277
3754	1	2022	592
3754	1	1990	627
3754	3	1990	8
3754	3	2022	24.1639754510037
3755	1	2022	2217
3755	1	1990	1400
3755	3	1990	14
3755	3	2022	48.744353386048
3756	1	2022	407
3756	1	1990	317
3756	3	1990	11
3756	3	2022	12.4986891653559
3757	1	2022	726
3757	1	1990	712
3757	3	1990	16
3757	3	2022	24.1577024558555
3758	1	2022	339
3758	1	1990	351
3758	3	1990	10
3758	3	2022	19.4846938775511
3759	1	2022	685
3759	1	1990	696
3759	3	1990	17
3759	3	2022	44.6431442496684
3760	1	2022	433
3760	1	1990	391
3760	3	1990	11
3760	3	2022	25
3761	1	2022	387
3761	1	1990	368
3761	3	1990	13
3761	3	2022	20.2906829144453
3762	1	2022	259
3762	1	1990	206
3762	3	1990	10
3762	3	2022	8
3763	1	2022	1510
3763	1	1990	1387
3763	3	1990	72
3763	3	2022	124.631831601996
3764	1	2022	423
3764	1	1990	426
3764	3	1990	15
3764	3	2022	21.4035087719298
3765	1	2022	1322
3765	1	1990	1368
3765	3	1990	36
3765	3	2022	49
3766	1	2022	614
3766	1	1990	452
3766	3	1990	27
3766	3	2022	27
3767	1	2022	1257
3767	1	1990	1183
3767	3	1990	21
3767	3	2022	25.2283587805325
3768	1	2022	305
3768	1	1990	354
3768	3	1990	6
3768	3	2022	17.8105263157895
3769	1	2022	1038
3769	1	1990	1143
3769	3	1990	40
3769	3	2022	82.7726016863306
3770	1	2022	418
3770	1	1990	292
3770	3	1990	12
3770	3	2022	9.0454545454545
3771	1	2022	7433
3771	1	1990	6893
3771	3	1990	244
3771	3	2022	515.841885483414
3772	1	2022	366
3772	1	1990	328
3772	3	1990	5
3772	3	2022	15.3386631134799
3773	1	2022	814
3773	1	1990	676
3773	3	1990	17
3773	3	2022	18.5144368525457
3774	1	2022	320
3774	1	1990	347
3774	3	1990	22
3774	3	2022	26
3775	1	2022	1066
3775	1	1990	780
3775	3	1990	9
3775	3	2022	38.8343313373253
3776	1	2022	1037
3776	1	1990	834
3776	3	1990	64
3776	3	2022	26
3777	1	2022	252
3777	1	1990	244
3777	3	1990	33
3777	3	2022	23
3778	1	2022	888
3778	1	1990	980
3778	3	1990	35
3778	3	2022	51.0212570151585
3779	1	2022	1316
3779	1	1990	1057
3779	3	1990	21
3779	3	2022	28.566780590907
3780	1	2022	1353
3780	1	1990	697
3780	3	1990	19
3780	3	2022	30.9090909090909
3781	1	2022	772
3781	1	1990	523
3781	3	1990	9
3781	3	2022	38.2076502732242
3782	1	2022	1872
3782	1	1990	1370
3782	3	1990	63
3782	3	2022	61.2107623318387
3783	1	2022	496
3783	1	1990	509
3783	3	1990	18
3783	3	2022	27
3784	1	2022	1396
3784	1	1990	1253
3784	3	1990	16
3784	3	2022	24
3785	1	2022	954
3785	1	1990	805
3785	3	1990	25
3785	3	2022	40
3786	1	2022	1090
3786	1	1990	703
3786	3	1990	1
3786	3	2022	27
3787	1	2022	167
3787	1	1990	163
3787	3	1990	6
3787	3	2022	8.87999999999998
3788	1	2022	720
3788	1	1990	620
3788	3	1990	8
3788	3	2022	19.2226214315086
3789	1	2022	345
3789	1	1990	376
3789	3	1990	37
3789	3	2022	24
3790	1	2022	1986
3790	1	1990	1529
3790	3	1990	29
3790	3	2022	44.5660358873047
3791	1	2022	2396
3791	1	1990	2557
3791	3	1990	92
3791	3	2022	139.878357030016
3792	1	2022	1404
3792	1	1990	1202
3792	3	1990	30
3792	3	2022	33
3793	1	2022	599
3793	1	1990	551
3793	3	1990	14
3793	3	2022	25.270305907173
3794	1	2022	1322
3794	1	1990	1162
3794	3	1990	23
3794	3	2022	56.2477876106195
3795	1	2022	323
3795	1	1990	307
3795	3	1990	13
3795	3	2022	19
3796	1	2022	765
3796	1	1990	688
3796	3	1990	25
3796	3	2022	22.3945948669623
3797	1	2022	182
3797	1	1990	167
3797	3	1990	12
3797	3	2022	10.0749063670412
3798	1	2022	2259
3798	1	1990	2565
3798	3	1990	161
3798	3	2022	211.412368692907
3799	1	2022	663
3799	1	1990	449
3799	3	1990	4
3799	3	2022	13.679365079365
3800	1	2022	359
3800	1	1990	373
3800	3	1990	22
3800	3	2022	19.4442767042405
3801	1	2022	487
3801	1	1990	462
3801	3	1990	22
3801	3	2022	30.9893882646692
3802	1	2022	1791
3802	1	1990	1907
3802	3	1990	73
3802	3	2022	135.296937655767
3803	1	2022	112
3803	1	1990	153
3803	3	1990	9
3803	3	2022	16.5333333333333
3804	1	2022	638
3804	1	1990	470
3804	3	1990	22
3804	3	2022	23.3996788581622
3805	1	2022	424
3805	1	1990	306
3805	3	1990	23
3805	3	2022	16.0701754385965
3806	1	2022	858
3806	1	1990	758
3806	3	1990	17
3806	3	2022	38.5266555924696
3807	1	2022	649
3807	1	1990	514
3807	3	1990	7
3807	3	2022	28.2596355730533
3808	1	2022	1972
3808	1	1990	1808
3808	3	1990	10
3808	3	2022	45.2398720682303
3809	1	2022	1398
3809	1	1990	1514
3809	3	1990	93
3809	3	2022	164.838090691691
3810	1	2022	13949
3810	1	1990	15657
3810	3	1990	622
3810	3	2022	918.132071898325
3811	1	2022	126
3811	1	1990	159
3811	3	1990	29
3811	3	2022	21.3925233644861
3812	1	2022	115
3812	1	1990	133
3812	3	1990	12
3812	3	2022	7.68350168350169
3813	1	2022	1087
3813	1	1990	853
3813	3	1990	34
3813	3	2022	32.8790073477256
3814	1	2022	823
3814	1	1990	538
3814	3	1990	17
3814	3	2022	24.9656370270406
3815	1	2022	225
3815	1	1990	282
3815	3	1990	27
3815	3	2022	22
3816	1	2022	861
3816	1	1990	767
3816	3	1990	20
3816	3	2022	55.4978807017544
3817	1	2022	242
3817	1	1990	212
3817	3	1990	10
3817	3	2022	14.9020281555715
3818	1	2022	1666
3818	1	1990	1601
3818	3	1990	82
3818	3	2022	141.399433427762
3819	1	2022	330
3819	1	1990	326
3819	3	1990	17
3819	3	2022	21.2842277086309
3820	1	2022	127
3820	1	1990	151
3820	3	1990	8
3820	3	2022	14
3821	1	2022	583
3821	1	1990	707
3821	3	1990	29
3821	3	2022	50.3408864031519
3822	1	2022	237
3822	1	1990	167
3822	3	1990	6
3822	3	2022	12.5
3823	1	2022	895
3823	1	1990	924
3823	3	1990	25
3823	3	2022	41
3824	1	2022	118
3824	1	1990	148
3824	3	1990	6
3824	3	2022	10
3825	1	2022	1077
3825	1	1990	1063
3825	3	1990	19
3825	3	2022	17.5178231748371
3826	1	2022	203
3826	1	1990	222
3826	3	1990	15
3826	3	2022	18
3827	1	2022	151
3827	1	1990	208
3827	3	1990	31
3827	3	2022	32.64448
3828	1	2022	124
3828	1	1990	135
3828	3	1990	5
3828	3	2022	10.4232804232804
3829	1	2022	1800
3829	1	1990	1153
3829	3	1990	25
3829	3	2022	41.3656765530142
3830	1	2022	156
3830	1	1990	159
3830	3	1990	6
3830	3	2022	9.10588235294115
3831	1	2022	351
3831	1	1990	325
3831	3	1990	16
3831	3	2022	22.111111111111
3832	1	2022	3538
3832	1	1990	2431
3832	3	1990	22
3832	3	2022	80.678655572406
3833	1	2022	238
3833	1	1990	200
3833	3	1990	11
3833	3	2022	10
3834	1	2022	701
3834	1	1990	833
3834	3	1990	80
3834	3	2022	84.9963343108506
3835	1	2022	565
3835	1	1990	370
3835	3	1990	9
3835	3	2022	25
3836	1	2022	329
3836	1	1990	283
3836	3	1990	20
3836	3	2022	20.7317224880383
3837	1	2022	362
3837	1	1990	424
3837	3	1990	30
3837	3	2022	34.5759856017938
3838	1	2022	607
3838	1	1990	619
3838	3	1990	36
3838	3	2022	52.5652173913043
3839	1	2022	543
3839	1	1990	607
3839	3	1990	43
3839	3	2022	74.3486029616965
3840	1	2022	1156
3840	1	1990	978
3840	3	1990	18
3840	3	2022	32.6754748039826
3841	1	2022	342
3841	1	1990	419
3841	3	1990	38
3841	3	2022	48.1604938271606
3842	1	2022	1060
3842	1	1990	992
3842	3	1990	52
3842	3	2022	86.0418320610689
3843	1	2022	1130
3843	1	1990	700
3843	3	1990	45
3843	3	2022	31.1372541931751
3844	1	2022	189
3844	1	1990	225
3844	3	1990	44
3844	3	2022	46.4780570043727
3845	1	2022	132
3845	1	1990	183
3845	3	1990	11
3845	3	2022	13
3846	1	2022	101
3846	1	1990	151
3846	3	1990	9
3846	3	2022	9.14285714285714
3847	1	2022	1738
3847	1	1990	1175
3847	3	1990	27
3847	3	2022	44.9760187428767
3848	1	2022	1287
3848	1	1990	1324
3848	3	1990	100
3848	3	2022	126.021601248408
3849	1	2022	2227
3849	1	1990	1164
3849	3	1990	33
3849	3	2022	23.418838682106
3850	1	2022	1087
3850	1	1990	899
3850	3	1990	47
3850	3	2022	53.3819819819821
3851	1	2022	336
3851	1	1990	364
3851	3	1990	12
3851	3	2022	17.8049445865302
3852	1	2022	2941
3852	1	1990	2295
3852	3	1990	82
3852	3	2022	110.036209534273
3853	1	2022	250
3853	1	1990	222
3853	3	1990	6
3853	3	2022	6.56153578781319
3854	1	2022	253
3854	1	1990	264
3854	3	1990	32
3854	3	2022	24.7999999999999
3855	1	2022	262
3855	1	1990	283
3855	3	1990	29
3855	3	2022	29.1576086956523
3856	1	2022	1538
3856	1	1990	1050
3856	3	1990	25
3856	3	2022	25.1647703660441
3857	1	2022	470
3857	1	1990	541
3857	3	1990	38
3857	3	2022	54.8305623015131
3858	1	2022	558
3858	1	1990	420
3858	3	1990	20
3858	3	2022	28.8421052631578
3859	1	2022	1908
3859	1	1990	1264
3859	3	1990	16
3859	3	2022	38
3860	1	2022	1083
3860	1	1990	800
3860	3	1990	13
3860	3	2022	18
3861	1	2022	804
3861	1	1990	804
3861	3	1990	81
3861	3	2022	72.9623367537313
3862	1	2022	1686
3862	1	1990	1288
3862	3	1990	56
3862	3	2022	74
3863	1	2022	2096
3863	1	1990	1642
3863	3	1990	52
3863	3	2022	75.1859889466166
3864	1	2022	623
3864	1	1990	651
3864	3	1990	49
3864	3	2022	61.3004926108374
3865	1	2022	171
3865	1	1990	201
3865	3	1990	24
3865	3	2022	30
3866	1	2022	929
3866	1	1990	645
3866	3	1990	46
3866	3	2022	53.177062374245
3867	1	2022	460
3867	1	1990	674
3867	3	1990	50
3867	3	2022	41
3868	1	2022	221
3868	1	1990	197
3868	3	1990	9
3868	3	2022	12.9598163030999
3869	1	2022	765
3869	1	1990	693
3869	3	1990	54
3869	3	2022	77.0734735726543
3870	1	2022	301
3870	1	1990	395
3870	3	1990	40
3870	3	2022	23.8297872340426
3871	1	2022	10253
3871	1	1990	6337
3871	3	1990	73
3871	3	2022	246.346477687579
3872	1	2022	901
3872	1	1990	896
3872	3	1990	33
3872	3	2022	48.917335586537
3873	1	2022	555
3873	1	1990	596
3873	3	1990	27
3873	3	2022	22.9622184456394
3874	1	2022	1373
3874	1	1990	1078
3874	3	1990	25
3874	3	2022	36.6472446798625
3875	1	2022	1690
3875	1	1990	1620
3875	3	1990	39
3875	3	2022	27.3325633539999
3876	1	2022	478
3876	1	1990	347
3876	3	1990	15
3876	3	2022	18.6002076588884
3877	1	2022	1258
3877	1	1990	689
3877	3	1990	30
3877	3	2022	23
3878	1	2022	474
3878	1	1990	603
3878	3	1990	8
3878	3	2022	23.04
3879	1	2022	794
3879	1	1990	670
3879	3	1990	32
3879	3	2022	28.5172552527529
3880	1	2022	213
3880	1	1990	208
3880	3	1990	20
3880	3	2022	26
3881	1	2022	994
3881	1	1990	855
3881	3	1990	49
3881	3	2022	69.9651612903226
3882	1	2022	1890
3882	1	1990	1389
3882	3	1990	36
3882	3	2022	50
3883	1	2022	354
3883	1	1990	400
3883	3	1990	22
3883	3	2022	44.1759999999999
3884	1	2022	350
3884	1	1990	487
3884	3	1990	11
3884	3	2022	34
3885	1	2022	730
3885	1	1990	427
3885	3	1990	19
3885	3	2022	21.5861699790781
3886	1	2022	564
3886	1	1990	413
3886	3	1990	23
3886	3	2022	21.9243954254705
3887	1	2022	1046
3887	1	1990	1428
3887	3	1990	123
3887	3	2022	100
3888	1	2022	4776
3888	1	1990	3002
3888	3	1990	64
3888	3	2022	200.353449811686
3889	1	2022	241
3889	1	1990	359
3889	3	1990	24
3889	3	2022	54
3890	1	2022	601
3890	1	1990	660
3890	3	1990	32
3890	3	2022	55.8522427440634
3891	1	2022	1046
3891	1	1990	820
3891	3	1990	19
3891	3	2022	29.5240566767184
3892	1	2022	31105
3892	1	1990	34678
3892	3	1990	1269
3892	3	2022	2353.59465827958
3893	1	2022	1201
3893	1	1990	1174
3893	3	1990	98
3893	3	2022	108.241566654227
3894	1	2022	187
3894	1	1990	193
3894	3	1990	15
3894	3	2022	15
3895	1	2022	7037
3895	1	1990	6658
3895	3	1990	240
3895	3	2022	412.366127535497
3896	1	2022	442
3896	1	1990	393
3896	3	1990	49
3896	3	2022	54.8125772038181
3897	1	2022	516
3897	1	1990	516
3897	3	1990	20
3897	3	2022	46.1411042944787
3898	1	2022	923
3898	1	1990	656
3898	3	1990	17
3898	3	2022	29.2003997357712
3899	1	2022	801
3899	1	1990	740
3899	3	1990	26
3899	3	2022	37
3900	1	2022	2875
3900	1	1990	1858
3900	3	1990	37
3900	3	2022	34.693136420565
3901	1	2022	1205
3901	1	1990	682
3901	3	1990	72
3901	3	2022	133.253280455892
3902	1	2022	2543
3902	1	1990	2814
3902	3	1990	145
3902	3	2022	244.53934222783
3903	1	2022	562
3903	1	1990	557
3903	3	1990	25
3903	3	2022	51.961230492454
3904	1	2022	492
3904	1	1990	396
3904	3	1990	15
3904	3	2022	23.7485728468602
3905	1	2022	1418
3905	1	1990	1286
3905	3	1990	46
3905	3	2022	50.6700697634849
3906	1	2022	4323
3906	1	1990	3742
3906	3	1990	231
3906	3	2022	259
3907	1	2022	1143
3907	1	1990	962
3907	3	1990	17
3907	3	2022	40.0597826086955
3908	1	2022	232
3908	1	1990	313
3908	3	1990	36
3908	3	2022	27
3909	1	2022	260
3909	1	1990	264
3909	3	1990	13
3909	3	2022	19.8550724637681
3910	1	2022	913
3910	1	1990	779
3910	3	1990	52
3910	3	2022	45.3249097472925
3911	1	2022	183
3911	1	1990	213
3911	3	1990	16
3911	3	2022	14.8517995765702
3912	1	2022	937
3912	1	1990	448
3912	3	1990	13
3912	3	2022	22
3913	1	2022	389
3913	1	1990	352
3913	3	1990	22
3913	3	2022	19.1909547738693
3914	1	2022	230
3914	1	1990	257
3914	3	1990	21
3914	3	2022	22.235294117647
3915	1	2022	374
3915	1	1990	460
3915	3	1990	25
3915	3	2022	43.8320610687023
3916	1	2022	2968
3916	1	1990	3150
3916	3	1990	76
3916	3	2022	159.231767614338
3917	1	2022	163
3917	1	1990	188
3917	3	1990	0
3917	3	2022	13
3918	1	2022	583
3918	1	1990	339
3918	3	1990	12
3918	3	2022	14.9879627009605
3919	1	2022	3143
3919	1	1990	2498
3919	3	1990	27
3919	3	2022	68.5004928338167
3920	1	2022	680
3920	1	1990	565
3920	3	1990	28
3920	3	2022	29.504288179245
3921	1	2022	334
3921	1	1990	281
3921	3	1990	22
3921	3	2022	16.0898876404494
3922	1	2022	144
3922	1	1990	129
3922	3	1990	11
3922	3	2022	8
3923	1	2022	1108
3923	1	1990	745
3923	3	1990	16
3923	3	2022	46.6762531606477
3924	1	2022	3971
3924	1	1990	2730
3924	3	1990	23
3924	3	2022	53.2365173837827
3925	1	2022	612
3925	1	1990	327
3925	3	1990	11
3925	3	2022	16.9544449835571
3926	1	2022	1681
3926	1	1990	1580
3926	3	1990	72
3926	3	2022	135.177380010725
3927	1	2022	493
3927	1	1990	537
3927	3	1990	43
3927	3	2022	37.3794871794872
3928	1	2022	364
3928	1	1990	328
3928	3	1990	9
3928	3	2022	10.7322097378277
3929	1	2022	100
3929	1	1990	114
3929	3	1990	7
3929	3	2022	6.70588235294118
3930	1	2022	473
3930	1	1990	513
3930	3	1990	32
3930	3	2022	61.7800511508954
3931	1	2022	396
3931	1	1990	459
3931	3	1990	56
3931	3	2022	53.7079153366773
3932	1	2022	232
3932	1	1990	245
3932	3	1990	7
3932	3	2022	27.266149870801
3933	1	2022	230
3933	1	1990	226
3933	3	1990	39
3933	3	2022	26.0634389468744
3934	1	2022	1704
3934	1	1990	1765
3934	3	1990	25
3934	3	2022	78
3935	1	2022	1146
3935	1	1990	1269
3935	3	1990	64
3935	3	2022	108.170827776801
3936	1	2022	2989
3936	1	1990	2679
3936	3	1990	69
3936	3	2022	44
3937	1	2022	1250
3937	1	1990	831
3937	3	1990	15
3937	3	2022	24
3938	1	2022	7597
3938	1	1990	5954
3938	3	1990	217
3938	3	2022	285.780574699582
3939	1	2022	797
3939	1	1990	694
3939	3	1990	24
3939	3	2022	44
3940	1	2022	510
3940	1	1990	476
3940	3	1990	23
3940	3	2022	22.4063058235084
3941	1	2022	368
3941	1	1990	412
3941	3	1990	22
3941	3	2022	40
3942	1	2022	309
3942	1	1990	407
3942	3	1990	12
3942	3	2022	35.325665546653
3943	1	2022	1214
3943	1	1990	1345
3943	3	1990	137
3943	3	2022	107.219260906909
3944	1	2022	1483
3944	1	1990	1305
3944	3	1990	46
3944	3	2022	74.2923800510082
3945	1	2022	68
3945	1	1990	66
3945	3	1990	7
3945	3	2022	2
3946	1	2022	3041
3946	1	1990	2563
3946	3	1990	79
3946	3	2022	114.303118376855
3947	1	2022	1179
3947	1	1990	881
3947	3	1990	35
3947	3	2022	28
3948	1	2022	565
3948	1	1990	500
3948	3	1990	33
3948	3	2022	40.467580581761
3949	1	2022	644
3949	1	1990	467
3949	3	1990	50
3949	3	2022	33.1843575418994
3950	1	2022	453
3950	1	1990	384
3950	3	1990	8
3950	3	2022	14.6550922463186
3951	1	2022	2490
3951	1	1990	2222
3951	3	1990	83
3951	3	2022	149
3952	1	2022	525
3952	1	1990	516
3952	3	1990	59
3952	3	2022	29.3093333333334
3953	1	2022	370
3953	1	1990	362
3953	3	1990	22
3953	3	2022	34.6456874441661
3954	1	2022	912
3954	1	1990	686
3954	3	1990	30
3954	3	2022	68.9754919288326
3955	1	2022	301
3955	1	1990	359
3955	3	1990	35
3955	3	2022	28.1982775119617
3956	1	2022	3429
3956	1	1990	2771
3956	3	1990	41
3956	3	2022	87.321545658724
3957	1	2022	217
3957	1	1990	192
3957	3	1990	24
3957	3	2022	12
3958	1	2022	586
3958	1	1990	472
3958	3	1990	13
3958	3	2022	15
3959	1	2022	381
3959	1	1990	508
3959	3	1990	32
3959	3	2022	24.6719975882176
3960	1	2022	6791
3960	1	1990	7854
3960	3	1990	306
3960	3	2022	617.624701759614
3961	1	2022	248
3961	1	1990	317
3961	3	1990	51
3961	3	2022	50
3962	1	2022	2556
3962	1	1990	2749
3962	3	1990	109
3962	3	2022	169
3963	1	2022	2261
3963	1	1990	2297
3963	3	1990	100
3963	3	2022	143.201692524682
3964	1	2022	672
3964	1	1990	510
3964	3	1990	21
3964	3	2022	30.1744186046511
3965	1	2022	640
3965	1	1990	404
3965	3	1990	10
3965	3	2022	24.1758241758242
3966	1	2022	174
3966	1	1990	174
3966	3	1990	26
3966	3	2022	21.9999999999999
3967	1	2022	324
3967	1	1990	291
3967	3	1990	28
3967	3	2022	14.3703703703704
3968	1	2022	1119
3968	1	1990	602
3968	3	1990	25
3968	3	2022	10
3969	1	2022	603
3969	1	1990	358
3969	3	1990	19
3969	3	2022	17
3970	1	2022	714
3970	1	1990	501
3970	3	1990	36
3970	3	2022	23.8390469612144
3971	1	2022	360
3971	1	1990	433
3971	3	1990	12
3971	3	2022	32
3972	1	2022	271
3972	1	1990	208
3972	3	1990	15
3972	3	2022	10.1316477768091
3973	1	2022	187
3973	1	1990	212
3973	3	1990	3
3973	3	2022	16.7641325536062
3974	1	2022	590
3974	1	1990	740
3974	3	1990	29
3974	3	2022	40.0615490533562
3975	1	2022	853
3975	1	1990	697
3975	3	1990	59
3975	3	2022	44.925625033576
3976	1	2022	245
3976	1	1990	273
3976	3	1990	17
3976	3	2022	28
3977	1	2022	241
3977	1	1990	205
3977	3	1990	6
3977	3	2022	15
3978	1	2022	5224
3978	1	1990	2357
3978	3	1990	47
3978	3	2022	117.617662594563
3979	1	2022	6276
3979	1	1990	5000
3979	3	1990	79
3979	3	2022	155.364730822958
3980	1	2022	467
3980	1	1990	579
3980	3	1990	32
3980	3	2022	68
3981	1	2022	2144
3981	1	1990	2299
3981	3	1990	125
3981	3	2022	162.550875399115
3982	1	2022	982
3982	1	1990	929
3982	3	1990	60
3982	3	2022	79.2305811031083
3983	1	2022	118
3983	1	1990	132
3983	3	1990	2
3983	3	2022	8.53333333333333
3984	1	2022	3710
3984	1	1990	2164
3984	3	1990	13
3984	3	2022	83
3985	1	2022	672
3985	1	1990	609
3985	3	1990	13
3985	3	2022	33.1875000000001
3986	1	2022	5867
3986	1	1990	6667
3986	3	1990	308
3986	3	2022	703.477271147211
3987	1	2022	917
3987	1	1990	620
3987	3	1990	35
3987	3	2022	49.4544003115263
3988	1	2022	368
3988	1	1990	315
3988	3	1990	11
3988	3	2022	18.3914905945408
3989	1	2022	361
3989	1	1990	434
3989	3	1990	41
3989	3	2022	41.3840074590655
3990	1	2022	433
3990	1	1990	497
3990	3	1990	47
3990	3	2022	48.5825242718449
3991	1	2022	167
3991	1	1990	180
3991	3	1990	29
3991	3	2022	24.1818181818182
3992	1	2022	621
3992	1	1990	710
3992	3	1990	26
3992	3	2022	36.3746543209877
3993	1	2022	5954
3993	1	1990	4718
3993	3	1990	139
3993	3	2022	149.105616263476
3994	1	2022	306
3994	1	1990	359
3994	3	1990	18
3994	3	2022	25.3024193548388
3995	1	2022	117
3995	1	1990	159
3995	3	1990	19
3995	3	2022	20.5343937203058
3996	1	2022	5465
3996	1	1990	3840
3996	3	1990	89
3996	3	2022	217.457367382064
3997	1	2022	2680
3997	1	1990	1554
3997	3	1990	12
3997	3	2022	49.8158154568829
3998	1	2022	2955
3998	1	1990	2142
3998	3	1990	24
3998	3	2022	47.2844705344973
3999	1	2022	218
3999	1	1990	241
3999	3	1990	18
3999	3	2022	19
4000	1	2022	356
4000	1	1990	378
4000	3	1990	13
4000	3	2022	36.878048780488
4001	1	2022	1620
4001	1	1990	1386
4001	3	1990	52
4001	3	2022	87
4002	1	2022	954
4002	1	1990	649
4002	3	1990	27
4002	3	2022	35.470852017937
4003	1	2022	964
4003	1	1990	877
4003	3	1990	26
4003	3	2022	30
4004	1	2022	474
4004	1	1990	367
4004	3	1990	34
4004	3	2022	28.4274809160304
4005	1	2022	463
4005	1	1990	528
4005	3	1990	38
4005	3	2022	56.9992729591837
4006	1	2022	718
4006	1	1990	826
4006	3	1990	49
4006	3	2022	115.808580858086
4007	1	2022	248
4007	1	1990	255
4007	3	1990	36
4007	3	2022	20.2991452991453
4008	1	2022	177
4008	1	1990	183
4008	3	1990	16
4008	3	2022	9.07627118644071
4009	1	2022	1208
4009	1	1990	1154
4009	3	1990	71
4009	3	2022	90.876050347322
4010	1	2022	89472
4010	1	1990	78894
4010	3	1990	2145
4010	3	2022	4785.24157900521
4011	1	2022	548
4011	1	1990	487
4011	3	1990	27
4011	3	2022	28
4012	1	2022	232
4012	1	1990	285
4012	3	1990	7
4012	3	2022	5
4013	1	2022	412
4013	1	1990	510
4013	3	1990	25
4013	3	2022	28.2258064516128
4014	1	2022	731
4014	1	1990	419
4014	3	1990	14
4014	3	2022	16.5483570665103
4015	1	2022	551
4015	1	1990	628
4015	3	1990	46
4015	3	2022	70.3562340966919
4016	1	2022	204
4016	1	1990	218
4016	3	1990	21
4016	3	2022	13.7723577235772
4017	1	2022	604
4017	1	1990	599
4017	3	1990	33
4017	3	2022	45.7205329442565
4018	1	2022	570
4018	1	1990	603
4018	3	1990	80
4018	3	2022	67.0512492379512
4019	1	2022	2113
4019	1	1990	1564
4019	3	1990	21
4019	3	2022	33.5683890577509
4020	1	2022	204
4020	1	1990	195
4020	3	1990	17
4020	3	2022	22.8946280991736
4021	1	2022	135
4021	1	1990	125
4021	3	1990	9
4021	3	2022	10
4022	1	2022	1571
4022	1	1990	1444
4022	3	1990	501
4022	3	2022	151
4023	1	2022	2174
4023	1	1990	1487
4023	3	1990	12
4023	3	2022	55.5770468514712
4024	1	2022	748
4024	1	1990	593
4024	3	1990	81
4024	3	2022	27.5444313238964
4025	1	2022	803
4025	1	1990	806
4025	3	1990	63
4025	3	2022	63
4026	1	2022	2521
4026	1	1990	2121
4026	3	1990	59
4026	3	2022	148.975742946461
4027	1	2022	7306
4027	1	1990	5843
4027	3	1990	96
4027	3	2022	341
4028	1	2022	278
4028	1	1990	276
4028	3	1990	31
4028	3	2022	26.949494949495
4029	1	2022	205
4029	1	1990	208
4029	3	1990	8
4029	3	2022	10.7091731797614
4030	1	2022	312
4030	1	1990	341
4030	3	1990	18
4030	3	2022	21
4031	1	2022	1211
4031	1	1990	1105
4031	3	1990	42
4031	3	2022	56.0593240910561
4032	1	2022	4345
4032	1	1990	2858
4032	3	1990	41
4032	3	2022	103.680129418291
4033	1	2022	883
4033	1	1990	1037
4033	3	1990	60
4033	3	2022	67.1087662337665
4034	1	2022	1318
4034	1	1990	1187
4034	3	1990	47
4034	3	2022	70.1822916666669
4035	1	2022	1292
4035	1	1990	1436
4035	3	1990	95
4035	3	2022	125
4036	1	2022	2871
4036	1	1990	1903
4036	3	1990	67
4036	3	2022	64.7729097573745
4037	1	2022	136
4037	1	1990	148
4037	3	1990	9
4037	3	2022	7.54036087369421
4038	1	2022	196
4038	1	1990	128
4038	3	1990	6
4038	3	2022	2.3539886039886
4039	1	2022	347
4039	1	1990	427
4039	3	1990	36
4039	3	2022	48.9711031044147
4040	1	2022	171
4040	1	1990	205
4040	3	1990	18
4040	3	2022	10
4041	1	2022	2728
4041	1	1990	1918
4041	3	1990	83
4041	3	2022	193.703422682063
4042	1	2022	369
4042	1	1990	417
4042	3	1990	60
4042	3	2022	45.2728280323391
4043	1	2022	1310
4043	1	1990	952
4043	3	1990	23
4043	3	2022	65.5022223686607
4044	1	2022	852
4044	1	1990	959
4044	3	1990	52
4044	3	2022	20.4132087058916
4045	1	2022	728
4045	1	1990	766
4045	3	1990	36
4045	3	2022	43.6461824785068
4046	1	2022	184
4046	1	1990	168
4046	3	1990	14
4046	3	2022	11.3475224476222
4047	1	2022	453
4047	1	1990	504
4047	3	1990	10
4047	3	2022	26
4048	1	2022	390
4048	1	1990	387
4048	3	1990	53
4048	3	2022	51.3355263157894
4049	1	2022	1298
4049	1	1990	1315
4049	3	1990	68
4049	3	2022	116
4050	1	2022	1724
4050	1	1990	1590
4050	3	1990	30
4050	3	2022	45.6176114546046
4051	1	2022	816
4051	1	1990	1089
4051	3	1990	83
4051	3	2022	112.132653061224
4052	1	2022	1007
4052	1	1990	1000
4052	3	1990	39
4052	3	2022	55.0233904027006
4053	1	2022	531
4053	1	1990	525
4053	3	1990	26
4053	3	2022	43.234387788896
4054	1	2022	124
4054	1	1990	134
4054	3	1990	14
4054	3	2022	18
4055	1	2022	263
4055	1	1990	171
4055	3	1990	19
4055	3	2022	12.8202764976959
4056	1	2022	648
4056	1	1990	472
4056	3	1990	27
4056	3	2022	27
4057	1	2022	548
4057	1	1990	630
4057	3	1990	34
4057	3	2022	66.0040601312206
4058	1	2022	1005
4058	1	1990	1020
4058	3	1990	83
4058	3	2022	82.8257377247852
4059	1	2022	1265
4059	1	1990	1350
4059	3	1990	79
4059	3	2022	92
4060	1	2022	1247
4060	1	1990	801
4060	3	1990	24
4060	3	2022	30.4288866009705
4061	1	2022	377
4061	1	1990	283
4061	3	1990	20
4061	3	2022	16.9724919093851
4062	1	2022	2177
4062	1	1990	2110
4062	3	1990	56
4062	3	2022	101
4063	1	2022	314
4063	1	1990	339
4063	3	1990	32
4063	3	2022	31.5140113658633
4064	1	2022	2354
4064	1	1990	1601
4064	3	1990	16
4064	3	2022	34.5594226923712
4065	1	2022	571
4065	1	1990	610
4065	3	1990	36
4065	3	2022	22.6835389389238
4066	1	2022	2941
4066	1	1990	2089
4066	3	1990	16
4066	3	2022	44
4067	1	2022	738
4067	1	1990	635
4067	3	1990	34
4067	3	2022	94.184845751398
4068	1	2022	414
4068	1	1990	413
4068	3	1990	15
4068	3	2022	29.121338912134
4069	1	2022	124
4069	1	1990	151
4069	3	1990	8
4069	3	2022	22
4070	1	2022	1134
4070	1	1990	952
4070	3	1990	20
4070	3	2022	42.4922705857358
4071	1	2022	192
4071	1	1990	183
4071	3	1990	21
4071	3	2022	14.3255813953489
4072	1	2022	163
4072	1	1990	231
4072	3	1990	27
4072	3	2022	34
4073	1	2022	732
4073	1	1990	673
4073	3	1990	47
4073	3	2022	33
4074	1	2022	2787
4074	1	1990	2335
4074	3	1990	68
4074	3	2022	97.8965557267018
4075	1	2022	863
4075	1	1990	1130
4075	3	1990	86
4075	3	2022	140.993690268654
4076	1	2022	1082
4076	1	1990	899
4076	3	1990	33
4076	3	2022	36.9012779965964
4077	1	2022	582
4077	1	1990	521
4077	3	1990	22
4077	3	2022	26.152280011655
4078	1	2022	1226
4078	1	1990	1439
4078	3	1990	80
4078	3	2022	110.992131177728
4079	1	2022	543
4079	1	1990	556
4079	3	1990	21
4079	3	2022	11
4080	1	2022	349
4080	1	1990	350
4080	3	1990	15
4080	3	2022	35
4081	1	2022	5663
4081	1	1990	3900
4081	3	1990	109
4081	3	2022	158.753906250001
4082	1	2022	721
4082	1	1990	540
4082	3	1990	24
4082	3	2022	30
4083	1	2022	930
4083	1	1990	687
4083	3	1990	19
4083	3	2022	54.2936564457851
4084	1	2022	382
4084	1	1990	369
4084	3	1990	27
4084	3	2022	48.3425925925926
4085	1	2022	346
4085	1	1990	370
4085	3	1990	35
4085	3	2022	23.4285714285714
4086	1	2022	656
4086	1	1990	668
4086	3	1990	58
4086	3	2022	105
4087	1	2022	656
4087	1	1990	828
4087	3	1990	64
4087	3	2022	95.3361673830951
4088	1	2022	1526
4088	1	1990	1356
4088	3	1990	25
4088	3	2022	33.4700854700855
4089	1	2022	101
4089	1	1990	122
4089	3	1990	6
4089	3	2022	4.19047619047619
4090	1	2022	955
4090	1	1990	533
4090	3	1990	20
4090	3	2022	17.4814041498107
4091	1	2022	4505
4091	1	1990	2955
4091	3	1990	114
4091	3	2022	152.004005786411
4092	1	2022	3707
4092	1	1990	2574
4092	3	1990	57
4092	3	2022	104.81706719247
4093	1	2022	394
4093	1	1990	368
4093	3	1990	23
4093	3	2022	37.1241610738256
4094	1	2022	468
4094	1	1990	232
4094	3	1990	12
4094	3	2022	7
4095	1	2022	6245
4095	1	1990	3790
4095	3	1990	32
4095	3	2022	118.482709269016
4096	1	2022	2278
4096	1	1990	1606
4096	3	1990	50
4096	3	2022	108
4097	1	2022	563
4097	1	1990	435
4097	3	1990	25
4097	3	2022	23.1648998822144
4098	1	2022	636
4098	1	1990	237
4098	3	1990	4
4098	3	2022	3.0675837320574
4099	1	2022	5860
4099	1	1990	5566
4099	3	1990	185
4099	3	2022	347.416682544172
4100	1	2022	5565
4100	1	1990	4889
4100	3	1990	186
4100	3	2022	259.032539849295
4101	1	2022	911
4101	1	1990	1027
4101	3	1990	88
4101	3	2022	73.2248817966904
4102	1	2022	124
4102	1	1990	132
4102	3	1990	17
4102	3	2022	17
4103	1	2022	1033
4103	1	1990	707
4103	3	1990	22
4103	3	2022	18.8552036199095
4104	1	2022	240
4104	1	1990	310
4104	3	1990	40
4104	3	2022	57.2307692307691
4105	1	2022	199
4105	1	1990	231
4105	3	1990	28
4105	3	2022	11.0643274853801
4106	1	2022	144
4106	1	1990	191
4106	3	1990	15
4106	3	2022	9.02910585084982
4107	1	2022	136
4107	1	1990	129
4107	3	1990	19
4107	3	2022	15.0513739545998
4108	1	2022	3569
4108	1	1990	4924
4108	3	1990	163
4108	3	2022	433.397466778081
4109	1	2022	429
4109	1	1990	444
4109	3	1990	42
4109	3	2022	44.5117063120434
4110	1	2022	626
4110	1	1990	586
4110	3	1990	53
4110	3	2022	89.3431941023536
4111	1	2022	2739
4111	1	1990	2988
4111	3	1990	146
4111	3	2022	160.449049999622
4112	1	2022	727
4112	1	1990	467
4112	3	1990	23
4112	3	2022	15.5116324865671
4113	1	2022	298
4113	1	1990	285
4113	3	1990	28
4113	3	2022	33
4114	1	2022	479
4114	1	1990	452
4114	3	1990	27
4114	3	2022	34.5560334528076
4115	1	2022	690
4115	1	1990	681
4115	3	1990	52
4115	3	2022	87.3096085409253
4116	1	2022	2997
4116	1	1990	1558
4116	3	1990	25
4116	3	2022	43.0663382244188
4117	1	2022	1644
4117	1	1990	998
4117	3	1990	31
4117	3	2022	64.4910952421918
4118	1	2022	2620
4118	1	1990	1950
4118	3	1990	49
4118	3	2022	68.0697587905305
4119	1	2022	114
4119	1	1990	88
4119	3	1990	9
4119	3	2022	8.10389610389608
4120	1	2022	183
4120	1	1990	174
4120	3	1990	6
4120	3	2022	5.04065040650405
4121	1	2022	873
4121	1	1990	999
4121	3	1990	69
4121	3	2022	66
4122	1	2022	858
4122	1	1990	475
4122	3	1990	11
4122	3	2022	10.7806267806268
4123	1	2022	1284
4123	1	1990	1329
4123	3	1990	97
4123	3	2022	141.840234652311
4124	1	2022	1712
4124	1	1990	2069
4124	3	1990	255
4124	3	2022	196
4125	1	2022	618
4125	1	1990	551
4125	3	1990	30
4125	3	2022	47.7312333443122
4126	1	2022	1253
4126	1	1990	898
4126	3	1990	48
4126	3	2022	22.7675404664866
4127	1	2022	302
4127	1	1990	234
4127	3	1990	19
4127	3	2022	28
4128	1	2022	1671
4128	1	1990	1907
4128	3	1990	128
4128	3	2022	210.340258229442
4129	1	2022	788
4129	1	1990	656
4129	3	1990	35
4129	3	2022	44.3952730236349
4130	1	2022	591
4130	1	1990	576
4130	3	1990	17
4130	3	2022	52.3481260109043
4131	1	2022	517
4131	1	1990	515
4131	3	1990	29
4131	3	2022	36.2352941176472
4132	1	2022	688
4132	1	1990	567
4132	3	1990	37
4132	3	2022	33.7768600230643
4133	1	2022	264
4133	1	1990	293
4133	3	1990	9
4133	3	2022	19.7835398999783
4134	1	2022	2096
4134	1	1990	1288
4134	3	1990	24
4134	3	2022	29.6144067796609
4135	1	2022	791
4135	1	1990	801
4135	3	1990	61
4135	3	2022	30.7460800427096
4136	1	2022	1536
4136	1	1990	1805
4136	3	1990	68
4136	3	2022	135.771989865149
4137	1	2022	2028
4137	1	1990	2409
4137	3	1990	148
4137	3	2022	223.207009277368
4138	1	2022	399
4138	1	1990	437
4138	3	1990	18
4138	3	2022	16.6070950468541
4139	1	2022	223
4139	1	1990	192
4139	3	1990	28
4139	3	2022	15.0914634146342
4140	1	2022	315
4140	1	1990	338
4140	3	1990	23
4140	3	2022	29.2064056939502
4141	1	2022	1001
4141	1	1990	943
4141	3	1990	57
4141	3	2022	53
4142	1	2022	1199
4142	1	1990	893
4142	3	1990	94
4142	3	2022	125.819992619407
4143	1	2022	1866
4143	1	1990	1280
4143	3	1990	81
4143	3	2022	76.9498012296941
4144	1	2022	5208
4144	1	1990	4090
4144	3	1990	46
4144	3	2022	118.82935805342
4145	1	2022	1272
4145	1	1990	1447
4145	3	1990	61
4145	3	2022	175
4146	1	2022	10011
4146	1	1990	6151
4146	3	1990	88
4146	3	2022	247.963652567652
4147	1	2022	690
4147	1	1990	701
4147	3	1990	68
4147	3	2022	87.1457989055172
4148	1	2022	163
4148	1	1990	204
4148	3	1990	25
4148	3	2022	21
4149	1	2022	246
4149	1	1990	339
4149	3	1990	21
4149	3	2022	28.3114065994669
4150	1	2022	1148
4150	1	1990	1206
4150	3	1990	63
4150	3	2022	122.113431886136
4151	1	2022	245
4151	1	1990	285
4151	3	1990	12
4151	3	2022	18
4152	1	2022	373
4152	1	1990	416
4152	3	1990	61
4152	3	2022	40.1279137529138
4153	1	2022	99
4153	1	1990	172
4153	3	1990	12
4153	3	2022	17.8524590163934
4154	1	2022	1526
4154	1	1990	2203
4154	3	1990	155
4154	3	2022	254.062849098011
4155	1	2022	669
4155	1	1990	810
4155	3	1990	30
4155	3	2022	51.4657534246577
4156	1	2022	361
4156	1	1990	493
4156	3	1990	23
4156	3	2022	64.3636363636364
4157	1	2022	471
4157	1	1990	309
4157	3	1990	11
4157	3	2022	10.5582947357937
4158	1	2022	1335
4158	1	1990	828
4158	3	1990	12
4158	3	2022	49.8153078202997
4159	1	2022	2067
4159	1	1990	2441
4159	3	1990	83
4159	3	2022	216.065091642828
4160	1	2022	6174
4160	1	1990	4408
4160	3	1990	43
4160	3	2022	130.670035381994
4161	1	2022	1060
4161	1	1990	909
4161	3	1990	21
4161	3	2022	79
4162	1	2022	443
4162	1	1990	593
4162	3	1990	52
4162	3	2022	33.0434749751695
4163	1	2022	517
4163	1	1990	530
4163	3	1990	35
4163	3	2022	45.0423024917909
4164	1	2022	148
4164	1	1990	156
4164	3	1990	23
4164	3	2022	44
4165	1	2022	988
4165	1	1990	740
4165	3	1990	39
4165	3	2022	37
4166	1	2022	806
4166	1	1990	709
4166	3	1990	17
4166	3	2022	50
4167	1	2022	510
4167	1	1990	426
4167	3	1990	42
4167	3	2022	30.2695035460994
4168	1	2022	388
4168	1	1990	350
4168	3	1990	26
4168	3	2022	21.2552449613458
4169	1	2022	227
4169	1	1990	273
4169	3	1990	13
4169	3	2022	27
4170	1	2022	7915
4170	1	1990	7292
4170	3	1990	117
4170	3	2022	233.995284218067
4171	1	2022	239
4171	1	1990	203
4171	3	1990	27
4171	3	2022	35.3204193837105
4172	1	2022	525
4172	1	1990	363
4172	3	1990	18
4172	3	2022	22.3346727898967
4173	1	2022	702
4173	1	1990	528
4173	3	1990	6
4173	3	2022	27.2279006853047
4174	1	2022	802
4174	1	1990	814
4174	3	1990	63
4174	3	2022	71
4175	1	2022	189
4175	1	1990	224
4175	3	1990	19
4175	3	2022	24.4700555294222
4176	1	2022	1112
4176	1	1990	708
4176	3	1990	25
4176	3	2022	31.433502043532
4177	1	2022	1159
4177	1	1990	1190
4177	3	1990	83
4177	3	2022	80.9141841888305
4178	1	2022	528
4178	1	1990	601
4178	3	1990	46
4178	3	2022	73.3160173160171
4179	1	2022	162
4179	1	1990	133
4179	3	1990	4
4179	3	2022	3.03296703296703
4180	1	2022	129754
4180	1	1990	133486
4180	3	1990	4798
4180	3	2022	7327.73926392251
4181	1	2022	1004
4181	1	1990	1059
4181	3	1990	81
4181	3	2022	162.86170212766
4182	1	2022	463
4182	1	1990	699
4182	3	1990	73
4182	3	2022	105.5938697318
4183	1	2022	1115
4183	1	1990	857
4183	3	1990	38
4183	3	2022	50.3053435114501
4184	1	2022	1693
4184	1	1990	2266
4184	3	1990	131
4184	3	2022	199.83686786297
4185	1	2022	273
4185	1	1990	357
4185	3	1990	12
4185	3	2022	13.4276449445226
4186	1	2022	376
4186	1	1990	512
4186	3	1990	80
4186	3	2022	68.0139798525654
4187	1	2022	481
4187	1	1990	556
4187	3	1990	79
4187	3	2022	77.8729536805599
4188	1	2022	286
4188	1	1990	312
4188	3	1990	12
4188	3	2022	31.3804038719411
4189	1	2022	526
4189	1	1990	251
4189	3	1990	24
4189	3	2022	25.7106535557125
4190	1	2022	733
4190	1	1990	753
4190	3	1990	31
4190	3	2022	66.3901346553731
4191	1	2022	842
4191	1	1990	858
4191	3	1990	68
4191	3	2022	81.2774559799866
4192	1	2022	1031
4192	1	1990	1206
4192	3	1990	159
4192	3	2022	134.855129790604
4193	1	2022	328
4193	1	1990	302
4193	3	1990	27
4193	3	2022	17.5285951410895
4194	1	2022	253
4194	1	1990	238
4194	3	1990	34
4194	3	2022	2.0078125
4195	1	2022	127
4195	1	1990	152
4195	3	1990	21
4195	3	2022	14.125
4196	1	2022	1584
4196	1	1990	1561
4196	3	1990	74
4196	3	2022	107
4197	1	2022	455
4197	1	1990	584
4197	3	1990	45
4197	3	2022	32.2381257577456
4198	1	2022	874
4198	1	1990	1045
4198	3	1990	74
4198	3	2022	58
4199	1	2022	2542
4199	1	1990	2297
4199	3	1990	150
4199	3	2022	133.619902492575
4200	1	2022	1594
4200	1	1990	1348
4200	3	1990	31
4200	3	2022	40.7080180540397
4201	1	2022	430
4201	1	1990	539
4201	3	1990	39
4201	3	2022	69
4202	1	2022	354
4202	1	1990	466
4202	3	1990	48
4202	3	2022	41.6369941369941
4203	1	2022	2517
4203	1	1990	1998
4203	3	1990	66
4203	3	2022	106.712060815483
4204	1	2022	1602
4204	1	1990	1811
4204	3	1990	101
4204	3	2022	159
4205	1	2022	639
4205	1	1990	602
4205	3	1990	15
4205	3	2022	25
4206	1	2022	5861
4206	1	1990	6085
4206	3	1990	68
4206	3	2022	122.063116447876
4207	1	2022	11207
4207	1	1990	8553
4207	3	1990	94
4207	3	2022	226.966197288002
4208	1	2022	179
4208	1	1990	220
4208	3	1990	10
4208	3	2022	17.3280352693386
4209	1	2022	1059
4209	1	1990	1137
4209	3	1990	26
4209	3	2022	85
4210	1	2022	1028
4210	1	1990	1194
4210	3	1990	81
4210	3	2022	123.311737924245
4211	1	2022	1356
4211	1	1990	1067
4211	3	1990	83
4211	3	2022	84
4212	1	2022	1147
4212	1	1990	1066
4212	3	1990	68
4212	3	2022	33.251125146011
4213	1	2022	518
4213	1	1990	608
4213	3	1990	47
4213	3	2022	42.989898989899
4214	1	2022	477
4214	1	1990	544
4214	3	1990	44
4214	3	2022	73.1625835189306
4215	1	2022	1161
4215	1	1990	919
4215	3	1990	52
4215	3	2022	70.4114389218898
4216	1	2022	145
4216	1	1990	185
4216	3	1990	16
4216	3	2022	3
4217	1	2022	381
4217	1	1990	302
4217	3	1990	26
4217	3	2022	20.2347164412071
4218	1	2022	4733
4218	1	1990	3423
4218	3	1990	29
4218	3	2022	78
4219	1	2022	3637
4219	1	1990	3985
4219	3	1990	166
4219	3	2022	337
4220	1	2022	594
4220	1	1990	563
4220	3	1990	48
4220	3	2022	52.5213032581453
4221	1	2022	1364
4221	1	1990	1117
4221	3	1990	107
4221	3	2022	100.359039533794
4222	1	2022	942
4222	1	1990	855
4222	3	1990	19
4222	3	2022	14
4223	1	2022	161
4223	1	1990	147
4223	3	1990	20
4223	3	2022	21
4224	1	2022	826
4224	1	1990	962
4224	3	1990	90
4224	3	2022	62.3281012658228
4225	1	2022	112
4225	1	1990	150
4225	3	1990	13
4225	3	2022	8.07446000217083
4226	1	2022	485
4226	1	1990	521
4226	3	1990	51
4226	3	2022	22.1128205128206
4227	1	2022	140
4227	1	1990	165
4227	3	1990	23
4227	3	2022	10
4228	1	2022	969
4228	1	1990	817
4228	3	1990	50
4228	3	2022	66.6543353600138
4229	1	2022	143
4229	1	1990	147
4229	3	1990	5
4229	3	2022	35
4230	1	2022	538
4230	1	1990	498
4230	3	1990	45
4230	3	2022	54
4231	1	2022	456
4231	1	1990	521
4231	3	1990	20
4231	3	2022	53.1159780470127
4232	1	2022	1651
4232	1	1990	1431
4232	3	1990	52
4232	3	2022	48
4233	1	2022	676
4233	1	1990	560
4233	3	1990	8
4233	3	2022	38.6117628180563
4234	1	2022	549
4234	1	1990	486
4234	3	1990	38
4234	3	2022	38.8911454807409
4235	1	2022	2208
4235	1	1990	1311
4235	3	1990	23
4235	3	2022	41.0043962375103
4236	1	2022	541
4236	1	1990	393
4236	3	1990	11
4236	3	2022	30.9709920647987
4237	1	2022	232
4237	1	1990	293
4237	3	1990	18
4237	3	2022	36.6425120772947
4238	1	2022	1148
4238	1	1990	1079
4238	3	1990	63
4238	3	2022	90.4690708193974
4239	1	2022	44
4239	1	1990	60
4239	3	1990	5
4239	3	2022	4
4240	1	2022	1005
4240	1	1990	661
4240	3	1990	30
4240	3	2022	15.9833011133057
4241	1	2022	360
4241	1	1990	453
4241	3	1990	44
4241	3	2022	69
4242	1	2022	830
4242	1	1990	785
4242	3	1990	28
4242	3	2022	36.8586882731878
4243	1	2022	489
4243	1	1990	436
4243	3	1990	37
4243	3	2022	30.701498483313
4244	1	2022	1630
4244	1	1990	1292
4244	3	1990	49
4244	3	2022	71.0384334869861
4245	1	2022	296
4245	1	1990	289
4245	3	1990	6
4245	3	2022	24.0634312473392
4246	1	2022	11382
4246	1	1990	10604
4246	3	1990	470
4246	3	2022	591.432382993369
4247	1	2022	182
4247	1	1990	215
4247	3	1990	11
4247	3	2022	19.0021324354658
4248	1	2022	2654
4248	1	1990	1825
4248	3	1990	25
4248	3	2022	68.3146296353646
4249	1	2022	842
4249	1	1990	636
4249	3	1990	45
4249	3	2022	37.6924415819021
4250	1	2022	1391
4250	1	1990	1547
4250	3	1990	113
4250	3	2022	160.848535666163
4251	1	2022	358
4251	1	1990	365
4251	3	1990	29
4251	3	2022	30.2136422136422
4252	1	2022	489
4252	1	1990	589
4252	3	1990	50
4252	3	2022	99.2234762979689
4253	1	2022	4319
4253	1	1990	5024
4253	3	1990	244
4253	3	2022	344.937978720848
4254	1	2022	206
4254	1	1990	118
4254	3	1990	7
4254	3	2022	24.7058823529412
4255	1	2022	146
4255	1	1990	156
4255	3	1990	37
4255	3	2022	21.0467120181406
4256	1	2022	567
4256	1	1990	410
4256	3	1990	11
4256	3	2022	26.3443935926773
4257	1	2022	145
4257	1	1990	159
4257	3	1990	17
4257	3	2022	10.1459854014599
4258	1	2022	878
4258	1	1990	719
4258	3	1990	20
4258	3	2022	35
4259	1	2022	580
4259	1	1990	456
4259	3	1990	10
4259	3	2022	36.184156631441
4260	1	2022	1069
4260	1	1990	1271
4260	3	1990	119
4260	3	2022	107.300085692197
4261	1	2022	1041
4261	1	1990	553
4261	3	1990	11
4261	3	2022	30.7758620689657
4262	1	2022	367
4262	1	1990	367
4262	3	1990	31
4262	3	2022	29
4263	1	2022	214
4263	1	1990	242
4263	3	1990	16
4263	3	2022	22.864705882353
4264	1	2022	1235
4264	1	1990	1088
4264	3	1990	76
4264	3	2022	65.5099805688037
4265	1	2022	696
4265	1	1990	561
4265	3	1990	45
4265	3	2022	27
4266	1	2022	1764
4266	1	1990	1392
4266	3	1990	34
4266	3	2022	50.1494119208491
4267	1	2022	2896
4267	1	1990	2506
4267	3	1990	60
4267	3	2022	81.478515813459
4268	1	2022	224
4268	1	1990	298
4268	3	1990	16
4268	3	2022	32.3333333333334
4269	1	2022	562
4269	1	1990	600
4269	3	1990	34
4269	3	2022	58.8688888888889
4270	1	2022	804
4270	1	1990	1046
4270	3	1990	69
4270	3	2022	111.840909090909
4271	1	2022	1196
4271	1	1990	1422
4271	3	1990	66
4271	3	2022	118.158109814994
4272	1	2022	922
4272	1	1990	668
4272	3	1990	58
4272	3	2022	14.2226706439726
4273	1	2022	1767
4273	1	1990	1447
4273	3	1990	47
4273	3	2022	101
4274	1	2022	323
4274	1	1990	321
4274	3	1990	38
4274	3	2022	33.6000747291071
4275	1	2022	6873
4275	1	1990	7558
4275	3	1990	352
4275	3	2022	445
4276	1	2022	441
4276	1	1990	277
4276	3	1990	18
4276	3	2022	14.7668256333831
4277	1	2022	157
4277	1	1990	210
4277	3	1990	19
4277	3	2022	20
4278	1	2022	879
4278	1	1990	1129
4278	3	1990	69
4278	3	2022	100.229891229319
4279	1	2022	2045
4279	1	1990	1614
4279	3	1990	86
4279	3	2022	96.1047249127291
4280	1	2022	1561
4280	1	1990	1345
4280	3	1990	31
4280	3	2022	58
4281	1	2022	54
4281	1	1990	34
4281	3	1990	10
4281	3	2022	3.44444444444444
4282	1	2022	364
4282	1	1990	427
4282	3	1990	10
4282	3	2022	46.6588391670359
4283	1	2022	128
4283	1	1990	207
4283	3	1990	8
4283	3	2022	12.0357142857143
4284	1	2022	563
4284	1	1990	431
4284	3	1990	17
4284	3	2022	18.2273768836415
4285	1	2022	397
4285	1	1990	430
4285	3	1990	27
4285	3	2022	42
4286	1	2022	708
4286	1	1990	946
4286	3	1990	50
4286	3	2022	98
4287	1	2022	122
4287	1	1990	184
4287	3	1990	18
4287	3	2022	23.0344827586207
4288	1	2022	4940
4288	1	1990	2968
4288	3	1990	44
4288	3	2022	102.455991183254
4289	1	2022	2162
4289	1	1990	1339
4289	3	1990	58
4289	3	2022	70.4243033821185
4290	1	2022	1327
4290	1	1990	1033
4290	3	1990	74
4290	3	2022	21
4291	1	2022	204
4291	1	1990	252
4291	3	1990	25
4291	3	2022	33.6792452830189
4292	1	2022	2298
4292	1	1990	1550
4292	3	1990	41
4292	3	2022	62.8207604318852
4293	1	2022	164
4293	1	1990	182
4293	3	1990	18
4293	3	2022	14.0927152317881
\.
COPY public.valstat (idc, idl, annedebut, anneefin, valeur ) FROM stdin;
1	2	2016	2021	19
1	2	2011	2015	8
2	2	2016	2021	24
2	2	2011	2015	16
3	2	2016	2021	55
3	2	2011	2015	47
4	2	2016	2021	67
4	2	2011	2015	56
5	2	2016	2021	23
5	2	2011	2015	16
6	2	2016	2021	13
6	2	2011	2015	21
7	2	2016	2021	10
7	2	2011	2015	15
8	2	2016	2021	37
8	2	2011	2015	37
9	2	2016	2021	29
9	2	2011	2015	19
10	2	2016	2021	11
10	2	2011	2015	11
11	2	2016	2021	2
11	2	2011	2015	7
12	2	2016	2021	2938
12	2	2011	2015	2670
13	2	2016	2021	33
13	2	2011	2015	31
14	2	2016	2021	26
14	2	2011	2015	30
15	2	2016	2021	79
15	2	2011	2015	103
16	2	2016	2021	2
16	2	2011	2015	7
17	2	2016	2021	36
17	2	2011	2015	24
18	2	2016	2021	46
18	2	2011	2015	48
19	2	2016	2021	53
19	2	2011	2015	43
20	2	2016	2021	67
20	2	2011	2015	55
21	2	2016	2021	4
21	2	2011	2015	5
22	2	2016	2021	187
22	2	2011	2015	192
23	2	2016	2021	5
23	2	2011	2015	9
24	2	2016	2021	47
24	2	2011	2015	53
25	2	2016	2021	16
25	2	2011	2015	18
26	2	2016	2021	29
26	2	2011	2015	24
27	2	2016	2021	7
27	2	2011	2015	5
28	2	2016	2021	6
28	2	2011	2015	7
29	2	2016	2021	16
29	2	2011	2015	22
30	2	2016	2021	7
30	2	2011	2015	8
31	2	2016	2021	8
31	2	2011	2015	5
32	2	2016	2021	14
32	2	2011	2015	18
33	2	2016	2021	23
33	2	2011	2015	9
34	2	2016	2021	3
34	2	2011	2015	3
35	2	2016	2021	3
35	2	2011	2015	4
36	2	2016	2021	9
36	2	2011	2015	12
37	2	2016	2021	25
37	2	2011	2015	21
38	2	2016	2021	53
38	2	2011	2015	71
39	2	2016	2021	14
39	2	2011	2015	16
40	2	2016	2021	4
40	2	2011	2015	6
41	2	2016	2021	8
41	2	2011	2015	15
42	2	2016	2021	8
42	2	2011	2015	17
43	2	2016	2021	9
43	2	2011	2015	4
44	2	2016	2021	5
44	2	2011	2015	2
45	2	2016	2021	6
45	2	2011	2015	7
46	2	2016	2021	45
46	2	2011	2015	43
47	2	2016	2021	48
47	2	2011	2015	57
48	2	2016	2021	17
48	2	2011	2015	13
49	2	2016	2021	67
49	2	2011	2015	52
50	2	2016	2021	7
50	2	2011	2015	8
51	2	2016	2021	23
51	2	2011	2015	16
52	2	2016	2021	194
52	2	2011	2015	215
53	2	2016	2021	6
53	2	2011	2015	3
54	2	2016	2021	7
54	2	2011	2015	10
55	2	2016	2021	51
55	2	2011	2015	61
56	2	2016	2021	29
56	2	2011	2015	31
57	2	2016	2021	20
57	2	2011	2015	14
58	2	2016	2021	26
58	2	2011	2015	20
59	2	2016	2021	37
59	2	2011	2015	28
60	2	2016	2021	9
60	2	2011	2015	15
61	2	2016	2021	75
61	2	2011	2015	52
62	2	2016	2021	43
62	2	2011	2015	34
63	2	2016	2021	15
63	2	2011	2015	20
64	2	2016	2021	81
64	2	2011	2015	83
65	2	2016	2021	20
65	2	2011	2015	19
66	2	2016	2021	6
66	2	2011	2015	20
67	2	2016	2021	27
67	2	2011	2015	25
68	2	2016	2021	38
68	2	2011	2015	38
69	2	2016	2021	275
69	2	2011	2015	244
70	2	2016	2021	19
70	2	2011	2015	21
71	2	2016	2021	7
71	2	2011	2015	10
72	2	2016	2021	33
72	2	2011	2015	37
73	2	2016	2021	19
73	2	2011	2015	14
74	2	2016	2021	20
74	2	2011	2015	15
75	2	2016	2021	155
75	2	2011	2015	158
76	2	2016	2021	45
76	2	2011	2015	33
77	2	2016	2021	4
77	2	2011	2015	4
78	2	2016	2021	49
78	2	2011	2015	38
79	2	2016	2021	160
79	2	2011	2015	132
80	2	2016	2021	155
80	2	2011	2015	142
81	2	2016	2021	5
81	2	2011	2015	4
82	2	2016	2021	86
82	2	2011	2015	78
83	2	2016	2021	0
83	2	2011	2015	3
84	2	2016	2021	15
84	2	2011	2015	14
85	2	2016	2021	160
85	2	2011	2015	158
86	2	2016	2021	4
86	2	2011	2015	4
87	2	2016	2021	9
87	2	2011	2015	10
88	2	2016	2021	32
88	2	2011	2015	38
89	2	2016	2021	72
89	2	2011	2015	69
90	2	2016	2021	1000
90	2	2011	2015	1005
91	2	2016	2021	3
91	2	2011	2015	2
92	2	2016	2021	22
92	2	2011	2015	9
93	2	2016	2021	30
93	2	2011	2015	22
94	2	2016	2021	78
94	2	2011	2015	84
95	2	2016	2021	45
95	2	2011	2015	38
96	2	2016	2021	6
96	2	2011	2015	7
97	2	2016	2021	50
97	2	2011	2015	63
98	2	2016	2021	37
98	2	2011	2015	32
99	2	2016	2021	7
99	2	2011	2015	7
100	2	2016	2021	0
100	2	2011	2015	3
101	2	2016	2021	398
101	2	2011	2015	376
102	2	2016	2021	4
102	2	2011	2015	8
103	2	2016	2021	22
103	2	2011	2015	19
104	2	2016	2021	2
104	2	2011	2015	4
105	2	2016	2021	4
105	2	2011	2015	2
106	2	2016	2021	60
106	2	2011	2015	58
107	2	2016	2021	68
107	2	2011	2015	62
108	2	2016	2021	23
108	2	2011	2015	39
109	2	2016	2021	4
109	2	2011	2015	5
110	2	2016	2021	19
110	2	2011	2015	24
111	2	2016	2021	15
111	2	2011	2015	17
112	2	2016	2021	11
112	2	2011	2015	5
113	2	2016	2021	3
113	2	2011	2015	2
114	2	2016	2021	9
114	2	2011	2015	11
115	2	2016	2021	4
115	2	2011	2015	7
116	2	2016	2021	28
116	2	2011	2015	17
117	2	2016	2021	39
117	2	2011	2015	57
118	2	2016	2021	16
118	2	2011	2015	10
119	2	2016	2021	43
119	2	2011	2015	52
120	2	2016	2021	6
120	2	2011	2015	12
121	2	2016	2021	18
121	2	2011	2015	20
122	2	2016	2021	14
122	2	2011	2015	10
123	2	2016	2021	208
123	2	2011	2015	166
124	2	2016	2021	15
124	2	2011	2015	10
125	2	2016	2021	19
125	2	2011	2015	10
126	2	2016	2021	9
126	2	2011	2015	8
127	2	2016	2021	38
127	2	2011	2015	30
128	2	2016	2021	18
128	2	2011	2015	17
129	2	2016	2021	27
129	2	2011	2015	31
130	2	2016	2021	98
130	2	2011	2015	101
131	2	2016	2021	45
131	2	2011	2015	47
132	2	2016	2021	65
132	2	2011	2015	48
133	2	2016	2021	45
133	2	2011	2015	39
134	2	2016	2021	32
134	2	2011	2015	28
135	2	2016	2021	73
135	2	2011	2015	60
136	2	2016	2021	323
136	2	2011	2015	308
137	2	2016	2021	2
137	2	2011	2015	2
138	2	2016	2021	5
138	2	2011	2015	12
139	2	2016	2021	10
139	2	2011	2015	15
140	2	2016	2021	23
140	2	2011	2015	22
141	2	2016	2021	10
141	2	2011	2015	10
142	2	2016	2021	6
142	2	2011	2015	6
143	2	2016	2021	54
143	2	2011	2015	50
144	2	2016	2021	15
144	2	2011	2015	7
145	2	2016	2021	26
145	2	2011	2015	11
146	2	2016	2021	265
146	2	2011	2015	222
147	2	2016	2021	180
147	2	2011	2015	184
148	2	2016	2021	52
148	2	2011	2015	45
149	2	2016	2021	34
149	2	2011	2015	28
150	2	2016	2021	6
150	2	2011	2015	10
151	2	2016	2021	25
151	2	2011	2015	31
152	2	2016	2021	4
152	2	2011	2015	9
153	2	2016	2021	20
153	2	2011	2015	25
154	2	2016	2021	71
154	2	2011	2015	74
155	2	2016	2021	22
155	2	2011	2015	16
156	2	2016	2021	7
156	2	2011	2015	3
157	2	2016	2021	10
157	2	2011	2015	14
158	2	2016	2021	5
158	2	2011	2015	4
159	2	2016	2021	24
159	2	2011	2015	29
160	2	2016	2021	22
160	2	2011	2015	20
161	2	2016	2021	8
161	2	2011	2015	6
162	2	2016	2021	1
162	2	2011	2015	3
163	2	2016	2021	9
163	2	2011	2015	8
164	2	2016	2021	24
164	2	2011	2015	36
165	2	2016	2021	61
165	2	2011	2015	61
166	2	2016	2021	10
166	2	2011	2015	13
167	2	2016	2021	6
167	2	2011	2015	14
168	2	2016	2021	9
168	2	2011	2015	7
169	2	2016	2021	9
169	2	2011	2015	8
170	2	2016	2021	165
170	2	2011	2015	165
171	2	2016	2021	39
171	2	2011	2015	35
172	2	2016	2021	2
172	2	2011	2015	4
173	2	2016	2021	15
173	2	2011	2015	12
174	2	2016	2021	28
174	2	2011	2015	30
175	2	2016	2021	4
175	2	2011	2015	5
176	2	2016	2021	35
176	2	2011	2015	32
177	2	2016	2021	173
177	2	2011	2015	134
178	2	2016	2021	34
178	2	2011	2015	28
179	2	2016	2021	3
179	2	2011	2015	5
180	2	2016	2021	63
180	2	2011	2015	74
181	2	2016	2021	33
181	2	2011	2015	22
182	2	2016	2021	99
182	2	2011	2015	101
183	2	2016	2021	19
183	2	2011	2015	22
184	2	2016	2021	21
184	2	2011	2015	26
185	2	2016	2021	36
185	2	2011	2015	34
186	2	2016	2021	30
186	2	2011	2015	37
187	2	2016	2021	21
187	2	2011	2015	30
188	2	2016	2021	16
188	2	2011	2015	8
189	2	2016	2021	10
189	2	2011	2015	15
190	2	2016	2021	7
190	2	2011	2015	6
191	2	2016	2021	55
191	2	2011	2015	49
192	2	2016	2021	58
192	2	2011	2015	50
193	2	2016	2021	22
193	2	2011	2015	23
194	2	2016	2021	44
194	2	2011	2015	35
195	2	2016	2021	9
195	2	2011	2015	7
196	2	2016	2021	22
196	2	2011	2015	17
197	2	2016	2021	72
197	2	2011	2015	92
198	2	2016	2021	27
198	2	2011	2015	41
199	2	2016	2021	20
199	2	2011	2015	29
200	2	2016	2021	8
200	2	2011	2015	5
201	2	2016	2021	7
201	2	2011	2015	16
202	2	2016	2021	82
202	2	2011	2015	100
203	2	2016	2021	16
203	2	2011	2015	9
204	2	2016	2021	90
204	2	2011	2015	91
205	2	2016	2021	34
205	2	2011	2015	58
206	2	2016	2021	41
206	2	2011	2015	50
207	2	2016	2021	111
207	2	2011	2015	97
208	2	2016	2021	10
208	2	2011	2015	12
209	2	2016	2021	5
209	2	2011	2015	4
210	2	2016	2021	5
210	2	2011	2015	3
211	2	2016	2021	11
211	2	2011	2015	11
212	2	2016	2021	56
212	2	2011	2015	64
213	2	2016	2021	45
213	2	2011	2015	39
214	2	2016	2021	119
214	2	2011	2015	127
215	2	2016	2021	42
215	2	2011	2015	44
216	2	2016	2021	11
216	2	2011	2015	9
217	2	2016	2021	6
217	2	2011	2015	7
218	2	2016	2021	14
218	2	2011	2015	17
219	2	2016	2021	10
219	2	2011	2015	8
220	2	2016	2021	7
220	2	2011	2015	21
221	2	2016	2021	6
221	2	2011	2015	2
222	2	2016	2021	7
222	2	2011	2015	9
223	2	2016	2021	6
223	2	2011	2015	3
224	2	2016	2021	5
224	2	2011	2015	0
225	2	2016	2021	13
225	2	2011	2015	12
226	2	2016	2021	13
226	2	2011	2015	21
227	2	2016	2021	10
227	2	2011	2015	12
228	2	2016	2021	28
228	2	2011	2015	22
229	2	2016	2021	25
229	2	2011	2015	18
230	2	2016	2021	9
230	2	2011	2015	11
231	2	2016	2021	11
231	2	2011	2015	3
232	2	2016	2021	2
232	2	2011	2015	5
233	2	2016	2021	48
233	2	2011	2015	51
234	2	2016	2021	10
234	2	2011	2015	8
235	2	2016	2021	75
235	2	2011	2015	68
236	2	2016	2021	31
236	2	2011	2015	27
237	2	2016	2021	10
237	2	2011	2015	8
238	2	2016	2021	2
238	2	2011	2015	6
239	2	2016	2021	43
239	2	2011	2015	43
240	2	2016	2021	38
240	2	2011	2015	25
241	2	2016	2021	5
241	2	2011	2015	10
242	2	2016	2021	104
242	2	2011	2015	97
243	2	2016	2021	161
243	2	2011	2015	131
244	2	2016	2021	33
244	2	2011	2015	23
245	2	2016	2021	24
245	2	2011	2015	21
246	2	2016	2021	5
246	2	2011	2015	3
247	2	2016	2021	16
247	2	2011	2015	21
248	2	2016	2021	152
248	2	2011	2015	152
249	2	2016	2021	282
249	2	2011	2015	221
250	2	2016	2021	5
250	2	2011	2015	5
251	2	2016	2021	9
251	2	2011	2015	5
252	2	2016	2021	369
252	2	2011	2015	372
253	2	2016	2021	158
253	2	2011	2015	121
254	2	2016	2021	26
254	2	2011	2015	31
255	2	2016	2021	77
255	2	2011	2015	69
256	2	2016	2021	19
256	2	2011	2015	10
257	2	2016	2021	16
257	2	2011	2015	17
258	2	2016	2021	64
258	2	2011	2015	74
259	2	2016	2021	9
259	2	2011	2015	8
260	2	2016	2021	11
260	2	2011	2015	9
261	2	2016	2021	27
261	2	2011	2015	20
262	2	2016	2021	37
262	2	2011	2015	29
263	2	2016	2021	15
263	2	2011	2015	4
264	2	2016	2021	18
264	2	2011	2015	13
265	2	2016	2021	35
265	2	2011	2015	57
266	2	2016	2021	9
266	2	2011	2015	11
267	2	2016	2021	39
267	2	2011	2015	52
268	2	2016	2021	5
268	2	2011	2015	7
269	2	2016	2021	8
269	2	2011	2015	14
270	2	2016	2021	17
270	2	2011	2015	24
271	2	2016	2021	17
271	2	2011	2015	21
272	2	2016	2021	68
272	2	2011	2015	52
273	2	2016	2021	3
273	2	2011	2015	4
274	2	2016	2021	18
274	2	2011	2015	29
275	2	2016	2021	8
275	2	2011	2015	3
276	2	2016	2021	11
276	2	2011	2015	3
277	2	2016	2021	42
277	2	2011	2015	44
278	2	2016	2021	39
278	2	2011	2015	34
279	2	2016	2021	2
279	2	2011	2015	5
280	2	2016	2021	10
280	2	2011	2015	5
281	2	2016	2021	7
281	2	2011	2015	2
282	2	2016	2021	9
282	2	2011	2015	17
283	2	2016	2021	42
283	2	2011	2015	37
284	2	2016	2021	16
284	2	2011	2015	19
285	2	2016	2021	41
285	2	2011	2015	35
286	2	2016	2021	53
286	2	2011	2015	46
287	2	2016	2021	158
287	2	2011	2015	145
288	2	2016	2021	19
288	2	2011	2015	8
289	2	2016	2021	13
289	2	2011	2015	15
290	2	2016	2021	3
290	2	2011	2015	10
291	2	2016	2021	10
291	2	2011	2015	10
292	2	2016	2021	15
292	2	2011	2015	17
293	2	2016	2021	71
293	2	2011	2015	52
294	2	2016	2021	19
294	2	2011	2015	25
295	2	2016	2021	38
295	2	2011	2015	31
296	2	2016	2021	19
296	2	2011	2015	15
297	2	2016	2021	40
297	2	2011	2015	27
298	2	2016	2021	5
298	2	2011	2015	3
299	2	2016	2021	1
299	2	2011	2015	1
300	2	2016	2021	5
300	2	2011	2015	5
301	2	2016	2021	394
301	2	2011	2015	333
302	2	2016	2021	49
302	2	2011	2015	37
303	2	2016	2021	21
303	2	2011	2015	30
304	2	2016	2021	21
304	2	2011	2015	15
305	2	2016	2021	16
305	2	2011	2015	20
306	2	2016	2021	29
306	2	2011	2015	39
307	2	2016	2021	2
307	2	2011	2015	3
308	2	2016	2021	7
308	2	2011	2015	6
309	2	2016	2021	85
309	2	2011	2015	79
310	2	2016	2021	51
310	2	2011	2015	47
311	2	2016	2021	38
311	2	2011	2015	35
312	2	2016	2021	58
312	2	2011	2015	55
313	2	2016	2021	4
313	2	2011	2015	4
314	2	2016	2021	5
314	2	2011	2015	8
315	2	2016	2021	841
315	2	2011	2015	687
316	2	2016	2021	23
316	2	2011	2015	23
317	2	2016	2021	7
317	2	2011	2015	0
318	2	2016	2021	32
318	2	2011	2015	28
319	2	2016	2021	82
319	2	2011	2015	67
320	2	2016	2021	15
320	2	2011	2015	27
321	2	2016	2021	8
321	2	2011	2015	11
322	2	2016	2021	27
322	2	2011	2015	36
323	2	2016	2021	48
323	2	2011	2015	45
324	2	2016	2021	27
324	2	2011	2015	22
325	2	2016	2021	58
325	2	2011	2015	66
326	2	2016	2021	22
326	2	2011	2015	17
327	2	2016	2021	49
327	2	2011	2015	65
328	2	2016	2021	3
328	2	2011	2015	0
329	2	2016	2021	2
329	2	2011	2015	5
330	2	2016	2021	10
330	2	2011	2015	10
331	2	2016	2021	174
331	2	2011	2015	161
332	2	2016	2021	3
332	2	2011	2015	1
333	2	2016	2021	22
333	2	2011	2015	7
334	2	2016	2021	6
334	2	2011	2015	10
335	2	2016	2021	21
335	2	2011	2015	13
336	2	2016	2021	0
336	2	2011	2015	2
337	2	2016	2021	16
337	2	2011	2015	11
338	2	2016	2021	24
338	2	2011	2015	18
339	2	2016	2021	5
339	2	2011	2015	12
340	2	2016	2021	11
340	2	2011	2015	14
341	2	2016	2021	7
341	2	2011	2015	2
342	2	2016	2021	2
342	2	2011	2015	3
343	2	2016	2021	4
343	2	2011	2015	14
344	2	2016	2021	57
344	2	2011	2015	34
345	2	2016	2021	21
345	2	2011	2015	23
346	2	2016	2021	32
346	2	2011	2015	33
347	2	2016	2021	23
347	2	2011	2015	18
348	2	2016	2021	8
348	2	2011	2015	7
349	2	2016	2021	16
349	2	2011	2015	14
350	2	2016	2021	66
350	2	2011	2015	53
351	2	2016	2021	26
351	2	2011	2015	24
352	2	2016	2021	69
352	2	2011	2015	53
353	2	2016	2021	7
353	2	2011	2015	11
354	2	2016	2021	14
354	2	2011	2015	10
355	2	2016	2021	16
355	2	2011	2015	31
356	2	2016	2021	46
356	2	2011	2015	30
357	2	2016	2021	9
357	2	2011	2015	14
358	2	2016	2021	14
358	2	2011	2015	19
359	2	2016	2021	21
359	2	2011	2015	27
360	2	2016	2021	2
360	2	2011	2015	10
361	2	2016	2021	214
361	2	2011	2015	172
362	2	2016	2021	6
362	2	2011	2015	3
363	2	2016	2021	13
363	2	2011	2015	6
364	2	2016	2021	16
364	2	2011	2015	15
365	2	2016	2021	17
365	2	2011	2015	19
366	2	2016	2021	152
366	2	2011	2015	118
367	2	2016	2021	132
367	2	2011	2015	79
368	2	2016	2021	146
368	2	2011	2015	123
369	2	2016	2021	24
369	2	2011	2015	19
370	2	2016	2021	11
370	2	2011	2015	8
371	2	2016	2021	24
371	2	2011	2015	13
372	2	2016	2021	22
372	2	2011	2015	40
373	2	2016	2021	38
373	2	2011	2015	35
374	2	2016	2021	42
374	2	2011	2015	32
375	2	2016	2021	57
375	2	2011	2015	57
376	2	2016	2021	64
376	2	2011	2015	45
377	2	2016	2021	13
377	2	2011	2015	19
378	2	2016	2021	146
378	2	2011	2015	139
379	2	2016	2021	45
379	2	2011	2015	53
380	2	2016	2021	17
380	2	2011	2015	21
381	2	2016	2021	48
381	2	2011	2015	37
382	2	2016	2021	28
382	2	2011	2015	24
383	2	2016	2021	24
383	2	2011	2015	21
384	2	2016	2021	25
384	2	2011	2015	24
385	2	2016	2021	586
385	2	2011	2015	422
386	2	2016	2021	3
386	2	2011	2015	11
387	2	2016	2021	33
387	2	2011	2015	49
388	2	2016	2021	7
388	2	2011	2015	11
389	2	2016	2021	50
389	2	2011	2015	54
390	2	2016	2021	30
390	2	2011	2015	20
391	2	2016	2021	17
391	2	2011	2015	18
392	2	2016	2021	3
392	2	2011	2015	1
393	2	2016	2021	37
393	2	2011	2015	55
394	2	2016	2021	24
394	2	2011	2015	31
395	2	2016	2021	34
395	2	2011	2015	36
396	2	2016	2021	10
396	2	2011	2015	10
397	2	2016	2021	156
397	2	2011	2015	165
398	2	2016	2021	19
398	2	2011	2015	25
399	2	2016	2021	34
399	2	2011	2015	35
400	2	2016	2021	73
400	2	2011	2015	86
401	2	2016	2021	50
401	2	2011	2015	55
402	2	2016	2021	15
402	2	2011	2015	16
403	2	2016	2021	10
403	2	2011	2015	4
404	2	2016	2021	10
404	2	2011	2015	20
405	2	2016	2021	0
405	2	2011	2015	3
406	2	2016	2021	26
406	2	2011	2015	38
407	2	2016	2021	103
407	2	2011	2015	87
408	2	2016	2021	41
408	2	2011	2015	30
409	2	2016	2021	65
409	2	2011	2015	75
410	2	2016	2021	7
410	2	2011	2015	6
411	2	2016	2021	6
411	2	2011	2015	15
412	2	2016	2021	39
412	2	2011	2015	38
413	2	2016	2021	52
413	2	2011	2015	50
414	2	2016	2021	128
414	2	2011	2015	124
415	2	2016	2021	77
415	2	2011	2015	52
416	2	2016	2021	6
416	2	2011	2015	13
417	2	2016	2021	7
417	2	2011	2015	11
418	2	2016	2021	11
418	2	2011	2015	7
419	2	2016	2021	25
419	2	2011	2015	23
420	2	2016	2021	113
420	2	2011	2015	86
421	2	2016	2021	89
421	2	2011	2015	65
422	2	2016	2021	12
422	2	2011	2015	13
423	2	2016	2021	7
423	2	2011	2015	6
424	2	2016	2021	5
424	2	2011	2015	8
425	2	2016	2021	4
425	2	2011	2015	15
426	2	2016	2021	62
426	2	2011	2015	45
427	2	2016	2021	27
427	2	2011	2015	33
428	2	2016	2021	61
428	2	2011	2015	65
429	2	2016	2021	57
429	2	2011	2015	47
430	2	2016	2021	66
430	2	2011	2015	43
431	2	2016	2021	77
431	2	2011	2015	57
432	2	2016	2021	22
432	2	2011	2015	17
433	2	2016	2021	60
433	2	2011	2015	57
434	2	2016	2021	29
434	2	2011	2015	25
435	2	2016	2021	76
435	2	2011	2015	83
436	2	2016	2021	51
436	2	2011	2015	61
437	2	2016	2021	13
437	2	2011	2015	18
438	2	2016	2021	29
438	2	2011	2015	33
439	2	2016	2021	43
439	2	2011	2015	34
440	2	2016	2021	38
440	2	2011	2015	34
441	2	2016	2021	22
441	2	2011	2015	28
442	2	2016	2021	159
442	2	2011	2015	133
443	2	2016	2021	8
443	2	2011	2015	15
444	2	2016	2021	47
444	2	2011	2015	48
445	2	2016	2021	111
445	2	2011	2015	104
446	2	2016	2021	12
446	2	2011	2015	7
447	2	2016	2021	177
447	2	2011	2015	153
448	2	2016	2021	164
448	2	2011	2015	186
449	2	2016	2021	6
449	2	2011	2015	10
450	2	2016	2021	2
450	2	2011	2015	6
451	2	2016	2021	33
451	2	2011	2015	34
452	2	2016	2021	35
452	2	2011	2015	25
453	2	2016	2021	36
453	2	2011	2015	29
454	2	2016	2021	62
454	2	2011	2015	64
455	2	2016	2021	12
455	2	2011	2015	19
456	2	2016	2021	63
456	2	2011	2015	51
457	2	2016	2021	49
457	2	2011	2015	39
458	2	2016	2021	6
458	2	2011	2015	9
459	2	2016	2021	25
459	2	2011	2015	25
460	2	2016	2021	114
460	2	2011	2015	91
461	2	2016	2021	15
461	2	2011	2015	23
462	2	2016	2021	96
462	2	2011	2015	102
463	2	2016	2021	51
463	2	2011	2015	31
464	2	2016	2021	39
464	2	2011	2015	39
465	2	2016	2021	47
465	2	2011	2015	46
466	2	2016	2021	34
466	2	2011	2015	36
467	2	2016	2021	7
467	2	2011	2015	9
468	2	2016	2021	15
468	2	2011	2015	16
469	2	2016	2021	7
469	2	2011	2015	5
470	2	2016	2021	9
470	2	2011	2015	5
471	2	2016	2021	22
471	2	2011	2015	8
472	2	2016	2021	78
472	2	2011	2015	60
473	2	2016	2021	102
473	2	2011	2015	90
474	2	2016	2021	26
474	2	2011	2015	34
475	2	2016	2021	10
475	2	2011	2015	10
476	2	2016	2021	26
476	2	2011	2015	25
477	2	2016	2021	9
477	2	2011	2015	12
478	2	2016	2021	12
478	2	2011	2015	14
479	2	2016	2021	136
479	2	2011	2015	115
480	2	2016	2021	39
480	2	2011	2015	32
481	2	2016	2021	34
481	2	2011	2015	24
482	2	2016	2021	21
482	2	2011	2015	16
483	2	2016	2021	84
483	2	2011	2015	88
484	2	2016	2021	48
484	2	2011	2015	45
485	2	2016	2021	29
485	2	2011	2015	43
486	2	2016	2021	16
486	2	2011	2015	14
487	2	2016	2021	4
487	2	2011	2015	7
488	2	2016	2021	101
488	2	2011	2015	79
489	2	2016	2021	7
489	2	2011	2015	12
490	2	2016	2021	10
490	2	2011	2015	8
491	2	2016	2021	15
491	2	2011	2015	18
492	2	2016	2021	131
492	2	2011	2015	106
493	2	2016	2021	29
493	2	2011	2015	24
494	2	2016	2021	241
494	2	2011	2015	210
495	2	2016	2021	19
495	2	2011	2015	36
496	2	2016	2021	20
496	2	2011	2015	19
497	2	2016	2021	137
497	2	2011	2015	148
498	2	2016	2021	74
498	2	2011	2015	87
499	2	2016	2021	13
499	2	2011	2015	21
500	2	2016	2021	1
500	2	2011	2015	2
501	2	2016	2021	22
501	2	2011	2015	29
502	2	2016	2021	32
502	2	2011	2015	32
503	2	2016	2021	36
503	2	2011	2015	26
504	2	2016	2021	89
504	2	2011	2015	109
505	2	2016	2021	53
505	2	2011	2015	46
506	2	2016	2021	120
506	2	2011	2015	104
507	2	2016	2021	3
507	2	2011	2015	4
508	2	2016	2021	6
508	2	2011	2015	10
509	2	2016	2021	133
509	2	2011	2015	59
510	2	2016	2021	18
510	2	2011	2015	20
511	2	2016	2021	13
511	2	2011	2015	14
512	2	2016	2021	105
512	2	2011	2015	99
513	2	2016	2021	6
513	2	2011	2015	5
514	2	2016	2021	20
514	2	2011	2015	30
515	2	2016	2021	69
515	2	2011	2015	85
516	2	2016	2021	14
516	2	2011	2015	23
517	2	2016	2021	99
517	2	2011	2015	84
518	2	2016	2021	31
518	2	2011	2015	43
519	2	2016	2021	104
519	2	2011	2015	111
520	2	2016	2021	36
520	2	2011	2015	38
521	2	2016	2021	130
521	2	2011	2015	132
522	2	2016	2021	3
522	2	2011	2015	5
523	2	2016	2021	67
523	2	2011	2015	58
524	2	2016	2021	48
524	2	2011	2015	37
525	2	2016	2021	1
525	2	2011	2015	2
526	2	2016	2021	6
526	2	2011	2015	5
527	2	2016	2021	7
527	2	2011	2015	5
528	2	2016	2021	71
528	2	2011	2015	84
529	2	2016	2021	4
529	2	2011	2015	0
530	2	2016	2021	25
530	2	2011	2015	14
531	2	2016	2021	33
531	2	2011	2015	37
532	2	2016	2021	49
532	2	2011	2015	53
533	2	2016	2021	35
533	2	2011	2015	42
534	2	2016	2021	84
534	2	2011	2015	89
535	2	2016	2021	89
535	2	2011	2015	86
536	2	2016	2021	20
536	2	2011	2015	28
537	2	2016	2021	17
537	2	2011	2015	19
538	2	2016	2021	105
538	2	2011	2015	127
539	2	2016	2021	31
539	2	2011	2015	25
540	2	2016	2021	44
540	2	2011	2015	45
541	2	2016	2021	123
541	2	2011	2015	100
542	2	2016	2021	178
542	2	2011	2015	173
543	2	2016	2021	8
543	2	2011	2015	6
544	2	2016	2021	28
544	2	2011	2015	22
545	2	2016	2021	136
545	2	2011	2015	126
546	2	2016	2021	29
546	2	2011	2015	28
547	2	2016	2021	10
547	2	2011	2015	13
548	2	2016	2021	252
548	2	2011	2015	232
549	2	2016	2021	45
549	2	2011	2015	45
550	2	2016	2021	25
550	2	2011	2015	24
551	2	2016	2021	44
551	2	2011	2015	51
552	2	2016	2021	15
552	2	2011	2015	16
553	2	2016	2021	15
553	2	2011	2015	20
554	2	2016	2021	7
554	2	2011	2015	13
555	2	2016	2021	37
555	2	2011	2015	21
556	2	2016	2021	66
556	2	2011	2015	56
557	2	2016	2021	10
557	2	2011	2015	7
558	2	2016	2021	20
558	2	2011	2015	16
559	2	2016	2021	18
559	2	2011	2015	17
560	2	2016	2021	8
560	2	2011	2015	8
561	2	2016	2021	6
561	2	2011	2015	3
562	2	2016	2021	22
562	2	2011	2015	36
563	2	2016	2021	2
563	2	2011	2015	5
564	2	2016	2021	52
564	2	2011	2015	50
565	2	2016	2021	16
565	2	2011	2015	10
566	2	2016	2021	169
566	2	2011	2015	186
567	2	2016	2021	219
567	2	2011	2015	230
568	2	2016	2021	23
568	2	2011	2015	23
569	2	2016	2021	51
569	2	2011	2015	47
570	2	2016	2021	149
570	2	2011	2015	127
571	2	2016	2021	2
571	2	2011	2015	5
572	2	2016	2021	84
572	2	2011	2015	90
573	2	2016	2021	71
573	2	2011	2015	73
574	2	2016	2021	45
574	2	2011	2015	51
575	2	2016	2021	8
575	2	2011	2015	9
576	2	2016	2021	110
576	2	2011	2015	108
577	2	2016	2021	15
577	2	2011	2015	10
578	2	2016	2021	67
578	2	2011	2015	75
579	2	2016	2021	5
579	2	2011	2015	4
580	2	2016	2021	90
580	2	2011	2015	62
581	2	2016	2021	16
581	2	2011	2015	17
582	2	2016	2021	16
582	2	2011	2015	12
583	2	2016	2021	37
583	2	2011	2015	34
584	2	2016	2021	67
584	2	2011	2015	65
585	2	2016	2021	40
585	2	2011	2015	32
586	2	2016	2021	24
586	2	2011	2015	15
587	2	2016	2021	163
587	2	2011	2015	126
588	2	2016	2021	97
588	2	2011	2015	71
589	2	2016	2021	60
589	2	2011	2015	64
590	2	2016	2021	57
590	2	2011	2015	46
591	2	2016	2021	32
591	2	2011	2015	31
592	2	2016	2021	89
592	2	2011	2015	62
593	2	2016	2021	18
593	2	2011	2015	27
594	2	2016	2021	28
594	2	2011	2015	41
595	2	2016	2021	31
595	2	2011	2015	30
596	2	2016	2021	15
596	2	2011	2015	9
597	2	2016	2021	23
597	2	2011	2015	13
598	2	2016	2021	13
598	2	2011	2015	12
599	2	2016	2021	87
599	2	2011	2015	109
600	2	2016	2021	8
600	2	2011	2015	6
601	2	2016	2021	36
601	2	2011	2015	46
602	2	2016	2021	17
602	2	2011	2015	12
603	2	2016	2021	25
603	2	2011	2015	24
604	2	2016	2021	16
604	2	2011	2015	13
605	2	2016	2021	3
605	2	2011	2015	6
606	2	2016	2021	15
606	2	2011	2015	18
607	2	2016	2021	19
607	2	2011	2015	11
608	2	2016	2021	63
608	2	2011	2015	60
609	2	2016	2021	21
609	2	2011	2015	26
610	2	2016	2021	236
610	2	2011	2015	212
611	2	2016	2021	76
611	2	2011	2015	82
612	2	2016	2021	55
612	2	2011	2015	51
613	2	2016	2021	88
613	2	2011	2015	107
614	2	2016	2021	20
614	2	2011	2015	16
615	2	2016	2021	40
615	2	2011	2015	32
616	2	2016	2021	24
616	2	2011	2015	22
617	2	2016	2021	21
617	2	2011	2015	9
618	2	2016	2021	37
618	2	2011	2015	60
619	2	2016	2021	417
619	2	2011	2015	401
620	2	2016	2021	28
620	2	2011	2015	23
621	2	2016	2021	3
621	2	2011	2015	3
622	2	2016	2021	38
622	2	2011	2015	38
623	2	2016	2021	42
623	2	2011	2015	55
624	2	2016	2021	35
624	2	2011	2015	27
625	2	2016	2021	45
625	2	2011	2015	42
626	2	2016	2021	5
626	2	2011	2015	11
627	2	2016	2021	10
627	2	2011	2015	11
628	2	2016	2021	182
628	2	2011	2015	189
629	2	2016	2021	73
629	2	2011	2015	74
630	2	2016	2021	39
630	2	2011	2015	49
631	2	2016	2021	14
631	2	2011	2015	19
632	2	2016	2021	18
632	2	2011	2015	10
633	2	2016	2021	15
633	2	2011	2015	16
634	2	2016	2021	21
634	2	2011	2015	13
635	2	2016	2021	15
635	2	2011	2015	12
636	2	2016	2021	304
636	2	2011	2015	260
637	2	2016	2021	33
637	2	2011	2015	27
638	2	2016	2021	53
638	2	2011	2015	49
639	2	2016	2021	4
639	2	2011	2015	8
640	2	2016	2021	39
640	2	2011	2015	35
641	2	2016	2021	56
641	2	2011	2015	52
642	2	2016	2021	92
642	2	2011	2015	71
643	2	2016	2021	58
643	2	2011	2015	64
644	2	2016	2021	1230
644	2	2011	2015	1248
645	2	2016	2021	4086
645	2	2011	2015	3478
646	2	2016	2021	5
646	2	2011	2015	0
647	2	2016	2021	37
647	2	2011	2015	26
648	2	2016	2021	73
648	2	2011	2015	58
649	2	2016	2021	27
649	2	2011	2015	19
650	2	2016	2021	16
650	2	2011	2015	15
651	2	2016	2021	512
651	2	2011	2015	537
652	2	2016	2021	75
652	2	2011	2015	68
653	2	2016	2021	120
653	2	2011	2015	109
654	2	2016	2021	69
654	2	2011	2015	68
655	2	2016	2021	68
655	2	2011	2015	63
656	2	2016	2021	54
656	2	2011	2015	57
657	2	2016	2021	34
657	2	2011	2015	34
658	2	2016	2021	10
658	2	2011	2015	14
659	2	2016	2021	53
659	2	2011	2015	48
660	2	2016	2021	92
660	2	2011	2015	96
661	2	2016	2021	21
661	2	2011	2015	24
662	2	2016	2021	20
662	2	2011	2015	24
663	2	2016	2021	17
663	2	2011	2015	19
664	2	2016	2021	5
664	2	2011	2015	3
665	2	2016	2021	19
665	2	2011	2015	27
666	2	2016	2021	17
666	2	2011	2015	28
667	2	2016	2021	45
667	2	2011	2015	53
668	2	2016	2021	47
668	2	2011	2015	58
669	2	2016	2021	5
669	2	2011	2015	3
670	2	2016	2021	19
670	2	2011	2015	12
671	2	2016	2021	21
671	2	2011	2015	11
672	2	2016	2021	17
672	2	2011	2015	17
673	2	2016	2021	40
673	2	2011	2015	25
674	2	2016	2021	14
674	2	2011	2015	15
675	2	2016	2021	76
675	2	2011	2015	77
676	2	2016	2021	47
676	2	2011	2015	37
677	2	2016	2021	26
677	2	2011	2015	18
678	2	2016	2021	92
678	2	2011	2015	126
679	2	2016	2021	10
679	2	2011	2015	15
680	2	2016	2021	106
680	2	2011	2015	109
681	2	2016	2021	131
681	2	2011	2015	123
682	2	2016	2021	115
682	2	2011	2015	100
683	2	2016	2021	48
683	2	2011	2015	41
684	2	2016	2021	65
684	2	2011	2015	83
685	2	2016	2021	8
685	2	2011	2015	6
686	2	2016	2021	21
686	2	2011	2015	26
687	2	2016	2021	2
687	2	2011	2015	10
688	2	2016	2021	81
688	2	2011	2015	68
689	2	2016	2021	9
689	2	2011	2015	13
690	2	2016	2021	100
690	2	2011	2015	82
691	2	2016	2021	271
691	2	2011	2015	319
692	2	2016	2021	49
692	2	2011	2015	36
693	2	2016	2021	202
693	2	2011	2015	197
694	2	2016	2021	23
694	2	2011	2015	19
695	2	2016	2021	97
695	2	2011	2015	113
696	2	2016	2021	133
696	2	2011	2015	90
697	2	2016	2021	38
697	2	2011	2015	29
698	2	2016	2021	32
698	2	2011	2015	26
699	2	2016	2021	10
699	2	2011	2015	19
700	2	2016	2021	21
700	2	2011	2015	14
701	2	2016	2021	11
701	2	2011	2015	14
702	2	2016	2021	72
702	2	2011	2015	80
703	2	2016	2021	112
703	2	2011	2015	112
704	2	2016	2021	2
704	2	2011	2015	2
705	2	2016	2021	13
705	2	2011	2015	10
706	2	2016	2021	15
706	2	2011	2015	10
707	2	2016	2021	12
707	2	2011	2015	20
708	2	2016	2021	16
708	2	2011	2015	15
709	2	2016	2021	30
709	2	2011	2015	19
710	2	2016	2021	6
710	2	2011	2015	10
711	2	2016	2021	63
711	2	2011	2015	59
712	2	2016	2021	4
712	2	2011	2015	7
713	2	2016	2021	134
713	2	2011	2015	127
714	2	2016	2021	9
714	2	2011	2015	9
715	2	2016	2021	54
715	2	2011	2015	62
716	2	2016	2021	206
716	2	2011	2015	128
717	2	2016	2021	5
717	2	2011	2015	8
718	2	2016	2021	13
718	2	2011	2015	26
719	2	2016	2021	8
719	2	2011	2015	8
720	2	2016	2021	88
720	2	2011	2015	75
721	2	2016	2021	11
721	2	2011	2015	11
722	2	2016	2021	34
722	2	2011	2015	27
723	2	2016	2021	16
723	2	2011	2015	17
724	2	2016	2021	12
724	2	2011	2015	4
725	2	2016	2021	271
725	2	2011	2015	251
726	2	2016	2021	15
726	2	2011	2015	23
727	2	2016	2021	78
727	2	2011	2015	83
728	2	2016	2021	5
728	2	2011	2015	12
729	2	2016	2021	25
729	2	2011	2015	22
730	2	2016	2021	3
730	2	2011	2015	4
731	2	2016	2021	103
731	2	2011	2015	85
732	2	2016	2021	90
732	2	2011	2015	77
733	2	2016	2021	52
733	2	2011	2015	39
734	2	2016	2021	19
734	2	2011	2015	10
735	2	2016	2021	125
735	2	2011	2015	93
736	2	2016	2021	102
736	2	2011	2015	82
737	2	2016	2021	7
737	2	2011	2015	14
738	2	2016	2021	33
738	2	2011	2015	25
739	2	2016	2021	0
739	2	2011	2015	1
740	2	2016	2021	6
740	2	2011	2015	4
741	2	2016	2021	24
741	2	2011	2015	36
742	2	2016	2021	48
742	2	2011	2015	29
743	2	2016	2021	10
743	2	2011	2015	6
744	2	2016	2021	31
744	2	2011	2015	17
745	2	2016	2021	336
745	2	2011	2015	238
746	2	2016	2021	70
746	2	2011	2015	60
747	2	2016	2021	124
747	2	2011	2015	103
748	2	2016	2021	15
748	2	2011	2015	19
749	2	2016	2021	25
749	2	2011	2015	31
750	2	2016	2021	23
750	2	2011	2015	42
751	2	2016	2021	92
751	2	2011	2015	98
752	2	2016	2021	280
752	2	2011	2015	185
753	2	2016	2021	1188
753	2	2011	2015	1133
754	2	2016	2021	0
754	2	2011	2015	0
755	2	2016	2021	9
755	2	2011	2015	9
756	2	2016	2021	19
756	2	2011	2015	29
757	2	2016	2021	109
757	2	2011	2015	83
758	2	2016	2021	221
758	2	2011	2015	235
759	2	2016	2021	6
759	2	2011	2015	3
760	2	2016	2021	2
760	2	2011	2015	2
761	2	2016	2021	12
761	2	2011	2015	20
762	2	2016	2021	118
762	2	2011	2015	100
763	2	2016	2021	24
763	2	2011	2015	20
764	2	2016	2021	8
764	2	2011	2015	4
765	2	2016	2021	23
765	2	2011	2015	19
766	2	2016	2021	93
766	2	2011	2015	88
767	2	2016	2021	10
767	2	2011	2015	20
768	2	2016	2021	49
768	2	2011	2015	42
769	2	2016	2021	19
769	2	2011	2015	12
770	2	2016	2021	8
770	2	2011	2015	6
771	2	2016	2021	322
771	2	2011	2015	315
772	2	2016	2021	9
772	2	2011	2015	12
773	2	2016	2021	45
773	2	2011	2015	34
774	2	2016	2021	2
774	2	2011	2015	1
775	2	2016	2021	18
775	2	2011	2015	12
776	2	2016	2021	35
776	2	2011	2015	50
777	2	2016	2021	17
777	2	2011	2015	25
778	2	2016	2021	55
778	2	2011	2015	42
779	2	2016	2021	31
779	2	2011	2015	20
780	2	2016	2021	143
780	2	2011	2015	103
781	2	2016	2021	79
781	2	2011	2015	76
782	2	2016	2021	18
782	2	2011	2015	14
783	2	2016	2021	16
783	2	2011	2015	15
784	2	2016	2021	119
784	2	2011	2015	144
785	2	2016	2021	61
785	2	2011	2015	64
786	2	2016	2021	436
786	2	2011	2015	412
787	2	2016	2021	8
787	2	2011	2015	10
788	2	2016	2021	18
788	2	2011	2015	22
789	2	2016	2021	157
789	2	2011	2015	145
790	2	2016	2021	75
790	2	2011	2015	86
791	2	2016	2021	27
791	2	2011	2015	26
792	2	2016	2021	30
792	2	2011	2015	30
793	2	2016	2021	72
793	2	2011	2015	70
794	2	2016	2021	10
794	2	2011	2015	4
795	2	2016	2021	27
795	2	2011	2015	26
796	2	2016	2021	43
796	2	2011	2015	35
797	2	2016	2021	108
797	2	2011	2015	94
798	2	2016	2021	47
798	2	2011	2015	41
799	2	2016	2021	60
799	2	2011	2015	82
800	2	2016	2021	10
800	2	2011	2015	4
801	2	2016	2021	24
801	2	2011	2015	12
802	2	2016	2021	160
802	2	2011	2015	187
803	2	2016	2021	17
803	2	2011	2015	16
804	2	2016	2021	8
804	2	2011	2015	9
805	2	2016	2021	26
805	2	2011	2015	31
806	2	2016	2021	15
806	2	2011	2015	8
807	2	2016	2021	6
807	2	2011	2015	5
808	2	2016	2021	156
808	2	2011	2015	225
809	2	2016	2021	6
809	2	2011	2015	3
810	2	2016	2021	31
810	2	2011	2015	36
811	2	2016	2021	15
811	2	2011	2015	21
812	2	2016	2021	7
812	2	2011	2015	3
813	2	2016	2021	5
813	2	2011	2015	3
814	2	2016	2021	7
814	2	2011	2015	16
815	2	2016	2021	51
815	2	2011	2015	48
816	2	2016	2021	6
816	2	2011	2015	3
817	2	2016	2021	24
817	2	2011	2015	33
818	2	2016	2021	94
818	2	2011	2015	99
819	2	2016	2021	56
819	2	2011	2015	64
820	2	2016	2021	40
820	2	2011	2015	37
821	2	2016	2021	27
821	2	2011	2015	12
822	2	2016	2021	11
822	2	2011	2015	4
823	2	2016	2021	26
823	2	2011	2015	29
824	2	2016	2021	17
824	2	2011	2015	5
825	2	2016	2021	23
825	2	2011	2015	27
826	2	2016	2021	186
826	2	2011	2015	195
827	2	2016	2021	4
827	2	2011	2015	8
828	2	2016	2021	37
828	2	2011	2015	29
829	2	2016	2021	9
829	2	2011	2015	4
830	2	2016	2021	4
830	2	2011	2015	7
831	2	2016	2021	107
831	2	2011	2015	97
832	2	2016	2021	48
832	2	2011	2015	35
833	2	2016	2021	5
833	2	2011	2015	10
834	2	2016	2021	43
834	2	2011	2015	47
835	2	2016	2021	2
835	2	2011	2015	4
836	2	2016	2021	27
836	2	2011	2015	30
837	2	2016	2021	14
837	2	2011	2015	21
838	2	2016	2021	3
838	2	2011	2015	3
839	2	2016	2021	3
839	2	2011	2015	2
840	2	2016	2021	32
840	2	2011	2015	34
841	2	2016	2021	6
841	2	2011	2015	2
842	2	2016	2021	8
842	2	2011	2015	1
843	2	2016	2021	4
843	2	2011	2015	5
844	2	2016	2021	64
844	2	2011	2015	53
845	2	2016	2021	22
845	2	2011	2015	16
846	2	2016	2021	10
846	2	2011	2015	17
847	2	2016	2021	12
847	2	2011	2015	10
848	2	2016	2021	1
848	2	2011	2015	1
849	2	2016	2021	86
849	2	2011	2015	79
850	2	2016	2021	13
850	2	2011	2015	7
851	2	2016	2021	41
851	2	2011	2015	44
852	2	2016	2021	2706
852	2	2011	2015	2518
853	2	2016	2021	17
853	2	2011	2015	13
854	2	2016	2021	4
854	2	2011	2015	4
855	2	2016	2021	23
855	2	2011	2015	23
856	2	2016	2021	33
856	2	2011	2015	32
857	2	2016	2021	53
857	2	2011	2015	53
858	2	2016	2021	64
858	2	2011	2015	43
859	2	2016	2021	5
859	2	2011	2015	7
860	2	2016	2021	6
860	2	2011	2015	7
861	2	2016	2021	15
861	2	2011	2015	9
862	2	2016	2021	34
862	2	2011	2015	31
863	2	2016	2021	19
863	2	2011	2015	15
864	2	2016	2021	11
864	2	2011	2015	15
865	2	2016	2021	5
865	2	2011	2015	5
866	2	2016	2021	2
866	2	2011	2015	4
867	2	2016	2021	13
867	2	2011	2015	8
868	2	2016	2021	17
868	2	2011	2015	15
869	2	2016	2021	51
869	2	2011	2015	42
870	2	2016	2021	12
870	2	2011	2015	18
871	2	2016	2021	5
871	2	2011	2015	4
872	2	2016	2021	2
872	2	2011	2015	3
873	2	2016	2021	19
873	2	2011	2015	11
874	2	2016	2021	4
874	2	2011	2015	9
875	2	2016	2021	12
875	2	2011	2015	13
876	2	2016	2021	22
876	2	2011	2015	17
877	2	2016	2021	16
877	2	2011	2015	16
878	2	2016	2021	18
878	2	2011	2015	8
879	2	2016	2021	18
879	2	2011	2015	18
880	2	2016	2021	27
880	2	2011	2015	18
881	2	2016	2021	35
881	2	2011	2015	49
882	2	2016	2021	42
882	2	2011	2015	48
883	2	2016	2021	144
883	2	2011	2015	103
884	2	2016	2021	5
884	2	2011	2015	2
885	2	2016	2021	2
885	2	2011	2015	4
886	2	2016	2021	66
886	2	2011	2015	62
887	2	2016	2021	11
887	2	2011	2015	8
888	2	2016	2021	42
888	2	2011	2015	43
889	2	2016	2021	4
889	2	2011	2015	1
890	2	2016	2021	13
890	2	2011	2015	25
891	2	2016	2021	3
891	2	2011	2015	4
892	2	2016	2021	158
892	2	2011	2015	133
893	2	2016	2021	191
893	2	2011	2015	194
894	2	2016	2021	3
894	2	2011	2015	3
895	2	2016	2021	14
895	2	2011	2015	8
896	2	2016	2021	24
896	2	2011	2015	14
897	2	2016	2021	9
897	2	2011	2015	7
898	2	2016	2021	18
898	2	2011	2015	22
899	2	2016	2021	18
899	2	2011	2015	27
900	2	2016	2021	25
900	2	2011	2015	19
901	2	2016	2021	33
901	2	2011	2015	11
902	2	2016	2021	60
902	2	2011	2015	58
903	2	2016	2021	2
903	2	2011	2015	4
904	2	2016	2021	4
904	2	2011	2015	11
905	2	2016	2021	49
905	2	2011	2015	48
906	2	2016	2021	9
906	2	2011	2015	7
907	2	2016	2021	2
907	2	2011	2015	4
908	2	2016	2021	1
908	2	2011	2015	0
909	2	2016	2021	3
909	2	2011	2015	3
910	2	2016	2021	6
910	2	2011	2015	4
911	2	2016	2021	13
911	2	2011	2015	6
912	2	2016	2021	35
912	2	2011	2015	36
913	2	2016	2021	47
913	2	2011	2015	48
914	2	2016	2021	1
914	2	2011	2015	2
915	2	2016	2021	8
915	2	2011	2015	15
916	2	2016	2021	4
916	2	2011	2015	5
917	2	2016	2021	36
917	2	2011	2015	40
918	2	2016	2021	10
918	2	2011	2015	6
919	2	2016	2021	68
919	2	2011	2015	46
920	2	2016	2021	66
920	2	2011	2015	74
921	2	2016	2021	9
921	2	2011	2015	8
922	2	2016	2021	3
922	2	2011	2015	1
923	2	2016	2021	2
923	2	2011	2015	1
924	2	2016	2021	18
924	2	2011	2015	24
925	2	2016	2021	13
925	2	2011	2015	21
926	2	2016	2021	88
926	2	2011	2015	73
927	2	2016	2021	2
927	2	2011	2015	5
928	2	2016	2021	6
928	2	2011	2015	19
929	2	2016	2021	6
929	2	2011	2015	5
930	2	2016	2021	0
930	2	2011	2015	2
931	2	2016	2021	2
931	2	2011	2015	2
932	2	2016	2021	27
932	2	2011	2015	23
933	2	2016	2021	3
933	2	2011	2015	8
934	2	2016	2021	17
934	2	2011	2015	14
935	2	2016	2021	14
935	2	2011	2015	8
936	2	2016	2021	31
936	2	2011	2015	27
937	2	2016	2021	23
937	2	2011	2015	25
938	2	2016	2021	3
938	2	2011	2015	5
939	2	2016	2021	11
939	2	2011	2015	10
940	2	2016	2021	86
940	2	2011	2015	60
941	2	2016	2021	4
941	2	2011	2015	7
942	2	2016	2021	409
942	2	2011	2015	380
943	2	2016	2021	74
943	2	2011	2015	74
944	2	2016	2021	28
944	2	2011	2015	25
945	2	2016	2021	3
945	2	2011	2015	5
946	2	2016	2021	10
946	2	2011	2015	14
947	2	2016	2021	28
947	2	2011	2015	34
948	2	2016	2021	22
948	2	2011	2015	26
949	2	2016	2021	14
949	2	2011	2015	6
950	2	2016	2021	3
950	2	2011	2015	8
951	2	2016	2021	4
951	2	2011	2015	7
952	2	2016	2021	23
952	2	2011	2015	23
953	2	2016	2021	10
953	2	2011	2015	16
954	2	2016	2021	126
954	2	2011	2015	117
955	2	2016	2021	5
955	2	2011	2015	4
956	2	2016	2021	49
956	2	2011	2015	42
957	2	2016	2021	2
957	2	2011	2015	0
958	2	2016	2021	15
958	2	2011	2015	19
959	2	2016	2021	12
959	2	2011	2015	15
960	2	2016	2021	2
960	2	2011	2015	2
961	2	2016	2021	27
961	2	2011	2015	44
962	2	2016	2021	9
962	2	2011	2015	8
963	2	2016	2021	12
963	2	2011	2015	11
964	2	2016	2021	87
964	2	2011	2015	84
965	2	2016	2021	33
965	2	2011	2015	26
966	2	2016	2021	59
966	2	2011	2015	52
967	2	2016	2021	7
967	2	2011	2015	10
968	2	2016	2021	17
968	2	2011	2015	20
969	2	2016	2021	47
969	2	2011	2015	40
970	2	2016	2021	31
970	2	2011	2015	21
971	2	2016	2021	144
971	2	2011	2015	129
972	2	2016	2021	16
972	2	2011	2015	8
973	2	2016	2021	11
973	2	2011	2015	16
974	2	2016	2021	3
974	2	2011	2015	11
975	2	2016	2021	16
975	2	2011	2015	8
976	2	2016	2021	7
976	2	2011	2015	1
977	2	2016	2021	1
977	2	2011	2015	7
978	2	2016	2021	8
978	2	2011	2015	2
979	2	2016	2021	17
979	2	2011	2015	19
980	2	2016	2021	86
980	2	2011	2015	64
981	2	2016	2021	28
981	2	2011	2015	11
982	2	2016	2021	32
982	2	2011	2015	17
983	2	2016	2021	3
983	2	2011	2015	4
984	2	2016	2021	3
984	2	2011	2015	2
985	2	2016	2021	0
985	2	2011	2015	3
986	2	2016	2021	0
986	2	2011	2015	1
987	2	2016	2021	6
987	2	2011	2015	11
988	2	2016	2021	12
988	2	2011	2015	6
989	2	2016	2021	8
989	2	2011	2015	8
990	2	2016	2021	0
990	2	2011	2015	1
991	2	2016	2021	5
991	2	2011	2015	12
992	2	2016	2021	1
992	2	2011	2015	0
993	2	2016	2021	4
993	2	2011	2015	8
994	2	2016	2021	44
994	2	2011	2015	37
995	2	2016	2021	13
995	2	2011	2015	6
996	2	2016	2021	75
996	2	2011	2015	67
997	2	2016	2021	10
997	2	2011	2015	9
998	2	2016	2021	38
998	2	2011	2015	40
999	2	2016	2021	12
999	2	2011	2015	23
1000	2	2016	2021	30
1000	2	2011	2015	22
1001	2	2016	2021	6
1001	2	2011	2015	2
1002	2	2016	2021	6
1002	2	2011	2015	7
1003	2	2016	2021	21
1003	2	2011	2015	22
1004	2	2016	2021	31
1004	2	2011	2015	15
1005	2	2016	2021	1
1005	2	2011	2015	2
1006	2	2016	2021	8
1006	2	2011	2015	7
1007	2	2016	2021	42
1007	2	2011	2015	26
1008	2	2016	2021	20
1008	2	2011	2015	18
1009	2	2016	2021	6
1009	2	2011	2015	2
1010	2	2016	2021	92
1010	2	2011	2015	67
1011	2	2016	2021	20
1011	2	2011	2015	22
1012	2	2016	2021	12
1012	2	2011	2015	24
1013	2	2016	2021	5
1013	2	2011	2015	1
1014	2	2016	2021	10
1014	2	2011	2015	13
1015	2	2016	2021	4
1015	2	2011	2015	4
1016	2	2016	2021	31
1016	2	2011	2015	14
1017	2	2016	2021	112
1017	2	2011	2015	99
1018	2	2016	2021	57
1018	2	2011	2015	66
1019	2	2016	2021	14
1019	2	2011	2015	11
1020	2	2016	2021	4
1020	2	2011	2015	2
1021	2	2016	2021	2
1021	2	2011	2015	6
1022	2	2016	2021	62
1022	2	2011	2015	59
1023	2	2016	2021	6
1023	2	2011	2015	9
1024	2	2016	2021	5
1024	2	2011	2015	4
1025	2	2016	2021	2
1025	2	2011	2015	2
1026	2	2016	2021	53
1026	2	2011	2015	50
1027	2	2016	2021	3
1027	2	2011	2015	4
1028	2	2016	2021	25
1028	2	2011	2015	21
1029	2	2016	2021	15
1029	2	2011	2015	16
1030	2	2016	2021	5
1030	2	2011	2015	3
1031	2	2016	2021	6
1031	2	2011	2015	5
1032	2	2016	2021	9
1032	2	2011	2015	7
1033	2	2016	2021	4
1033	2	2011	2015	6
1034	2	2016	2021	20
1034	2	2011	2015	15
1035	2	2016	2021	9
1035	2	2011	2015	3
1036	2	2016	2021	13
1036	2	2011	2015	10
1037	2	2016	2021	7
1037	2	2011	2015	7
1038	2	2016	2021	2
1038	2	2011	2015	5
1039	2	2016	2021	73
1039	2	2011	2015	65
1040	2	2016	2021	2
1040	2	2011	2015	2
1041	2	2016	2021	258
1041	2	2011	2015	224
1042	2	2016	2021	5
1042	2	2011	2015	4
1043	2	2016	2021	6
1043	2	2011	2015	6
1044	2	2016	2021	10
1044	2	2011	2015	13
1045	2	2016	2021	28
1045	2	2011	2015	22
1046	2	2016	2021	3
1046	2	2011	2015	8
1047	2	2016	2021	44
1047	2	2011	2015	28
1048	2	2016	2021	25
1048	2	2011	2015	30
1049	2	2016	2021	14
1049	2	2011	2015	11
1050	2	2016	2021	15
1050	2	2011	2015	9
1051	2	2016	2021	12
1051	2	2011	2015	10
1052	2	2016	2021	17
1052	2	2011	2015	17
1053	2	2016	2021	16
1053	2	2011	2015	20
1054	2	2016	2021	34
1054	2	2011	2015	33
1055	2	2016	2021	4
1055	2	2011	2015	4
1056	2	2016	2021	0
1056	2	2011	2015	2
1057	2	2016	2021	111
1057	2	2011	2015	86
1058	2	2016	2021	15
1058	2	2011	2015	9
1059	2	2016	2021	63
1059	2	2011	2015	62
1060	2	2016	2021	13
1060	2	2011	2015	9
1061	2	2016	2021	25
1061	2	2011	2015	27
1062	2	2016	2021	9
1062	2	2011	2015	14
1063	2	2016	2021	34
1063	2	2011	2015	30
1064	2	2016	2021	9
1064	2	2011	2015	8
1065	2	2016	2021	4
1065	2	2011	2015	2
1066	2	2016	2021	67
1066	2	2011	2015	67
1067	2	2016	2021	7
1067	2	2011	2015	15
1068	2	2016	2021	10
1068	2	2011	2015	12
1069	2	2016	2021	18
1069	2	2011	2015	20
1070	2	2016	2021	11
1070	2	2011	2015	6
1071	2	2016	2021	11
1071	2	2011	2015	6
1072	2	2016	2021	21
1072	2	2011	2015	21
1073	2	2016	2021	4
1073	2	2011	2015	3
1074	2	2016	2021	17
1074	2	2011	2015	19
1075	2	2016	2021	14
1075	2	2011	2015	10
1076	2	2016	2021	10
1076	2	2011	2015	12
1077	2	2016	2021	3
1077	2	2011	2015	3
1078	2	2016	2021	0
1078	2	2011	2015	0
1079	2	2016	2021	40
1079	2	2011	2015	28
1080	2	2016	2021	18
1080	2	2011	2015	16
1081	2	2016	2021	11
1081	2	2011	2015	6
1082	2	2016	2021	721
1082	2	2011	2015	619
1083	2	2016	2021	41
1083	2	2011	2015	34
1084	2	2016	2021	229
1084	2	2011	2015	194
1085	2	2016	2021	504
1085	2	2011	2015	482
1086	2	2016	2021	114
1086	2	2011	2015	98
1087	2	2016	2021	8
1087	2	2011	2015	5
1088	2	2016	2021	106
1088	2	2011	2015	116
1089	2	2016	2021	26
1089	2	2011	2015	24
1090	2	2016	2021	6
1090	2	2011	2015	9
1091	2	2016	2021	5
1091	2	2011	2015	1
1092	2	2016	2021	4
1092	2	2011	2015	2
1093	2	2016	2021	2
1093	2	2011	2015	2
1094	2	2016	2021	62
1094	2	2011	2015	51
1095	2	2016	2021	30
1095	2	2011	2015	26
1096	2	2016	2021	9
1096	2	2011	2015	14
1097	2	2016	2021	54
1097	2	2011	2015	46
1098	2	2016	2021	34
1098	2	2011	2015	33
1099	2	2016	2021	63
1099	2	2011	2015	47
1100	2	2016	2021	44
1100	2	2011	2015	38
1101	2	2016	2021	5
1101	2	2011	2015	7
1102	2	2016	2021	40
1102	2	2011	2015	36
1103	2	2016	2021	4
1103	2	2011	2015	2
1104	2	2016	2021	8
1104	2	2011	2015	8
1105	2	2016	2021	5
1105	2	2011	2015	3
1106	2	2016	2021	135
1106	2	2011	2015	136
1107	2	2016	2021	1
1107	2	2011	2015	8
1108	2	2016	2021	8
1108	2	2011	2015	2
1109	2	2016	2021	12
1109	2	2011	2015	6
1110	2	2016	2021	3
1110	2	2011	2015	1
1111	2	2016	2021	45
1111	2	2011	2015	36
1112	2	2016	2021	4
1112	2	2011	2015	2
1113	2	2016	2021	19
1113	2	2011	2015	17
1114	2	2016	2021	3
1114	2	2011	2015	3
1115	2	2016	2021	8
1115	2	2011	2015	4
1116	2	2016	2021	3
1116	2	2011	2015	5
1117	2	2016	2021	1
1117	2	2011	2015	2
1118	2	2016	2021	8
1118	2	2011	2015	10
1119	2	2016	2021	21
1119	2	2011	2015	25
1120	2	2016	2021	10
1120	2	2011	2015	14
1121	2	2016	2021	24
1121	2	2011	2015	25
1122	2	2016	2021	51
1122	2	2011	2015	56
1123	2	2016	2021	13
1123	2	2011	2015	11
1124	2	2016	2021	10
1124	2	2011	2015	8
1125	2	2016	2021	9
1125	2	2011	2015	7
1126	2	2016	2021	10
1126	2	2011	2015	12
1127	2	2016	2021	115
1127	2	2011	2015	120
1128	2	2016	2021	42
1128	2	2011	2015	31
1129	2	2016	2021	17
1129	2	2011	2015	25
1130	2	2016	2021	29
1130	2	2011	2015	20
1131	2	2016	2021	1
1131	2	2011	2015	1
1132	2	2016	2021	42
1132	2	2011	2015	33
1133	2	2016	2021	42
1133	2	2011	2015	34
1134	2	2016	2021	2
1134	2	2011	2015	2
1135	2	2016	2021	4
1135	2	2011	2015	13
1136	2	2016	2021	12
1136	2	2011	2015	13
1137	2	2016	2021	7
1137	2	2011	2015	7
1138	2	2016	2021	3
1138	2	2011	2015	5
1139	2	2016	2021	8
1139	2	2011	2015	4
1140	2	2016	2021	2
1140	2	2011	2015	4
1141	2	2016	2021	0
1141	2	2011	2015	0
1142	2	2016	2021	29
1142	2	2011	2015	23
1143	2	2016	2021	1
1143	2	2011	2015	7
1144	2	2016	2021	9
1144	2	2011	2015	10
1145	2	2016	2021	21
1145	2	2011	2015	22
1146	2	2016	2021	7
1146	2	2011	2015	12
1147	2	2016	2021	4
1147	2	2011	2015	3
1148	2	2016	2021	5
1148	2	2011	2015	4
1149	2	2016	2021	30
1149	2	2011	2015	21
1150	2	2016	2021	1
1150	2	2011	2015	5
1151	2	2016	2021	8
1151	2	2011	2015	5
1152	2	2016	2021	2
1152	2	2011	2015	1
1153	2	2016	2021	7
1153	2	2011	2015	6
1154	2	2016	2021	24
1154	2	2011	2015	14
1155	2	2016	2021	3
1155	2	2011	2015	6
1156	2	2016	2021	2
1156	2	2011	2015	1
1157	2	2016	2021	8
1157	2	2011	2015	4
1158	2	2016	2021	33
1158	2	2011	2015	35
1159	2	2016	2021	20
1159	2	2011	2015	15
1160	2	2016	2021	6
1160	2	2011	2015	6
1161	2	2016	2021	12
1161	2	2011	2015	20
1162	2	2016	2021	14
1162	2	2011	2015	9
1163	2	2016	2021	8
1163	2	2011	2015	11
1164	2	2016	2021	30
1164	2	2011	2015	36
1165	2	2016	2021	23
1165	2	2011	2015	30
1166	2	2016	2021	15
1166	2	2011	2015	6
1167	2	2016	2021	14
1167	2	2011	2015	7
1168	2	2016	2021	12
1168	2	2011	2015	7
1169	2	2016	2021	10
1169	2	2011	2015	6
1170	2	2016	2021	12
1170	2	2011	2015	13
1171	2	2016	2021	4
1171	2	2011	2015	5
1172	2	2016	2021	30
1172	2	2011	2015	26
1173	2	2016	2021	31
1173	2	2011	2015	45
1174	2	2016	2021	22
1174	2	2011	2015	26
1175	2	2016	2021	12
1175	2	2011	2015	18
1176	2	2016	2021	53
1176	2	2011	2015	35
1177	2	2016	2021	7
1177	2	2011	2015	6
1178	2	2016	2021	4
1178	2	2011	2015	8
1179	2	2016	2021	7
1179	2	2011	2015	12
1180	2	2016	2021	11
1180	2	2011	2015	10
1181	2	2016	2021	2
1181	2	2011	2015	4
1182	2	2016	2021	7
1182	2	2011	2015	9
1183	2	2016	2021	5
1183	2	2011	2015	10
1184	2	2016	2021	6
1184	2	2011	2015	7
1185	2	2016	2021	32
1185	2	2011	2015	32
1186	2	2016	2021	18
1186	2	2011	2015	24
1187	2	2016	2021	6
1187	2	2011	2015	8
1188	2	2016	2021	37
1188	2	2011	2015	27
1189	2	2016	2021	72
1189	2	2011	2015	65
1190	2	2016	2021	50
1190	2	2011	2015	59
1191	2	2016	2021	691
1191	2	2011	2015	655
1192	2	2016	2021	11
1192	2	2011	2015	14
1193	2	2016	2021	1
1193	2	2011	2015	5
1194	2	2016	2021	3
1194	2	2011	2015	7
1195	2	2016	2021	24
1195	2	2011	2015	21
1196	2	2016	2021	17
1196	2	2011	2015	14
1197	2	2016	2021	33
1197	2	2011	2015	17
1198	2	2016	2021	6
1198	2	2011	2015	10
1199	2	2016	2021	6
1199	2	2011	2015	4
1200	2	2016	2021	24
1200	2	2011	2015	32
1201	2	2016	2021	15
1201	2	2011	2015	17
1202	2	2016	2021	5
1202	2	2011	2015	0
1203	2	2016	2021	3
1203	2	2011	2015	5
1204	2	2016	2021	6
1204	2	2011	2015	5
1205	2	2016	2021	3
1205	2	2011	2015	6
1206	2	2016	2021	18
1206	2	2011	2015	7
1207	2	2016	2021	19
1207	2	2011	2015	13
1208	2	2016	2021	14
1208	2	2011	2015	10
1209	2	2016	2021	17
1209	2	2011	2015	17
1210	2	2016	2021	7
1210	2	2011	2015	16
1211	2	2016	2021	9
1211	2	2011	2015	22
1212	2	2016	2021	12
1212	2	2011	2015	11
1213	2	2016	2021	6
1213	2	2011	2015	4
1214	2	2016	2021	2
1214	2	2011	2015	1
1215	2	2016	2021	4
1215	2	2011	2015	3
1216	2	2016	2021	3
1216	2	2011	2015	0
1217	2	2016	2021	7
1217	2	2011	2015	5
1218	2	2016	2021	22
1218	2	2011	2015	24
1219	2	2016	2021	3
1219	2	2011	2015	3
1220	2	2016	2021	7
1220	2	2011	2015	12
1221	2	2016	2021	4
1221	2	2011	2015	4
1222	2	2016	2021	3
1222	2	2011	2015	4
1223	2	2016	2021	11
1223	2	2011	2015	22
1224	2	2016	2021	19
1224	2	2011	2015	16
1225	2	2016	2021	18
1225	2	2011	2015	13
1226	2	2016	2021	19
1226	2	2011	2015	20
1227	2	2016	2021	9
1227	2	2011	2015	8
1228	2	2016	2021	6
1228	2	2011	2015	11
1229	2	2016	2021	21
1229	2	2011	2015	19
1230	2	2016	2021	3
1230	2	2011	2015	9
1231	2	2016	2021	14
1231	2	2011	2015	11
1232	2	2016	2021	18
1232	2	2011	2015	21
1233	2	2016	2021	24
1233	2	2011	2015	29
1234	2	2016	2021	12
1234	2	2011	2015	8
1235	2	2016	2021	24
1235	2	2011	2015	16
1236	2	2016	2021	6
1236	2	2011	2015	5
1237	2	2016	2021	10
1237	2	2011	2015	18
1238	2	2016	2021	9
1238	2	2011	2015	5
1239	2	2016	2021	2
1239	2	2011	2015	4
1240	2	2016	2021	5
1240	2	2011	2015	6
1241	2	2016	2021	60
1241	2	2011	2015	29
1242	2	2016	2021	10
1242	2	2011	2015	10
1243	2	2016	2021	11
1243	2	2011	2015	16
1244	2	2016	2021	0
1244	2	2011	2015	3
1245	2	2016	2021	35
1245	2	2011	2015	40
1246	2	2016	2021	16
1246	2	2011	2015	14
1247	2	2016	2021	3
1247	2	2011	2015	4
1248	2	2016	2021	3
1248	2	2011	2015	3
1249	2	2016	2021	4
1249	2	2011	2015	6
1250	2	2016	2021	4
1250	2	2011	2015	5
1251	2	2016	2021	17
1251	2	2011	2015	9
1252	2	2016	2021	18
1252	2	2011	2015	20
1253	2	2016	2021	19
1253	2	2011	2015	22
1254	2	2016	2021	15
1254	2	2011	2015	21
1255	2	2016	2021	6
1255	2	2011	2015	3
1256	2	2016	2021	16
1256	2	2011	2015	17
1257	2	2016	2021	38
1257	2	2011	2015	36
1258	2	2016	2021	43
1258	2	2011	2015	29
1259	2	2016	2021	12
1259	2	2011	2015	10
1260	2	2016	2021	2
1260	2	2011	2015	2
1261	2	2016	2021	5
1261	2	2011	2015	2
1262	2	2016	2021	6
1262	2	2011	2015	6
1263	2	2016	2021	23
1263	2	2011	2015	28
1264	2	2016	2021	7
1264	2	2011	2015	7
1265	2	2016	2021	185
1265	2	2011	2015	168
1266	2	2016	2021	43
1266	2	2011	2015	30
1267	2	2016	2021	5
1267	2	2011	2015	8
1268	2	2016	2021	13
1268	2	2011	2015	12
1269	2	2016	2021	20
1269	2	2011	2015	17
1270	2	2016	2021	5
1270	2	2011	2015	2
1271	2	2016	2021	8
1271	2	2011	2015	11
1272	2	2016	2021	8
1272	2	2011	2015	5
1273	2	2016	2021	3
1273	2	2011	2015	4
1274	2	2016	2021	8
1274	2	2011	2015	14
1275	2	2016	2021	10
1275	2	2011	2015	5
1276	2	2016	2021	5
1276	2	2011	2015	9
1277	2	2016	2021	6
1277	2	2011	2015	5
1278	2	2016	2021	40
1278	2	2011	2015	40
1279	2	2016	2021	3
1279	2	2011	2015	8
1280	2	2016	2021	9
1280	2	2011	2015	18
1281	2	2016	2021	48
1281	2	2011	2015	49
1282	2	2016	2021	126
1282	2	2011	2015	111
1283	2	2016	2021	0
1283	2	2011	2015	5
1284	2	2016	2021	58
1284	2	2011	2015	50
1285	2	2016	2021	16
1285	2	2011	2015	19
1286	2	2016	2021	14
1286	2	2011	2015	13
1287	2	2016	2021	0
1287	2	2011	2015	2
1288	2	2016	2021	13
1288	2	2011	2015	12
1289	2	2016	2021	5
1289	2	2011	2015	9
1290	2	2016	2021	14
1290	2	2011	2015	6
1291	2	2016	2021	12
1291	2	2011	2015	9
1292	2	2016	2021	8
1292	2	2011	2015	7
1293	2	2016	2021	8
1293	2	2011	2015	6
1294	2	2016	2021	5
1294	2	2011	2015	9
1295	2	2016	2021	40
1295	2	2011	2015	41
1296	2	2016	2021	7
1296	2	2011	2015	10
1297	2	2016	2021	17
1297	2	2011	2015	18
1298	2	2016	2021	12
1298	2	2011	2015	3
1299	2	2016	2021	11
1299	2	2011	2015	6
1300	2	2016	2021	11
1300	2	2011	2015	22
1301	2	2016	2021	2
1301	2	2011	2015	3
1302	2	2016	2021	8
1302	2	2011	2015	9
1303	2	2016	2021	13
1303	2	2011	2015	10
1304	2	2016	2021	10
1304	2	2011	2015	9
1305	2	2016	2021	1
1305	2	2011	2015	2
1306	2	2016	2021	12
1306	2	2011	2015	12
1307	2	2016	2021	2
1307	2	2011	2015	4
1308	2	2016	2021	56
1308	2	2011	2015	77
1309	2	2016	2021	14
1309	2	2011	2015	21
1310	2	2016	2021	1
1310	2	2011	2015	4
1311	2	2016	2021	5
1311	2	2011	2015	6
1312	2	2016	2021	7
1312	2	2011	2015	8
1313	2	2016	2021	1
1313	2	2011	2015	5
1314	2	2016	2021	4
1314	2	2011	2015	3
1315	2	2016	2021	4
1315	2	2011	2015	6
1316	2	2016	2021	4
1316	2	2011	2015	3
1317	2	2016	2021	10
1317	2	2011	2015	9
1318	2	2016	2021	17
1318	2	2011	2015	16
1319	2	2016	2021	6
1319	2	2011	2015	9
1320	2	2016	2021	4
1320	2	2011	2015	6
1321	2	2016	2021	3
1321	2	2011	2015	4
1322	2	2016	2021	11
1322	2	2011	2015	7
1323	2	2016	2021	36
1323	2	2011	2015	28
1324	2	2016	2021	12
1324	2	2011	2015	11
1325	2	2016	2021	4
1325	2	2011	2015	1
1326	2	2016	2021	18
1326	2	2011	2015	13
1327	2	2016	2021	24
1327	2	2011	2015	18
1328	2	2016	2021	13
1328	2	2011	2015	14
1329	2	2016	2021	8
1329	2	2011	2015	6
1330	2	2016	2021	12
1330	2	2011	2015	11
1331	2	2016	2021	8
1331	2	2011	2015	8
1332	2	2016	2021	12
1332	2	2011	2015	24
1333	2	2016	2021	90
1333	2	2011	2015	94
1334	2	2016	2021	17
1334	2	2011	2015	8
1335	2	2016	2021	67
1335	2	2011	2015	72
1336	2	2016	2021	31
1336	2	2011	2015	22
1337	2	2016	2021	9
1337	2	2011	2015	5
1338	2	2016	2021	14
1338	2	2011	2015	12
1339	2	2016	2021	3
1339	2	2011	2015	4
1340	2	2016	2021	3
1340	2	2011	2015	6
1341	2	2016	2021	7
1341	2	2011	2015	1
1342	2	2016	2021	9
1342	2	2011	2015	9
1343	2	2016	2021	7
1343	2	2011	2015	1
1344	2	2016	2021	23
1344	2	2011	2015	21
1345	2	2016	2021	20
1345	2	2011	2015	16
1346	2	2016	2021	5
1346	2	2011	2015	3
1347	2	2016	2021	7
1347	2	2011	2015	5
1348	2	2016	2021	12
1348	2	2011	2015	15
1349	2	2016	2021	9
1349	2	2011	2015	4
1350	2	2016	2021	13
1350	2	2011	2015	18
1351	2	2016	2021	1
1351	2	2011	2015	0
1352	2	2016	2021	0
1352	2	2011	2015	0
1353	2	2016	2021	4
1353	2	2011	2015	5
1354	2	2016	2021	15
1354	2	2011	2015	19
1355	2	2016	2021	84
1355	2	2011	2015	98
1356	2	2016	2021	4
1356	2	2011	2015	15
1357	2	2016	2021	20
1357	2	2011	2015	7
1358	2	2016	2021	7
1358	2	2011	2015	5
1359	2	2016	2021	18
1359	2	2011	2015	13
1360	2	2016	2021	28
1360	2	2011	2015	27
1361	2	2016	2021	5
1361	2	2011	2015	9
1362	2	2016	2021	57
1362	2	2011	2015	65
1363	2	2016	2021	63
1363	2	2011	2015	47
1364	2	2016	2021	20
1364	2	2011	2015	20
1365	2	2016	2021	24
1365	2	2011	2015	30
1366	2	2016	2021	12
1366	2	2011	2015	11
1367	2	2016	2021	28
1367	2	2011	2015	32
1368	2	2016	2021	16
1368	2	2011	2015	9
1369	2	2016	2021	14
1369	2	2011	2015	23
1370	2	2016	2021	32
1370	2	2011	2015	35
1371	2	2016	2021	13
1371	2	2011	2015	9
1372	2	2016	2021	9
1372	2	2011	2015	15
1373	2	2016	2021	7
1373	2	2011	2015	10
1374	2	2016	2021	3
1374	2	2011	2015	0
1375	2	2016	2021	9
1375	2	2011	2015	10
1376	2	2016	2021	251
1376	2	2011	2015	204
1377	2	2016	2021	18
1377	2	2011	2015	18
1378	2	2016	2021	81
1378	2	2011	2015	58
1379	2	2016	2021	16
1379	2	2011	2015	17
1380	2	2016	2021	28
1380	2	2011	2015	20
1381	2	2016	2021	16
1381	2	2011	2015	11
1382	2	2016	2021	14
1382	2	2011	2015	15
1383	2	2016	2021	12
1383	2	2011	2015	8
1384	2	2016	2021	44
1384	2	2011	2015	57
1385	2	2016	2021	6
1385	2	2011	2015	4
1386	2	2016	2021	1332
1386	2	2011	2015	1391
1387	2	2016	2021	22
1387	2	2011	2015	25
1388	2	2016	2021	6
1388	2	2011	2015	3
1389	2	2016	2021	15
1389	2	2011	2015	10
1390	2	2016	2021	44
1390	2	2011	2015	56
1391	2	2016	2021	1
1391	2	2011	2015	6
1392	2	2016	2021	5
1392	2	2011	2015	9
1393	2	2016	2021	6
1393	2	2011	2015	3
1394	2	2016	2021	16
1394	2	2011	2015	13
1395	2	2016	2021	10
1395	2	2011	2015	21
1396	2	2016	2021	12
1396	2	2011	2015	9
1397	2	2016	2021	3
1397	2	2011	2015	3
1398	2	2016	2021	532
1398	2	2011	2015	440
1399	2	2016	2021	29
1399	2	2011	2015	31
1400	2	2016	2021	34
1400	2	2011	2015	23
1401	2	2016	2021	7
1401	2	2011	2015	6
1402	2	2016	2021	2
1402	2	2011	2015	0
1403	2	2016	2021	12
1403	2	2011	2015	11
1404	2	2016	2021	16
1404	2	2011	2015	14
1405	2	2016	2021	2
1405	2	2011	2015	2
1406	2	2016	2021	12
1406	2	2011	2015	8
1407	2	2016	2021	5
1407	2	2011	2015	14
1408	2	2016	2021	4
1408	2	2011	2015	7
1409	2	2016	2021	163
1409	2	2011	2015	130
1410	2	2016	2021	13
1410	2	2011	2015	8
1411	2	2016	2021	110
1411	2	2011	2015	106
1412	2	2016	2021	48
1412	2	2011	2015	62
1413	2	2016	2021	16
1413	2	2011	2015	22
1414	2	2016	2021	14
1414	2	2011	2015	22
1415	2	2016	2021	17
1415	2	2011	2015	7
1416	2	2016	2021	14
1416	2	2011	2015	15
1417	2	2016	2021	32
1417	2	2011	2015	11
1418	2	2016	2021	9
1418	2	2011	2015	7
1419	2	2016	2021	16
1419	2	2011	2015	16
1420	2	2016	2021	21
1420	2	2011	2015	12
1421	2	2016	2021	15
1421	2	2011	2015	13
1422	2	2016	2021	21
1422	2	2011	2015	21
1423	2	2016	2021	56
1423	2	2011	2015	54
1424	2	2016	2021	10
1424	2	2011	2015	11
1425	2	2016	2021	3
1425	2	2011	2015	3
1426	2	2016	2021	5
1426	2	2011	2015	6
1427	2	2016	2021	26
1427	2	2011	2015	12
1428	2	2016	2021	26
1428	2	2011	2015	32
1429	2	2016	2021	21
1429	2	2011	2015	17
1430	2	2016	2021	28
1430	2	2011	2015	26
1431	2	2016	2021	50
1431	2	2011	2015	40
1432	2	2016	2021	24
1432	2	2011	2015	22
1433	2	2016	2021	15
1433	2	2011	2015	14
1434	2	2016	2021	32
1434	2	2011	2015	24
1435	2	2016	2021	11
1435	2	2011	2015	6
1436	2	2016	2021	117
1436	2	2011	2015	123
1437	2	2016	2021	20
1437	2	2011	2015	13
1438	2	2016	2021	6
1438	2	2011	2015	12
1439	2	2016	2021	184
1439	2	2011	2015	190
1440	2	2016	2021	35
1440	2	2011	2015	39
1441	2	2016	2021	7
1441	2	2011	2015	4
1442	2	2016	2021	15
1442	2	2011	2015	20
1443	2	2016	2021	14
1443	2	2011	2015	15
1444	2	2016	2021	48
1444	2	2011	2015	54
1445	2	2016	2021	5
1445	2	2011	2015	2
1446	2	2016	2021	0
1446	2	2011	2015	2
1447	2	2016	2021	2
1447	2	2011	2015	3
1448	2	2016	2021	1
1448	2	2011	2015	0
1449	2	2016	2021	4
1449	2	2011	2015	0
1450	2	2016	2021	132
1450	2	2011	2015	108
1451	2	2016	2021	8
1451	2	2011	2015	9
1452	2	2016	2021	38
1452	2	2011	2015	35
1453	2	2016	2021	2
1453	2	2011	2015	5
1454	2	2016	2021	10
1454	2	2011	2015	17
1455	2	2016	2021	1
1455	2	2011	2015	1
1456	2	2016	2021	4
1456	2	2011	2015	3
1457	2	2016	2021	2
1457	2	2011	2015	4
1458	2	2016	2021	9
1458	2	2011	2015	11
1459	2	2016	2021	16
1459	2	2011	2015	17
1460	2	2016	2021	8
1460	2	2011	2015	1
1461	2	2016	2021	12
1461	2	2011	2015	23
1462	2	2016	2021	32
1462	2	2011	2015	45
1463	2	2016	2021	2
1463	2	2011	2015	1
1464	2	2016	2021	7
1464	2	2011	2015	17
1465	2	2016	2021	43
1465	2	2011	2015	32
1466	2	2016	2021	19
1466	2	2011	2015	26
1467	2	2016	2021	30
1467	2	2011	2015	22
1468	2	2016	2021	5
1468	2	2011	2015	2
1469	2	2016	2021	35
1469	2	2011	2015	26
1470	2	2016	2021	504
1470	2	2011	2015	444
1471	2	2016	2021	133
1471	2	2011	2015	105
1472	2	2016	2021	60
1472	2	2011	2015	73
1473	2	2016	2021	6
1473	2	2011	2015	6
1474	2	2016	2021	36
1474	2	2011	2015	46
1475	2	2016	2021	23
1475	2	2011	2015	24
1476	2	2016	2021	2
1476	2	2011	2015	1
1477	2	2016	2021	89
1477	2	2011	2015	90
1478	2	2016	2021	11
1478	2	2011	2015	14
1479	2	2016	2021	45
1479	2	2011	2015	35
1480	2	2016	2021	12
1480	2	2011	2015	13
1481	2	2016	2021	13
1481	2	2011	2015	15
1482	2	2016	2021	0
1482	2	2011	2015	4
1483	2	2016	2021	30
1483	2	2011	2015	36
1484	2	2016	2021	19
1484	2	2011	2015	8
1485	2	2016	2021	13
1485	2	2011	2015	20
1486	2	2016	2021	28
1486	2	2011	2015	21
1487	2	2016	2021	55
1487	2	2011	2015	49
1488	2	2016	2021	41
1488	2	2011	2015	30
1489	2	2016	2021	18
1489	2	2011	2015	9
1490	2	2016	2021	20
1490	2	2011	2015	10
1491	2	2016	2021	23
1491	2	2011	2015	28
1492	2	2016	2021	5
1492	2	2011	2015	9
1493	2	2016	2021	10
1493	2	2011	2015	15
1494	2	2016	2021	9
1494	2	2011	2015	6
1495	2	2016	2021	37
1495	2	2011	2015	28
1496	2	2016	2021	15
1496	2	2011	2015	19
1497	2	2016	2021	94
1497	2	2011	2015	96
1498	2	2016	2021	13
1498	2	2011	2015	10
1499	2	2016	2021	25
1499	2	2011	2015	14
1500	2	2016	2021	50
1500	2	2011	2015	39
1501	2	2016	2021	4
1501	2	2011	2015	0
1502	2	2016	2021	14
1502	2	2011	2015	8
1503	2	2016	2021	1
1503	2	2011	2015	1
1504	2	2016	2021	24
1504	2	2011	2015	25
1505	2	2016	2021	44
1505	2	2011	2015	28
1506	2	2016	2021	16
1506	2	2011	2015	13
1507	2	2016	2021	65
1507	2	2011	2015	60
1508	2	2016	2021	9
1508	2	2011	2015	9
1509	2	2016	2021	6
1509	2	2011	2015	4
1510	2	2016	2021	21
1510	2	2011	2015	15
1511	2	2016	2021	29
1511	2	2011	2015	24
1512	2	2016	2021	17
1512	2	2011	2015	20
1513	2	2016	2021	21
1513	2	2011	2015	12
1514	2	2016	2021	8
1514	2	2011	2015	9
1515	2	2016	2021	5
1515	2	2011	2015	3
1516	2	2016	2021	27
1516	2	2011	2015	18
1517	2	2016	2021	66
1517	2	2011	2015	94
1518	2	2016	2021	6
1518	2	2011	2015	5
1519	2	2016	2021	11
1519	2	2011	2015	7
1520	2	2016	2021	41
1520	2	2011	2015	18
1521	2	2016	2021	10
1521	2	2011	2015	9
1522	2	2016	2021	25
1522	2	2011	2015	21
1523	2	2016	2021	2
1523	2	2011	2015	2
1524	2	2016	2021	34
1524	2	2011	2015	26
1525	2	2016	2021	1
1525	2	2011	2015	6
1526	2	2016	2021	30
1526	2	2011	2015	21
1527	2	2016	2021	17
1527	2	2011	2015	19
1528	2	2016	2021	3
1528	2	2011	2015	8
1529	2	2016	2021	18
1529	2	2011	2015	30
1530	2	2016	2021	28
1530	2	2011	2015	17
1531	2	2016	2021	31
1531	2	2011	2015	27
1532	2	2016	2021	13
1532	2	2011	2015	8
1533	2	2016	2021	33
1533	2	2011	2015	34
1534	2	2016	2021	7
1534	2	2011	2015	6
1535	2	2016	2021	3
1535	2	2011	2015	6
1536	2	2016	2021	21
1536	2	2011	2015	22
1537	2	2016	2021	32
1537	2	2011	2015	54
1538	2	2016	2021	41
1538	2	2011	2015	30
1539	2	2016	2021	2
1539	2	2011	2015	4
1540	2	2016	2021	114
1540	2	2011	2015	97
1541	2	2016	2021	91
1541	2	2011	2015	81
1542	2	2016	2021	41
1542	2	2011	2015	39
1543	2	2016	2021	161
1543	2	2011	2015	138
1544	2	2016	2021	64
1544	2	2011	2015	58
1545	2	2016	2021	32
1545	2	2011	2015	27
1546	2	2016	2021	11
1546	2	2011	2015	14
1547	2	2016	2021	85
1547	2	2011	2015	73
1548	2	2016	2021	8
1548	2	2011	2015	8
1549	2	2016	2021	3
1549	2	2011	2015	3
1550	2	2016	2021	2
1550	2	2011	2015	1
1551	2	2016	2021	26
1551	2	2011	2015	15
1552	2	2016	2021	50
1552	2	2011	2015	49
1553	2	2016	2021	60
1553	2	2011	2015	54
1554	2	2016	2021	6
1554	2	2011	2015	5
1555	2	2016	2021	11
1555	2	2011	2015	14
1556	2	2016	2021	17
1556	2	2011	2015	21
1557	2	2016	2021	10
1557	2	2011	2015	2
1558	2	2016	2021	64
1558	2	2011	2015	38
1559	2	2016	2021	3
1559	2	2011	2015	6
1560	2	2016	2021	12
1560	2	2011	2015	8
1561	2	2016	2021	36
1561	2	2011	2015	18
1562	2	2016	2021	9
1562	2	2011	2015	6
1563	2	2016	2021	7
1563	2	2011	2015	10
1564	2	2016	2021	30
1564	2	2011	2015	27
1565	2	2016	2021	45
1565	2	2011	2015	43
1566	2	2016	2021	66
1566	2	2011	2015	76
1567	2	2016	2021	4
1567	2	2011	2015	4
1568	2	2016	2021	22
1568	2	2011	2015	16
1569	2	2016	2021	189
1569	2	2011	2015	158
1570	2	2016	2021	7
1570	2	2011	2015	10
1571	2	2016	2021	77
1571	2	2011	2015	67
1572	2	2016	2021	14
1572	2	2011	2015	24
1573	2	2016	2021	10
1573	2	2011	2015	9
1574	2	2016	2021	23
1574	2	2011	2015	12
1575	2	2016	2021	5
1575	2	2011	2015	8
1576	2	2016	2021	92
1576	2	2011	2015	90
1577	2	2016	2021	78
1577	2	2011	2015	73
1578	2	2016	2021	8
1578	2	2011	2015	12
1579	2	2016	2021	36
1579	2	2011	2015	30
1580	2	2016	2021	13
1580	2	2011	2015	21
1581	2	2016	2021	13
1581	2	2011	2015	13
1582	2	2016	2021	25
1582	2	2011	2015	16
1583	2	2016	2021	19
1583	2	2011	2015	14
1584	2	2016	2021	25
1584	2	2011	2015	35
1585	2	2016	2021	17
1585	2	2011	2015	18
1586	2	2016	2021	17
1586	2	2011	2015	9
1587	2	2016	2021	5
1587	2	2011	2015	1
1588	2	2016	2021	1
1588	2	2011	2015	1
1589	2	2016	2021	13
1589	2	2011	2015	14
1590	2	2016	2021	7
1590	2	2011	2015	8
1591	2	2016	2021	5
1591	2	2011	2015	5
1592	2	2016	2021	6
1592	2	2011	2015	5
1593	2	2016	2021	14
1593	2	2011	2015	16
1594	2	2016	2021	21
1594	2	2011	2015	15
1595	2	2016	2021	2
1595	2	2011	2015	7
1596	2	2016	2021	8
1596	2	2011	2015	10
1597	2	2016	2021	62
1597	2	2011	2015	63
1598	2	2016	2021	5
1598	2	2011	2015	3
1599	2	2016	2021	83
1599	2	2011	2015	91
1600	2	2016	2021	27
1600	2	2011	2015	13
1601	2	2016	2021	9
1601	2	2011	2015	16
1602	2	2016	2021	276
1602	2	2011	2015	238
1603	2	2016	2021	62
1603	2	2011	2015	69
1604	2	2016	2021	50
1604	2	2011	2015	62
1605	2	2016	2021	50
1605	2	2011	2015	34
1606	2	2016	2021	129
1606	2	2011	2015	121
1607	2	2016	2021	20
1607	2	2011	2015	15
1608	2	2016	2021	16
1608	2	2011	2015	17
1609	2	2016	2021	14
1609	2	2011	2015	14
1610	2	2016	2021	7
1610	2	2011	2015	2
1611	2	2016	2021	48
1611	2	2011	2015	25
1612	2	2016	2021	2
1612	2	2011	2015	5
1613	2	2016	2021	5
1613	2	2011	2015	7
1614	2	2016	2021	15
1614	2	2011	2015	17
1615	2	2016	2021	24
1615	2	2011	2015	27
1616	2	2016	2021	153
1616	2	2011	2015	155
1617	2	2016	2021	103
1617	2	2011	2015	107
1618	2	2016	2021	240
1618	2	2011	2015	243
1619	2	2016	2021	1
1619	2	2011	2015	3
1620	2	2016	2021	35
1620	2	2011	2015	25
1621	2	2016	2021	6
1621	2	2011	2015	5
1622	2	2016	2021	11
1622	2	2011	2015	7
1623	2	2016	2021	25
1623	2	2011	2015	13
1624	2	2016	2021	38
1624	2	2011	2015	22
1625	2	2016	2021	40
1625	2	2011	2015	49
1626	2	2016	2021	1634
1626	2	2011	2015	1534
1627	2	2016	2021	8
1627	2	2011	2015	4
1628	2	2016	2021	39
1628	2	2011	2015	34
1629	2	2016	2021	37
1629	2	2011	2015	17
1630	2	2016	2021	7
1630	2	2011	2015	8
1631	2	2016	2021	3
1631	2	2011	2015	1
1632	2	2016	2021	42
1632	2	2011	2015	40
1633	2	2016	2021	67
1633	2	2011	2015	56
1634	2	2016	2021	19
1634	2	2011	2015	20
1635	2	2016	2021	37
1635	2	2011	2015	27
1636	2	2016	2021	9
1636	2	2011	2015	5
1637	2	2016	2021	97
1637	2	2011	2015	114
1638	2	2016	2021	16
1638	2	2011	2015	30
1639	2	2016	2021	4
1639	2	2011	2015	7
1640	2	2016	2021	27
1640	2	2011	2015	14
1641	2	2016	2021	6
1641	2	2011	2015	4
1642	2	2016	2021	203
1642	2	2011	2015	193
1643	2	2016	2021	47
1643	2	2011	2015	37
1644	2	2016	2021	27
1644	2	2011	2015	23
1645	2	2016	2021	10
1645	2	2011	2015	17
1646	2	2016	2021	3
1646	2	2011	2015	8
1647	2	2016	2021	16
1647	2	2011	2015	16
1648	2	2016	2021	10
1648	2	2011	2015	15
1649	2	2016	2021	111
1649	2	2011	2015	114
1650	2	2016	2021	19
1650	2	2011	2015	20
1651	2	2016	2021	142
1651	2	2011	2015	145
1652	2	2016	2021	18
1652	2	2011	2015	7
1653	2	2016	2021	167
1653	2	2011	2015	138
1654	2	2016	2021	13
1654	2	2011	2015	17
1655	2	2016	2021	59
1655	2	2011	2015	36
1656	2	2016	2021	20
1656	2	2011	2015	8
1657	2	2016	2021	7
1657	2	2011	2015	5
1658	2	2016	2021	8
1658	2	2011	2015	9
1659	2	2016	2021	27
1659	2	2011	2015	14
1660	2	2016	2021	40
1660	2	2011	2015	62
1661	2	2016	2021	25
1661	2	2011	2015	31
1662	2	2016	2021	16
1662	2	2011	2015	14
1663	2	2016	2021	41
1663	2	2011	2015	41
1664	2	2016	2021	12
1664	2	2011	2015	2
1665	2	2016	2021	103
1665	2	2011	2015	83
1666	2	2016	2021	25
1666	2	2011	2015	25
1667	2	2016	2021	235
1667	2	2011	2015	259
1668	2	2016	2021	15
1668	2	2011	2015	8
1669	2	2016	2021	19
1669	2	2011	2015	18
1670	2	2016	2021	9
1670	2	2011	2015	2
1671	2	2016	2021	39
1671	2	2011	2015	37
1672	2	2016	2021	2
1672	2	2011	2015	5
1673	2	2016	2021	4
1673	2	2011	2015	0
1674	2	2016	2021	9
1674	2	2011	2015	12
1675	2	2016	2021	23
1675	2	2011	2015	18
1676	2	2016	2021	2
1676	2	2011	2015	2
1677	2	2016	2021	29
1677	2	2011	2015	30
1678	2	2016	2021	4
1678	2	2011	2015	3
1679	2	2016	2021	0
1679	2	2011	2015	2
1680	2	2016	2021	18
1680	2	2011	2015	10
1681	2	2016	2021	4
1681	2	2011	2015	10
1682	2	2016	2021	17
1682	2	2011	2015	14
1683	2	2016	2021	19
1683	2	2011	2015	21
1684	2	2016	2021	28
1684	2	2011	2015	30
1685	2	2016	2021	3
1685	2	2011	2015	1
1686	2	2016	2021	4
1686	2	2011	2015	8
1687	2	2016	2021	15
1687	2	2011	2015	16
1688	2	2016	2021	41
1688	2	2011	2015	47
1689	2	2016	2021	7
1689	2	2011	2015	10
1690	2	2016	2021	19
1690	2	2011	2015	18
1691	2	2016	2021	2
1691	2	2011	2015	1
1692	2	2016	2021	9
1692	2	2011	2015	15
1693	2	2016	2021	4
1693	2	2011	2015	3
1694	2	2016	2021	8
1694	2	2011	2015	7
1695	2	2016	2021	7
1695	2	2011	2015	11
1696	2	2016	2021	3
1696	2	2011	2015	3
1697	2	2016	2021	8
1697	2	2011	2015	3
1698	2	2016	2021	12
1698	2	2011	2015	9
1699	2	2016	2021	51
1699	2	2011	2015	47
1700	2	2016	2021	14
1700	2	2011	2015	13
1701	2	2016	2021	1
1701	2	2011	2015	4
1702	2	2016	2021	41
1702	2	2011	2015	40
1703	2	2016	2021	9
1703	2	2011	2015	18
1704	2	2016	2021	9
1704	2	2011	2015	15
1705	2	2016	2021	12
1705	2	2011	2015	16
1706	2	2016	2021	7
1706	2	2011	2015	4
1707	2	2016	2021	11
1707	2	2011	2015	21
1708	2	2016	2021	48
1708	2	2011	2015	27
1709	2	2016	2021	55
1709	2	2011	2015	40
1710	2	2016	2021	10
1710	2	2011	2015	23
1711	2	2016	2021	7
1711	2	2011	2015	4
1712	2	2016	2021	5
1712	2	2011	2015	2
1713	2	2016	2021	13
1713	2	2011	2015	7
1714	2	2016	2021	2
1714	2	2011	2015	3
1715	2	2016	2021	16
1715	2	2011	2015	12
1716	2	2016	2021	6
1716	2	2011	2015	8
1717	2	2016	2021	13
1717	2	2011	2015	27
1718	2	2016	2021	10
1718	2	2011	2015	13
1719	2	2016	2021	24
1719	2	2011	2015	17
1720	2	2016	2021	3
1720	2	2011	2015	5
1721	2	2016	2021	30
1721	2	2011	2015	33
1722	2	2016	2021	53
1722	2	2011	2015	54
1723	2	2016	2021	10
1723	2	2011	2015	8
1724	2	2016	2021	5
1724	2	2011	2015	5
1725	2	2016	2021	97
1725	2	2011	2015	100
1726	2	2016	2021	14
1726	2	2011	2015	13
1727	2	2016	2021	16
1727	2	2011	2015	15
1728	2	2016	2021	4
1728	2	2011	2015	6
1729	2	2016	2021	4
1729	2	2011	2015	2
1730	2	2016	2021	21
1730	2	2011	2015	12
1731	2	2016	2021	31
1731	2	2011	2015	42
1732	2	2016	2021	19
1732	2	2011	2015	17
1733	2	2016	2021	29
1733	2	2011	2015	20
1734	2	2016	2021	2
1734	2	2011	2015	3
1735	2	2016	2021	13
1735	2	2011	2015	7
1736	2	2016	2021	35
1736	2	2011	2015	36
1737	2	2016	2021	21
1737	2	2011	2015	31
1738	2	2016	2021	6
1738	2	2011	2015	9
1739	2	2016	2021	5
1739	2	2011	2015	8
1740	2	2016	2021	15
1740	2	2011	2015	5
1741	2	2016	2021	9
1741	2	2011	2015	15
1742	2	2016	2021	25
1742	2	2011	2015	19
1743	2	2016	2021	37
1743	2	2011	2015	31
1744	2	2016	2021	69
1744	2	2011	2015	66
1745	2	2016	2021	19
1745	2	2011	2015	8
1746	2	2016	2021	7
1746	2	2011	2015	11
1747	2	2016	2021	4
1747	2	2011	2015	9
1748	2	2016	2021	15
1748	2	2011	2015	19
1749	2	2016	2021	12
1749	2	2011	2015	15
1750	2	2016	2021	10
1750	2	2011	2015	8
1751	2	2016	2021	40
1751	2	2011	2015	27
1752	2	2016	2021	58
1752	2	2011	2015	48
1753	2	2016	2021	12
1753	2	2011	2015	10
1754	2	2016	2021	9
1754	2	2011	2015	9
1755	2	2016	2021	6
1755	2	2011	2015	6
1756	2	2016	2021	10
1756	2	2011	2015	9
1757	2	2016	2021	4
1757	2	2011	2015	4
1758	2	2016	2021	33
1758	2	2011	2015	39
1759	2	2016	2021	21
1759	2	2011	2015	15
1760	2	2016	2021	19
1760	2	2011	2015	10
1761	2	2016	2021	12
1761	2	2011	2015	7
1762	2	2016	2021	6
1762	2	2011	2015	4
1763	2	2016	2021	55
1763	2	2011	2015	59
1764	2	2016	2021	17
1764	2	2011	2015	11
1765	2	2016	2021	16
1765	2	2011	2015	12
1766	2	2016	2021	81
1766	2	2011	2015	79
1767	2	2016	2021	7
1767	2	2011	2015	6
1768	2	2016	2021	15
1768	2	2011	2015	12
1769	2	2016	2021	30
1769	2	2011	2015	29
1770	2	2016	2021	21
1770	2	2011	2015	26
1771	2	2016	2021	3
1771	2	2011	2015	3
1772	2	2016	2021	5
1772	2	2011	2015	3
1773	2	2016	2021	23
1773	2	2011	2015	16
1774	2	2016	2021	8
1774	2	2011	2015	5
1775	2	2016	2021	18
1775	2	2011	2015	11
1776	2	2016	2021	25
1776	2	2011	2015	22
1777	2	2016	2021	35
1777	2	2011	2015	33
1778	2	2016	2021	3
1778	2	2011	2015	1
1779	2	2016	2021	17
1779	2	2011	2015	30
1780	2	2016	2021	5
1780	2	2011	2015	7
1781	2	2016	2021	9
1781	2	2011	2015	13
1782	2	2016	2021	10
1782	2	2011	2015	7
1783	2	2016	2021	3
1783	2	2011	2015	0
1784	2	2016	2021	3
1784	2	2011	2015	9
1785	2	2016	2021	42
1785	2	2011	2015	29
1786	2	2016	2021	9
1786	2	2011	2015	13
1787	2	2016	2021	9
1787	2	2011	2015	4
1788	2	2016	2021	14
1788	2	2011	2015	12
1789	2	2016	2021	11
1789	2	2011	2015	17
1790	2	2016	2021	20
1790	2	2011	2015	13
1791	2	2016	2021	13
1791	2	2011	2015	4
1792	2	2016	2021	38
1792	2	2011	2015	40
1793	2	2016	2021	3
1793	2	2011	2015	5
1794	2	2016	2021	12
1794	2	2011	2015	11
1795	2	2016	2021	11
1795	2	2011	2015	15
1796	2	2016	2021	351
1796	2	2011	2015	386
1797	2	2016	2021	49
1797	2	2011	2015	47
1798	2	2016	2021	5
1798	2	2011	2015	8
1799	2	2016	2021	19
1799	2	2011	2015	22
1800	2	2016	2021	7
1800	2	2011	2015	8
1801	2	2016	2021	8
1801	2	2011	2015	5
1802	2	2016	2021	27
1802	2	2011	2015	20
1803	2	2016	2021	47
1803	2	2011	2015	39
1804	2	2016	2021	8
1804	2	2011	2015	6
1805	2	2016	2021	3
1805	2	2011	2015	11
1806	2	2016	2021	3
1806	2	2011	2015	5
1807	2	2016	2021	9
1807	2	2011	2015	4
1808	2	2016	2021	1
1808	2	2011	2015	3
1809	2	2016	2021	63
1809	2	2011	2015	53
1810	2	2016	2021	7
1810	2	2011	2015	10
1811	2	2016	2021	11
1811	2	2011	2015	17
1812	2	2016	2021	3
1812	2	2011	2015	6
1813	2	2016	2021	36
1813	2	2011	2015	29
1814	2	2016	2021	77
1814	2	2011	2015	75
1815	2	2016	2021	5
1815	2	2011	2015	3
1816	2	2016	2021	4
1816	2	2011	2015	6
1817	2	2016	2021	37
1817	2	2011	2015	41
1818	2	2016	2021	25
1818	2	2011	2015	15
1819	2	2016	2021	2
1819	2	2011	2015	0
1820	2	2016	2021	1
1820	2	2011	2015	1
1821	2	2016	2021	343
1821	2	2011	2015	336
1822	2	2016	2021	5
1822	2	2011	2015	2
1823	2	2016	2021	12
1823	2	2011	2015	10
1824	2	2016	2021	49
1824	2	2011	2015	66
1825	2	2016	2021	113
1825	2	2011	2015	93
1826	2	2016	2021	10
1826	2	2011	2015	10
1827	2	2016	2021	80
1827	2	2011	2015	69
1828	2	2016	2021	8
1828	2	2011	2015	10
1829	2	2016	2021	23
1829	2	2011	2015	23
1830	2	2016	2021	361
1830	2	2011	2015	264
1831	2	2016	2021	18
1831	2	2011	2015	25
1832	2	2016	2021	12
1832	2	2011	2015	8
1833	2	2016	2021	6
1833	2	2011	2015	3
1834	2	2016	2021	8
1834	2	2011	2015	10
1835	2	2016	2021	6
1835	2	2011	2015	11
1836	2	2016	2021	39
1836	2	2011	2015	22
1837	2	2016	2021	7
1837	2	2011	2015	14
1838	2	2016	2021	27
1838	2	2011	2015	22
1839	2	2016	2021	6
1839	2	2011	2015	12
1840	2	2016	2021	56
1840	2	2011	2015	67
1841	2	2016	2021	1
1841	2	2011	2015	5
1842	2	2016	2021	0
1842	2	2011	2015	1
1843	2	2016	2021	82
1843	2	2011	2015	75
1844	2	2016	2021	7
1844	2	2011	2015	13
1845	2	2016	2021	16
1845	2	2011	2015	17
1846	2	2016	2021	14
1846	2	2011	2015	18
1847	2	2016	2021	12
1847	2	2011	2015	7
1848	2	2016	2021	6
1848	2	2011	2015	9
1849	2	2016	2021	15
1849	2	2011	2015	21
1850	2	2016	2021	4
1850	2	2011	2015	10
1851	2	2016	2021	36
1851	2	2011	2015	48
1852	2	2016	2021	24
1852	2	2011	2015	12
1853	2	2016	2021	39
1853	2	2011	2015	50
1854	2	2016	2021	18
1854	2	2011	2015	16
1855	2	2016	2021	23
1855	2	2011	2015	31
1856	2	2016	2021	33
1856	2	2011	2015	29
1857	2	2016	2021	145
1857	2	2011	2015	104
1858	2	2016	2021	27
1858	2	2011	2015	35
1859	2	2016	2021	1386
1859	2	2011	2015	1133
1860	2	2016	2021	266
1860	2	2011	2015	202
1861	2	2016	2021	310
1861	2	2011	2015	283
1862	2	2016	2021	43
1862	2	2011	2015	41
1863	2	2016	2021	87
1863	2	2011	2015	83
1864	2	2016	2021	21
1864	2	2011	2015	36
1865	2	2016	2021	249
1865	2	2011	2015	240
1866	2	2016	2021	54
1866	2	2011	2015	30
1867	2	2016	2021	257
1867	2	2011	2015	256
1868	2	2016	2021	208
1868	2	2011	2015	176
1869	2	2016	2021	681
1869	2	2011	2015	525
1870	2	2016	2021	69
1870	2	2011	2015	59
1871	2	2016	2021	113
1871	2	2011	2015	104
1872	2	2016	2021	15
1872	2	2011	2015	15
1873	2	2016	2021	21
1873	2	2011	2015	10
1874	2	2016	2021	212
1874	2	2011	2015	198
1875	2	2016	2021	468
1875	2	2011	2015	347
1876	2	2016	2021	4
1876	2	2011	2015	5
1877	2	2016	2021	53
1877	2	2011	2015	57
1878	2	2016	2021	231
1878	2	2011	2015	205
1879	2	2016	2021	96
1879	2	2011	2015	66
1880	2	2016	2021	14
1880	2	2011	2015	13
1881	2	2016	2021	37
1881	2	2011	2015	37
1882	2	2016	2021	39
1882	2	2011	2015	32
1883	2	2016	2021	15
1883	2	2011	2015	8
1884	2	2016	2021	46
1884	2	2011	2015	81
1885	2	2016	2021	335
1885	2	2011	2015	346
1886	2	2016	2021	128
1886	2	2011	2015	115
1887	2	2016	2021	7
1887	2	2011	2015	2
1888	2	2016	2021	550
1888	2	2011	2015	451
1889	2	2016	2021	64
1889	2	2011	2015	47
1890	2	2016	2021	17
1890	2	2011	2015	18
1891	2	2016	2021	32
1891	2	2011	2015	31
1892	2	2016	2021	172
1892	2	2011	2015	195
1893	2	2016	2021	144
1893	2	2011	2015	106
1894	2	2016	2021	31
1894	2	2011	2015	35
1895	2	2016	2021	2388
1895	2	2011	2015	1709
1896	2	2016	2021	78
1896	2	2011	2015	82
1897	2	2016	2021	394
1897	2	2011	2015	305
1898	2	2016	2021	25
1898	2	2011	2015	12
1899	2	2016	2021	12
1899	2	2011	2015	17
1900	2	2016	2021	11
1900	2	2011	2015	23
1901	2	2016	2021	62
1901	2	2011	2015	34
1902	2	2016	2021	90
1902	2	2011	2015	85
1903	2	2016	2021	17
1903	2	2011	2015	9
1904	2	2016	2021	168
1904	2	2011	2015	129
1905	2	2016	2021	43
1905	2	2011	2015	34
1906	2	2016	2021	623
1906	2	2011	2015	526
1907	2	2016	2021	66
1907	2	2011	2015	70
1908	2	2016	2021	13
1908	2	2011	2015	11
1909	2	2016	2021	11
1909	2	2011	2015	18
1910	2	2016	2021	16
1910	2	2011	2015	16
1911	2	2016	2021	961
1911	2	2011	2015	686
1912	2	2016	2021	46
1912	2	2011	2015	31
1913	2	2016	2021	307
1913	2	2011	2015	308
1914	2	2016	2021	14
1914	2	2011	2015	13
1915	2	2016	2021	20
1915	2	2011	2015	23
1916	2	2016	2021	59
1916	2	2011	2015	59
1917	2	2016	2021	40
1917	2	2011	2015	34
1918	2	2016	2021	19141
1918	2	2011	2015	14839
1919	2	2016	2021	1
1919	2	2011	2015	1
1920	2	2016	2021	229
1920	2	2011	2015	172
1921	2	2016	2021	6
1921	2	2011	2015	2
1922	2	2016	2021	131
1922	2	2011	2015	100
1923	2	2016	2021	5
1923	2	2011	2015	4
1924	2	2016	2021	1482
1924	2	2011	2015	1264
1925	2	2016	2021	73
1925	2	2011	2015	49
1926	2	2016	2021	76
1926	2	2011	2015	72
1927	2	2016	2021	20
1927	2	2011	2015	13
1928	2	2016	2021	65
1928	2	2011	2015	73
1929	2	2016	2021	8
1929	2	2011	2015	12
1930	2	2016	2021	1477
1930	2	2011	2015	1189
1931	2	2016	2021	40
1931	2	2011	2015	36
1932	2	2016	2021	157
1932	2	2011	2015	153
1933	2	2016	2021	23
1933	2	2011	2015	28
1934	2	2016	2021	17
1934	2	2011	2015	17
1935	2	2016	2021	502
1935	2	2011	2015	351
1936	2	2016	2021	114
1936	2	2011	2015	151
1937	2	2016	2021	95
1937	2	2011	2015	92
1938	2	2016	2021	63
1938	2	2011	2015	45
1939	2	2016	2021	143
1939	2	2011	2015	76
1940	2	2016	2021	149
1940	2	2011	2015	125
1941	2	2016	2021	17
1941	2	2011	2015	23
1942	2	2016	2021	17
1942	2	2011	2015	23
1943	2	2016	2021	26
1943	2	2011	2015	22
1944	2	2016	2021	19
1944	2	2011	2015	23
1945	2	2016	2021	298
1945	2	2011	2015	218
1946	2	2016	2021	47
1946	2	2011	2015	28
1947	2	2016	2021	21
1947	2	2011	2015	13
1948	2	2016	2021	42
1948	2	2011	2015	48
1949	2	2016	2021	510
1949	2	2011	2015	388
1950	2	2016	2021	111
1950	2	2011	2015	112
1951	2	2016	2021	34
1951	2	2011	2015	28
1952	2	2016	2021	191
1952	2	2011	2015	174
1953	2	2016	2021	60
1953	2	2011	2015	56
1954	2	2016	2021	74
1954	2	2011	2015	74
1955	2	2016	2021	14
1955	2	2011	2015	20
1956	2	2016	2021	1
1956	2	2011	2015	3
1957	2	2016	2021	340
1957	2	2011	2015	348
1958	2	2016	2021	16
1958	2	2011	2015	14
1959	2	2016	2021	74
1959	2	2011	2015	79
1960	2	2016	2021	268
1960	2	2011	2015	233
1961	2	2016	2021	225
1961	2	2011	2015	147
1962	2	2016	2021	70
1962	2	2011	2015	61
1963	2	2016	2021	6
1963	2	2011	2015	8
1964	2	2016	2021	10
1964	2	2011	2015	9
1965	2	2016	2021	143
1965	2	2011	2015	146
1966	2	2016	2021	9
1966	2	2011	2015	8
1967	2	2016	2021	36
1967	2	2011	2015	34
1968	2	2016	2021	8
1968	2	2011	2015	7
1969	2	2016	2021	113
1969	2	2011	2015	61
1970	2	2016	2021	2282
1970	2	2011	2015	1742
1971	2	2016	2021	113
1971	2	2011	2015	102
1972	2	2016	2021	4
1972	2	2011	2015	5
1973	2	2016	2021	640
1973	2	2011	2015	543
1974	2	2016	2021	160
1974	2	2011	2015	187
1975	2	2016	2021	42
1975	2	2011	2015	29
1976	2	2016	2021	146
1976	2	2011	2015	127
1977	2	2016	2021	49
1977	2	2011	2015	45
1978	2	2016	2021	11
1978	2	2011	2015	12
1979	2	2016	2021	35
1979	2	2011	2015	32
1980	2	2016	2021	9
1980	2	2011	2015	7
1981	2	2016	2021	69
1981	2	2011	2015	58
1982	2	2016	2021	12
1982	2	2011	2015	11
1983	2	2016	2021	17
1983	2	2011	2015	27
1984	2	2016	2021	2
1984	2	2011	2015	2
1985	2	2016	2021	13
1985	2	2011	2015	17
1986	2	2016	2021	10
1986	2	2011	2015	13
1987	2	2016	2021	12
1987	2	2011	2015	14
1988	2	2016	2021	12
1988	2	2011	2015	13
1989	2	2016	2021	483
1989	2	2011	2015	497
1990	2	2016	2021	7
1990	2	2011	2015	5
1991	2	2016	2021	280
1991	2	2011	2015	271
1992	2	2016	2021	63
1992	2	2011	2015	45
1993	2	2016	2021	139
1993	2	2011	2015	79
1994	2	2016	2021	197
1994	2	2011	2015	175
1995	2	2016	2021	27
1995	2	2011	2015	31
1996	2	2016	2021	44
1996	2	2011	2015	39
1997	2	2016	2021	152
1997	2	2011	2015	178
1998	2	2016	2021	23
1998	2	2011	2015	24
1999	2	2016	2021	0
1999	2	2011	2015	2
2000	2	2016	2021	5
2000	2	2011	2015	6
2001	2	2016	2021	7
2001	2	2011	2015	9
2002	2	2016	2021	53
2002	2	2011	2015	43
2003	2	2016	2021	11
2003	2	2011	2015	7
2004	2	2016	2021	10
2004	2	2011	2015	14
2005	2	2016	2021	116
2005	2	2011	2015	152
2006	2	2016	2021	9
2006	2	2011	2015	3
2007	2	2016	2021	9
2007	2	2011	2015	12
2008	2	2016	2021	35
2008	2	2011	2015	47
2009	2	2016	2021	13
2009	2	2011	2015	9
2010	2	2016	2021	106
2010	2	2011	2015	92
2011	2	2016	2021	22
2011	2	2011	2015	28
2012	2	2016	2021	35
2012	2	2011	2015	44
2013	2	2016	2021	1864
2013	2	2011	2015	1397
2014	2	2016	2021	19
2014	2	2011	2015	22
2015	2	2016	2021	95
2015	2	2011	2015	87
2016	2	2016	2021	222
2016	2	2011	2015	154
2017	2	2016	2021	24
2017	2	2011	2015	31
2018	2	2016	2021	1471
2018	2	2011	2015	1251
2019	2	2016	2021	42
2019	2	2011	2015	35
2020	2	2016	2021	1
2020	2	2011	2015	6
2021	2	2016	2021	25
2021	2	2011	2015	36
2022	2	2016	2021	11
2022	2	2011	2015	13
2023	2	2016	2021	6
2023	2	2011	2015	16
2024	2	2016	2021	6
2024	2	2011	2015	10
2025	2	2016	2021	64
2025	2	2011	2015	56
2026	2	2016	2021	46
2026	2	2011	2015	43
2027	2	2016	2021	21
2027	2	2011	2015	11
2028	2	2016	2021	122
2028	2	2011	2015	85
2029	2	2016	2021	13
2029	2	2011	2015	15
2030	2	2016	2021	191
2030	2	2011	2015	168
2031	2	2016	2021	4
2031	2	2011	2015	5
2032	2	2016	2021	16
2032	2	2011	2015	15
2033	2	2016	2021	26
2033	2	2011	2015	36
2034	2	2016	2021	92
2034	2	2011	2015	81
2035	2	2016	2021	30
2035	2	2011	2015	25
2036	2	2016	2021	148
2036	2	2011	2015	111
2037	2	2016	2021	24
2037	2	2011	2015	26
2038	2	2016	2021	85
2038	2	2011	2015	58
2039	2	2016	2021	3
2039	2	2011	2015	6
2040	2	2016	2021	28
2040	2	2011	2015	22
2041	2	2016	2021	3
2041	2	2011	2015	4
2042	2	2016	2021	32
2042	2	2011	2015	29
2043	2	2016	2021	1301
2043	2	2011	2015	1136
2044	2	2016	2021	55
2044	2	2011	2015	58
2045	2	2016	2021	29
2045	2	2011	2015	24
2046	2	2016	2021	53
2046	2	2011	2015	48
2047	2	2016	2021	10
2047	2	2011	2015	11
2048	2	2016	2021	35
2048	2	2011	2015	28
2049	2	2016	2021	115
2049	2	2011	2015	92
2050	2	2016	2021	923
2050	2	2011	2015	827
2051	2	2016	2021	772
2051	2	2011	2015	564
2052	2	2016	2021	59
2052	2	2011	2015	46
2053	2	2016	2021	77
2053	2	2011	2015	66
2054	2	2016	2021	145
2054	2	2011	2015	146
2055	2	2016	2021	40
2055	2	2011	2015	29
2056	2	2016	2021	87
2056	2	2011	2015	94
2057	2	2016	2021	34
2057	2	2011	2015	18
2058	2	2016	2021	410
2058	2	2011	2015	296
2059	2	2016	2021	50
2059	2	2011	2015	39
2060	2	2016	2021	17
2060	2	2011	2015	19
2061	2	2016	2021	13
2061	2	2011	2015	3
2062	2	2016	2021	50
2062	2	2011	2015	39
2063	2	2016	2021	3
2063	2	2011	2015	6
2064	2	2016	2021	197
2064	2	2011	2015	201
2065	2	2016	2021	258
2065	2	2011	2015	237
2066	2	2016	2021	12
2066	2	2011	2015	5
2067	2	2016	2021	9
2067	2	2011	2015	4
2068	2	2016	2021	69
2068	2	2011	2015	95
2069	2	2016	2021	172
2069	2	2011	2015	132
2070	2	2016	2021	75
2070	2	2011	2015	93
2071	2	2016	2021	54
2071	2	2011	2015	56
2072	2	2016	2021	33
2072	2	2011	2015	30
2073	2	2016	2021	9
2073	2	2011	2015	10
2074	2	2016	2021	2
2074	2	2011	2015	4
2075	2	2016	2021	128
2075	2	2011	2015	145
2076	2	2016	2021	143
2076	2	2011	2015	143
2077	2	2016	2021	472
2077	2	2011	2015	424
2078	2	2016	2021	33
2078	2	2011	2015	38
2079	2	2016	2021	279
2079	2	2011	2015	266
2080	2	2016	2021	34
2080	2	2011	2015	26
2081	2	2016	2021	14
2081	2	2011	2015	12
2082	2	2016	2021	2
2082	2	2011	2015	1
2083	2	2016	2021	188
2083	2	2011	2015	174
2084	2	2016	2021	184
2084	2	2011	2015	154
2085	2	2016	2021	15
2085	2	2011	2015	10
2086	2	2016	2021	336
2086	2	2011	2015	327
2087	2	2016	2021	64
2087	2	2011	2015	45
2088	2	2016	2021	545
2088	2	2011	2015	479
2089	2	2016	2021	21
2089	2	2011	2015	22
2090	2	2016	2021	339
2090	2	2011	2015	370
2091	2	2016	2021	47
2091	2	2011	2015	49
2092	2	2016	2021	27
2092	2	2011	2015	26
2093	2	2016	2021	1630
2093	2	2011	2015	1494
2094	2	2016	2021	20
2094	2	2011	2015	21
2095	2	2016	2021	53
2095	2	2011	2015	31
2096	2	2016	2021	2
2096	2	2011	2015	0
2097	2	2016	2021	6
2097	2	2011	2015	7
2098	2	2016	2021	215
2098	2	2011	2015	215
2099	2	2016	2021	2335
2099	2	2011	2015	1723
2100	2	2016	2021	20
2100	2	2011	2015	13
2101	2	2016	2021	32
2101	2	2011	2015	27
2102	2	2016	2021	55
2102	2	2011	2015	40
2103	2	2016	2021	58
2103	2	2011	2015	57
2104	2	2016	2021	23
2104	2	2011	2015	18
2105	2	2016	2021	8
2105	2	2011	2015	5
2106	2	2016	2021	351
2106	2	2011	2015	283
2107	2	2016	2021	23
2107	2	2011	2015	37
2108	2	2016	2021	16
2108	2	2011	2015	19
2109	2	2016	2021	111
2109	2	2011	2015	68
2110	2	2016	2021	50
2110	2	2011	2015	50
2111	2	2016	2021	66
2111	2	2011	2015	58
2112	2	2016	2021	358
2112	2	2011	2015	302
2113	2	2016	2021	19
2113	2	2011	2015	18
2114	2	2016	2021	59
2114	2	2011	2015	47
2115	2	2016	2021	55
2115	2	2011	2015	35
2116	2	2016	2021	216
2116	2	2011	2015	213
2117	2	2016	2021	11
2117	2	2011	2015	17
2118	2	2016	2021	10
2118	2	2011	2015	13
2119	2	2016	2021	8
2119	2	2011	2015	8
2120	2	2016	2021	76
2120	2	2011	2015	72
2121	2	2016	2021	363
2121	2	2011	2015	337
2122	2	2016	2021	250
2122	2	2011	2015	179
2123	2	2016	2021	4
2123	2	2011	2015	7
2124	2	2016	2021	1
2124	2	2011	2015	5
2125	2	2016	2021	9
2125	2	2011	2015	13
2126	2	2016	2021	13
2126	2	2011	2015	10
2127	2	2016	2021	38
2127	2	2011	2015	34
2128	2	2016	2021	31
2128	2	2011	2015	23
2129	2	2016	2021	4870
2129	2	2011	2015	3870
2130	2	2016	2021	12
2130	2	2011	2015	18
2131	2	2016	2021	14
2131	2	2011	2015	14
2132	2	2016	2021	770
2132	2	2011	2015	656
2133	2	2016	2021	23
2133	2	2011	2015	24
2134	2	2016	2021	30
2134	2	2011	2015	29
2135	2	2016	2021	12
2135	2	2011	2015	11
2136	2	2016	2021	55
2136	2	2011	2015	45
2137	2	2016	2021	105
2137	2	2011	2015	83
2138	2	2016	2021	7
2138	2	2011	2015	7
2139	2	2016	2021	2
2139	2	2011	2015	5
2140	2	2016	2021	252
2140	2	2011	2015	182
2141	2	2016	2021	24
2141	2	2011	2015	29
2142	2	2016	2021	5
2142	2	2011	2015	3
2143	2	2016	2021	50
2143	2	2011	2015	46
2144	2	2016	2021	143
2144	2	2011	2015	118
2145	2	2016	2021	50
2145	2	2011	2015	49
2146	2	2016	2021	21
2146	2	2011	2015	18
2147	2	2016	2021	43
2147	2	2011	2015	45
2148	2	2016	2021	26
2148	2	2011	2015	27
2149	2	2016	2021	22
2149	2	2011	2015	16
2150	2	2016	2021	40
2150	2	2011	2015	45
2151	2	2016	2021	5
2151	2	2011	2015	9
2152	2	2016	2021	40
2152	2	2011	2015	31
2153	2	2016	2021	26
2153	2	2011	2015	26
2154	2	2016	2021	78
2154	2	2011	2015	89
2155	2	2016	2021	22
2155	2	2011	2015	10
2156	2	2016	2021	27
2156	2	2011	2015	34
2157	2	2016	2021	7
2157	2	2011	2015	11
2158	2	2016	2021	81
2158	2	2011	2015	78
2159	2	2016	2021	618
2159	2	2011	2015	501
2160	2	2016	2021	257
2160	2	2011	2015	250
2161	2	2016	2021	95
2161	2	2011	2015	74
2162	2	2016	2021	32
2162	2	2011	2015	48
2163	2	2016	2021	71
2163	2	2011	2015	76
2164	2	2016	2021	3553
2164	2	2011	2015	3182
2165	2	2016	2021	18
2165	2	2011	2015	13
2166	2	2016	2021	43
2166	2	2011	2015	39
2167	2	2016	2021	112
2167	2	2011	2015	139
2168	2	2016	2021	482
2168	2	2011	2015	383
2169	2	2016	2021	54
2169	2	2011	2015	38
2170	2	2016	2021	209
2170	2	2011	2015	206
2171	2	2016	2021	46
2171	2	2011	2015	42
2172	2	2016	2021	16
2172	2	2011	2015	11
2173	2	2016	2021	143
2173	2	2011	2015	160
2174	2	2016	2021	43
2174	2	2011	2015	41
2175	2	2016	2021	11
2175	2	2011	2015	13
2176	2	2016	2021	193
2176	2	2011	2015	118
2177	2	2016	2021	23
2177	2	2011	2015	27
2178	2	2016	2021	39
2178	2	2011	2015	36
2179	2	2016	2021	209
2179	2	2011	2015	204
2180	2	2016	2021	180
2180	2	2011	2015	185
2181	2	2016	2021	32
2181	2	2011	2015	47
2182	2	2016	2021	42
2182	2	2011	2015	27
2183	2	2016	2021	136
2183	2	2011	2015	139
2184	2	2016	2021	88
2184	2	2011	2015	68
2185	2	2016	2021	144
2185	2	2011	2015	163
2186	2	2016	2021	27
2186	2	2011	2015	46
2187	2	2016	2021	65
2187	2	2011	2015	46
2188	2	2016	2021	22
2188	2	2011	2015	22
2189	2	2016	2021	12
2189	2	2011	2015	21
2190	2	2016	2021	28
2190	2	2011	2015	22
2191	2	2016	2021	10
2191	2	2011	2015	17
2192	2	2016	2021	62
2192	2	2011	2015	46
2193	2	2016	2021	116
2193	2	2011	2015	108
2194	2	2016	2021	50
2194	2	2011	2015	63
2195	2	2016	2021	76
2195	2	2011	2015	86
2196	2	2016	2021	286
2196	2	2011	2015	305
2197	2	2016	2021	11
2197	2	2011	2015	6
2198	2	2016	2021	5
2198	2	2011	2015	11
2199	2	2016	2021	80
2199	2	2011	2015	86
2200	2	2016	2021	23
2200	2	2011	2015	22
2201	2	2016	2021	97
2201	2	2011	2015	98
2202	2	2016	2021	28
2202	2	2011	2015	31
2203	2	2016	2021	18
2203	2	2011	2015	14
2204	2	2016	2021	25
2204	2	2011	2015	19
2205	2	2016	2021	27
2205	2	2011	2015	25
2206	2	2016	2021	90
2206	2	2011	2015	68
2207	2	2016	2021	322
2207	2	2011	2015	280
2208	2	2016	2021	15
2208	2	2011	2015	16
2209	2	2016	2021	6
2209	2	2011	2015	9
2210	2	2016	2021	912
2210	2	2011	2015	759
2211	2	2016	2021	29
2211	2	2011	2015	22
2212	2	2016	2021	22
2212	2	2011	2015	30
2213	2	2016	2021	30
2213	2	2011	2015	23
2214	2	2016	2021	2
2214	2	2011	2015	1
2215	2	2016	2021	32
2215	2	2011	2015	51
2216	2	2016	2021	60
2216	2	2011	2015	46
2217	2	2016	2021	21
2217	2	2011	2015	15
2218	2	2016	2021	261
2218	2	2011	2015	247
2219	2	2016	2021	3
2219	2	2011	2015	6
2220	2	2016	2021	81
2220	2	2011	2015	85
2221	2	2016	2021	12
2221	2	2011	2015	13
2222	2	2016	2021	108
2222	2	2011	2015	95
2223	2	2016	2021	211
2223	2	2011	2015	178
2224	2	2016	2021	133
2224	2	2011	2015	100
2225	2	2016	2021	9
2225	2	2011	2015	12
2226	2	2016	2021	18
2226	2	2011	2015	34
2227	2	2016	2021	26
2227	2	2011	2015	30
2228	2	2016	2021	13
2228	2	2011	2015	15
2229	2	2016	2021	91
2229	2	2011	2015	80
2230	2	2016	2021	38
2230	2	2011	2015	45
2231	2	2016	2021	157
2231	2	2011	2015	168
2232	2	2016	2021	26
2232	2	2011	2015	15
2233	2	2016	2021	11
2233	2	2011	2015	8
2234	2	2016	2021	43
2234	2	2011	2015	52
2235	2	2016	2021	332
2235	2	2011	2015	332
2236	2	2016	2021	85
2236	2	2011	2015	93
2237	2	2016	2021	70
2237	2	2011	2015	80
2238	2	2016	2021	11
2238	2	2011	2015	12
2239	2	2016	2021	316
2239	2	2011	2015	256
2240	2	2016	2021	7
2240	2	2011	2015	8
2241	2	2016	2021	14
2241	2	2011	2015	14
2242	2	2016	2021	12
2242	2	2011	2015	13
2243	2	2016	2021	8
2243	2	2011	2015	17
2244	2	2016	2021	229
2244	2	2011	2015	197
2245	2	2016	2021	11
2245	2	2011	2015	8
2246	2	2016	2021	10
2246	2	2011	2015	7
2247	2	2016	2021	24
2247	2	2011	2015	26
2248	2	2016	2021	27
2248	2	2011	2015	20
2249	2	2016	2021	69
2249	2	2011	2015	49
2250	2	2016	2021	23
2250	2	2011	2015	17
2251	2	2016	2021	9
2251	2	2011	2015	9
2252	2	2016	2021	63
2252	2	2011	2015	58
2253	2	2016	2021	136
2253	2	2011	2015	106
2254	2	2016	2021	28
2254	2	2011	2015	33
2255	2	2016	2021	146
2255	2	2011	2015	112
2256	2	2016	2021	42
2256	2	2011	2015	53
2257	2	2016	2021	162
2257	2	2011	2015	156
2258	2	2016	2021	15
2258	2	2011	2015	20
2259	2	2016	2021	5
2259	2	2011	2015	5
2260	2	2016	2021	12
2260	2	2011	2015	2
2261	2	2016	2021	26
2261	2	2011	2015	16
2262	2	2016	2021	560
2262	2	2011	2015	341
2263	2	2016	2021	31
2263	2	2011	2015	33
2264	2	2016	2021	269
2264	2	2011	2015	292
2265	2	2016	2021	104
2265	2	2011	2015	76
2266	2	2016	2021	4
2266	2	2011	2015	16
2267	2	2016	2021	8
2267	2	2011	2015	13
2268	2	2016	2021	5
2268	2	2011	2015	3
2269	2	2016	2021	12
2269	2	2011	2015	18
2270	2	2016	2021	10
2270	2	2011	2015	23
2271	2	2016	2021	9
2271	2	2011	2015	18
2272	2	2016	2021	678
2272	2	2011	2015	505
2273	2	2016	2021	168
2273	2	2011	2015	128
2274	2	2016	2021	101
2274	2	2011	2015	151
2275	2	2016	2021	77
2275	2	2011	2015	67
2276	2	2016	2021	109
2276	2	2011	2015	95
2277	2	2016	2021	117
2277	2	2011	2015	109
2278	2	2016	2021	113
2278	2	2011	2015	102
2279	2	2016	2021	17
2279	2	2011	2015	19
2280	2	2016	2021	46
2280	2	2011	2015	53
2281	2	2016	2021	29
2281	2	2011	2015	24
2282	2	2016	2021	2
2282	2	2011	2015	3
2283	2	2016	2021	34
2283	2	2011	2015	35
2284	2	2016	2021	48
2284	2	2011	2015	43
2285	2	2016	2021	11
2285	2	2011	2015	8
2286	2	2016	2021	146
2286	2	2011	2015	154
2287	2	2016	2021	206
2287	2	2011	2015	174
2288	2	2016	2021	1658
2288	2	2011	2015	1474
2289	2	2016	2021	13
2289	2	2011	2015	10
2290	2	2016	2021	37
2290	2	2011	2015	12
2291	2	2016	2021	53
2291	2	2011	2015	49
2292	2	2016	2021	13
2292	2	2011	2015	8
2293	2	2016	2021	107
2293	2	2011	2015	96
2294	2	2016	2021	30
2294	2	2011	2015	17
2295	2	2016	2021	31
2295	2	2011	2015	29
2296	2	2016	2021	45
2296	2	2011	2015	45
2297	2	2016	2021	14
2297	2	2011	2015	13
2298	2	2016	2021	22
2298	2	2011	2015	30
2299	2	2016	2021	16
2299	2	2011	2015	20
2300	2	2016	2021	17
2300	2	2011	2015	16
2301	2	2016	2021	55
2301	2	2011	2015	58
2302	2	2016	2021	14
2302	2	2011	2015	11
2303	2	2016	2021	75
2303	2	2011	2015	60
2304	2	2016	2021	219
2304	2	2011	2015	187
2305	2	2016	2021	10
2305	2	2011	2015	10
2306	2	2016	2021	17
2306	2	2011	2015	14
2307	2	2016	2021	65
2307	2	2011	2015	46
2308	2	2016	2021	59
2308	2	2011	2015	48
2309	2	2016	2021	16
2309	2	2011	2015	14
2310	2	2016	2021	188
2310	2	2011	2015	193
2311	2	2016	2021	284
2311	2	2011	2015	215
2312	2	2016	2021	18
2312	2	2011	2015	24
2313	2	2016	2021	38
2313	2	2011	2015	46
2314	2	2016	2021	45
2314	2	2011	2015	47
2315	2	2016	2021	168
2315	2	2011	2015	193
2316	2	2016	2021	6
2316	2	2011	2015	9
2317	2	2016	2021	51
2317	2	2011	2015	55
2318	2	2016	2021	7
2318	2	2011	2015	10
2319	2	2016	2021	14
2319	2	2011	2015	9
2320	2	2016	2021	263
2320	2	2011	2015	227
2321	2	2016	2021	95
2321	2	2011	2015	65
2322	2	2016	2021	90
2322	2	2011	2015	76
2323	2	2016	2021	20
2323	2	2011	2015	16
2324	2	2016	2021	70
2324	2	2011	2015	52
2325	2	2016	2021	15
2325	2	2011	2015	14
2326	2	2016	2021	19
2326	2	2011	2015	15
2327	2	2016	2021	74
2327	2	2011	2015	65
2328	2	2016	2021	13
2328	2	2011	2015	13
2329	2	2016	2021	208
2329	2	2011	2015	188
2330	2	2016	2021	17
2330	2	2011	2015	14
2331	2	2016	2021	97
2331	2	2011	2015	59
2332	2	2016	2021	182
2332	2	2011	2015	104
2333	2	2016	2021	409
2333	2	2011	2015	309
2334	2	2016	2021	26
2334	2	2011	2015	17
2335	2	2016	2021	26
2335	2	2011	2015	21
2336	2	2016	2021	262
2336	2	2011	2015	168
2337	2	2016	2021	39
2337	2	2011	2015	30
2338	2	2016	2021	31
2338	2	2011	2015	26
2339	2	2016	2021	59
2339	2	2011	2015	56
2340	2	2016	2021	89
2340	2	2011	2015	91
2341	2	2016	2021	97
2341	2	2011	2015	89
2342	2	2016	2021	8
2342	2	2011	2015	17
2343	2	2016	2021	30
2343	2	2011	2015	33
2344	2	2016	2021	27
2344	2	2011	2015	22
2345	2	2016	2021	12
2345	2	2011	2015	19
2346	2	2016	2021	18
2346	2	2011	2015	13
2347	2	2016	2021	17
2347	2	2011	2015	21
2348	2	2016	2021	8
2348	2	2011	2015	7
2349	2	2016	2021	68
2349	2	2011	2015	76
2350	2	2016	2021	27
2350	2	2011	2015	20
2351	2	2016	2021	8
2351	2	2011	2015	11
2352	2	2016	2021	134
2352	2	2011	2015	102
2353	2	2016	2021	65
2353	2	2011	2015	57
2354	2	2016	2021	611
2354	2	2011	2015	506
2355	2	2016	2021	14
2355	2	2011	2015	17
2356	2	2016	2021	28
2356	2	2011	2015	33
2357	2	2016	2021	2740
2357	2	2011	2015	2444
2358	2	2016	2021	100
2358	2	2011	2015	94
2359	2	2016	2021	23
2359	2	2011	2015	20
2360	2	2016	2021	93
2360	2	2011	2015	72
2361	2	2016	2021	7
2361	2	2011	2015	6
2362	2	2016	2021	444
2362	2	2011	2015	401
2363	2	2016	2021	53
2363	2	2011	2015	34
2364	2	2016	2021	1191
2364	2	2011	2015	1059
2365	2	2016	2021	63
2365	2	2011	2015	58
2366	2	2016	2021	21
2366	2	2011	2015	19
2367	2	2016	2021	22
2367	2	2011	2015	17
2368	2	2016	2021	197
2368	2	2011	2015	162
2369	2	2016	2021	45
2369	2	2011	2015	53
2370	2	2016	2021	315
2370	2	2011	2015	209
2371	2	2016	2021	9
2371	2	2011	2015	18
2372	2	2016	2021	29
2372	2	2011	2015	9
2373	2	2016	2021	24
2373	2	2011	2015	27
2374	2	2016	2021	331
2374	2	2011	2015	212
2375	2	2016	2021	98
2375	2	2011	2015	89
2376	2	2016	2021	31
2376	2	2011	2015	38
2377	2	2016	2021	54
2377	2	2011	2015	52
2378	2	2016	2021	54
2378	2	2011	2015	63
2379	2	2016	2021	34
2379	2	2011	2015	53
2380	2	2016	2021	55
2380	2	2011	2015	57
2381	2	2016	2021	28
2381	2	2011	2015	11
2382	2	2016	2021	39
2382	2	2011	2015	53
2383	2	2016	2021	74
2383	2	2011	2015	55
2384	2	2016	2021	22
2384	2	2011	2015	11
2385	2	2016	2021	2820
2385	2	2011	2015	1961
2386	2	2016	2021	19
2386	2	2011	2015	16
2387	2	2016	2021	64
2387	2	2011	2015	70
2388	2	2016	2021	85
2388	2	2011	2015	61
2389	2	2016	2021	209
2389	2	2011	2015	152
2390	2	2016	2021	330
2390	2	2011	2015	245
2391	2	2016	2021	266
2391	2	2011	2015	234
2392	2	2016	2021	63
2392	2	2011	2015	56
2393	2	2016	2021	11
2393	2	2011	2015	17
2394	2	2016	2021	135
2394	2	2011	2015	130
2395	2	2016	2021	17
2395	2	2011	2015	9
2396	2	2016	2021	28
2396	2	2011	2015	25
2397	2	2016	2021	12
2397	2	2011	2015	4
2398	2	2016	2021	4
2398	2	2011	2015	2
2399	2	2016	2021	13
2399	2	2011	2015	28
2400	2	2016	2021	22
2400	2	2011	2015	13
2401	2	2016	2021	2
2401	2	2011	2015	4
2402	2	2016	2021	22
2402	2	2011	2015	10
2403	2	2016	2021	2
2403	2	2011	2015	2
2404	2	2016	2021	13
2404	2	2011	2015	9
2405	2	2016	2021	22
2405	2	2011	2015	25
2406	2	2016	2021	29
2406	2	2011	2015	21
2407	2	2016	2021	38
2407	2	2011	2015	45
2408	2	2016	2021	30
2408	2	2011	2015	30
2409	2	2016	2021	61
2409	2	2011	2015	39
2410	2	2016	2021	24
2410	2	2011	2015	22
2411	2	2016	2021	8
2411	2	2011	2015	14
2412	2	2016	2021	13
2412	2	2011	2015	18
2413	2	2016	2021	39
2413	2	2011	2015	33
2414	2	2016	2021	28
2414	2	2011	2015	18
2415	2	2016	2021	2
2415	2	2011	2015	6
2416	2	2016	2021	2
2416	2	2011	2015	4
2417	2	2016	2021	29
2417	2	2011	2015	15
2418	2	2016	2021	3
2418	2	2011	2015	1
2419	2	2016	2021	62
2419	2	2011	2015	43
2420	2	2016	2021	14
2420	2	2011	2015	7
2421	2	2016	2021	4
2421	2	2011	2015	10
2422	2	2016	2021	18
2422	2	2011	2015	30
2423	2	2016	2021	33
2423	2	2011	2015	28
2424	2	2016	2021	264
2424	2	2011	2015	159
2425	2	2016	2021	112
2425	2	2011	2015	87
2426	2	2016	2021	2
2426	2	2011	2015	6
2427	2	2016	2021	2
2427	2	2011	2015	6
2428	2	2016	2021	13
2428	2	2011	2015	12
2429	2	2016	2021	5
2429	2	2011	2015	4
2430	2	2016	2021	12
2430	2	2011	2015	8
2431	2	2016	2021	41
2431	2	2011	2015	36
2432	2	2016	2021	58
2432	2	2011	2015	40
2433	2	2016	2021	612
2433	2	2011	2015	568
2434	2	2016	2021	15
2434	2	2011	2015	5
2435	2	2016	2021	16
2435	2	2011	2015	15
2436	2	2016	2021	18
2436	2	2011	2015	10
2437	2	2016	2021	55
2437	2	2011	2015	43
2438	2	2016	2021	9
2438	2	2011	2015	7
2439	2	2016	2021	12
2439	2	2011	2015	12
2440	2	2016	2021	11
2440	2	2011	2015	7
2441	2	2016	2021	97
2441	2	2011	2015	91
2442	2	2016	2021	34
2442	2	2011	2015	40
2443	2	2016	2021	9
2443	2	2011	2015	7
2444	2	2016	2021	11
2444	2	2011	2015	9
2445	2	2016	2021	35
2445	2	2011	2015	43
2446	2	2016	2021	5
2446	2	2011	2015	3
2447	2	2016	2021	55
2447	2	2011	2015	51
2448	2	2016	2021	38
2448	2	2011	2015	18
2449	2	2016	2021	47
2449	2	2011	2015	36
2450	2	2016	2021	8
2450	2	2011	2015	8
2451	2	2016	2021	425
2451	2	2011	2015	346
2452	2	2016	2021	23
2452	2	2011	2015	24
2453	2	2016	2021	32
2453	2	2011	2015	18
2454	2	2016	2021	39
2454	2	2011	2015	33
2455	2	2016	2021	20
2455	2	2011	2015	15
2456	2	2016	2021	18
2456	2	2011	2015	14
2457	2	2016	2021	29
2457	2	2011	2015	28
2458	2	2016	2021	7
2458	2	2011	2015	8
2459	2	2016	2021	7
2459	2	2011	2015	7
2460	2	2016	2021	32
2460	2	2011	2015	33
2461	2	2016	2021	141
2461	2	2011	2015	93
2462	2	2016	2021	18
2462	2	2011	2015	29
2463	2	2016	2021	23
2463	2	2011	2015	25
2464	2	2016	2021	13
2464	2	2011	2015	12
2465	2	2016	2021	6
2465	2	2011	2015	4
2466	2	2016	2021	64
2466	2	2011	2015	52
2467	2	2016	2021	26
2467	2	2011	2015	18
2468	2	2016	2021	14
2468	2	2011	2015	16
2469	2	2016	2021	4
2469	2	2011	2015	6
2470	2	2016	2021	35
2470	2	2011	2015	30
2471	2	2016	2021	17
2471	2	2011	2015	23
2472	2	2016	2021	38
2472	2	2011	2015	27
2473	2	2016	2021	15
2473	2	2011	2015	18
2474	2	2016	2021	1092
2474	2	2011	2015	976
2475	2	2016	2021	32
2475	2	2011	2015	48
2476	2	2016	2021	26
2476	2	2011	2015	25
2477	2	2016	2021	39
2477	2	2011	2015	30
2478	2	2016	2021	9
2478	2	2011	2015	16
2479	2	2016	2021	12
2479	2	2011	2015	14
2480	2	2016	2021	28
2480	2	2011	2015	27
2481	2	2016	2021	38
2481	2	2011	2015	28
2482	2	2016	2021	5
2482	2	2011	2015	6
2483	2	2016	2021	16
2483	2	2011	2015	17
2484	2	2016	2021	12
2484	2	2011	2015	22
2485	2	2016	2021	8
2485	2	2011	2015	18
2486	2	2016	2021	12
2486	2	2011	2015	12
2487	2	2016	2021	29
2487	2	2011	2015	19
2488	2	2016	2021	36
2488	2	2011	2015	46
2489	2	2016	2021	32
2489	2	2011	2015	32
2490	2	2016	2021	93
2490	2	2011	2015	86
2491	2	2016	2021	20
2491	2	2011	2015	29
2492	2	2016	2021	10
2492	2	2011	2015	10
2493	2	2016	2021	55
2493	2	2011	2015	28
2494	2	2016	2021	21
2494	2	2011	2015	16
2495	2	2016	2021	38
2495	2	2011	2015	23
2496	2	2016	2021	33
2496	2	2011	2015	38
2497	2	2016	2021	6
2497	2	2011	2015	2
2498	2	2016	2021	26
2498	2	2011	2015	26
2499	2	2016	2021	24
2499	2	2011	2015	14
2500	2	2016	2021	18
2500	2	2011	2015	13
2501	2	2016	2021	10
2501	2	2011	2015	18
2502	2	2016	2021	126
2502	2	2011	2015	127
2503	2	2016	2021	69
2503	2	2011	2015	61
2504	2	2016	2021	197
2504	2	2011	2015	167
2505	2	2016	2021	26
2505	2	2011	2015	27
2506	2	2016	2021	15
2506	2	2011	2015	10
2507	2	2016	2021	48
2507	2	2011	2015	48
2508	2	2016	2021	56
2508	2	2011	2015	67
2509	2	2016	2021	4
2509	2	2011	2015	5
2510	2	2016	2021	62
2510	2	2011	2015	59
2511	2	2016	2021	92
2511	2	2011	2015	108
2512	2	2016	2021	29
2512	2	2011	2015	25
2513	2	2016	2021	45
2513	2	2011	2015	31
2514	2	2016	2021	33
2514	2	2011	2015	44
2515	2	2016	2021	7
2515	2	2011	2015	4
2516	2	2016	2021	36
2516	2	2011	2015	25
2517	2	2016	2021	59
2517	2	2011	2015	67
2518	2	2016	2021	390
2518	2	2011	2015	332
2519	2	2016	2021	137
2519	2	2011	2015	134
2520	2	2016	2021	21
2520	2	2011	2015	31
2521	2	2016	2021	3
2521	2	2011	2015	9
2522	2	2016	2021	20
2522	2	2011	2015	17
2523	2	2016	2021	21
2523	2	2011	2015	16
2524	2	2016	2021	25
2524	2	2011	2015	18
2525	2	2016	2021	8
2525	2	2011	2015	6
2526	2	2016	2021	14
2526	2	2011	2015	25
2527	2	2016	2021	63
2527	2	2011	2015	56
2528	2	2016	2021	10
2528	2	2011	2015	17
2529	2	2016	2021	15
2529	2	2011	2015	10
2530	2	2016	2021	32
2530	2	2011	2015	34
2531	2	2016	2021	10
2531	2	2011	2015	9
2532	2	2016	2021	16
2532	2	2011	2015	12
2533	2	2016	2021	2
2533	2	2011	2015	6
2534	2	2016	2021	13
2534	2	2011	2015	11
2535	2	2016	2021	78
2535	2	2011	2015	66
2536	2	2016	2021	30
2536	2	2011	2015	30
2537	2	2016	2021	57
2537	2	2011	2015	26
2538	2	2016	2021	4
2538	2	2011	2015	17
2539	2	2016	2021	20
2539	2	2011	2015	13
2540	2	2016	2021	62
2540	2	2011	2015	51
2541	2	2016	2021	29
2541	2	2011	2015	36
2542	2	2016	2021	56
2542	2	2011	2015	52
2543	2	2016	2021	17
2543	2	2011	2015	9
2544	2	2016	2021	22
2544	2	2011	2015	24
2545	2	2016	2021	6
2545	2	2011	2015	5
2546	2	2016	2021	0
2546	2	2011	2015	0
2547	2	2016	2021	40
2547	2	2011	2015	39
2548	2	2016	2021	30
2548	2	2011	2015	24
2549	2	2016	2021	12
2549	2	2011	2015	16
2550	2	2016	2021	14
2550	2	2011	2015	22
2551	2	2016	2021	2
2551	2	2011	2015	0
2552	2	2016	2021	18
2552	2	2011	2015	19
2553	2	2016	2021	122
2553	2	2011	2015	112
2554	2	2016	2021	4
2554	2	2011	2015	9
2555	2	2016	2021	11
2555	2	2011	2015	14
2556	2	2016	2021	11
2556	2	2011	2015	6
2557	2	2016	2021	7
2557	2	2011	2015	12
2558	2	2016	2021	7
2558	2	2011	2015	7
2559	2	2016	2021	7
2559	2	2011	2015	10
2560	2	2016	2021	27
2560	2	2011	2015	24
2561	2	2016	2021	2
2561	2	2011	2015	5
2562	2	2016	2021	7
2562	2	2011	2015	17
2563	2	2016	2021	23
2563	2	2011	2015	26
2564	2	2016	2021	82
2564	2	2011	2015	80
2565	2	2016	2021	77
2565	2	2011	2015	61
2566	2	2016	2021	59
2566	2	2011	2015	38
2567	2	2016	2021	37
2567	2	2011	2015	30
2568	2	2016	2021	30
2568	2	2011	2015	36
2569	2	2016	2021	283
2569	2	2011	2015	253
2570	2	2016	2021	15
2570	2	2011	2015	9
2571	2	2016	2021	39
2571	2	2011	2015	28
2572	2	2016	2021	58
2572	2	2011	2015	51
2573	2	2016	2021	22
2573	2	2011	2015	30
2574	2	2016	2021	0
2574	2	2011	2015	2
2575	2	2016	2021	6
2575	2	2011	2015	13
2576	2	2016	2021	26
2576	2	2011	2015	26
2577	2	2016	2021	1661
2577	2	2011	2015	1540
2578	2	2016	2021	3
2578	2	2011	2015	2
2579	2	2016	2021	41
2579	2	2011	2015	41
2580	2	2016	2021	29
2580	2	2011	2015	35
2581	2	2016	2021	15
2581	2	2011	2015	18
2582	2	2016	2021	173
2582	2	2011	2015	198
2583	2	2016	2021	3
2583	2	2011	2015	3
2584	2	2016	2021	15
2584	2	2011	2015	10
2585	2	2016	2021	30
2585	2	2011	2015	27
2586	2	2016	2021	35
2586	2	2011	2015	77
2587	2	2016	2021	149
2587	2	2011	2015	140
2588	2	2016	2021	11
2588	2	2011	2015	17
2589	2	2016	2021	7
2589	2	2011	2015	8
2590	2	2016	2021	12
2590	2	2011	2015	9
2591	2	2016	2021	9
2591	2	2011	2015	14
2592	2	2016	2021	44
2592	2	2011	2015	45
2593	2	2016	2021	22
2593	2	2011	2015	21
2594	2	2016	2021	293
2594	2	2011	2015	230
2595	2	2016	2021	47
2595	2	2011	2015	33
2596	2	2016	2021	44
2596	2	2011	2015	36
2597	2	2016	2021	56
2597	2	2011	2015	57
2598	2	2016	2021	28
2598	2	2011	2015	39
2599	2	2016	2021	24
2599	2	2011	2015	25
2600	2	2016	2021	19
2600	2	2011	2015	12
2601	2	2016	2021	10
2601	2	2011	2015	13
2602	2	2016	2021	328
2602	2	2011	2015	283
2603	2	2016	2021	10
2603	2	2011	2015	17
2604	2	2016	2021	4
2604	2	2011	2015	8
2605	2	2016	2021	9
2605	2	2011	2015	8
2606	2	2016	2021	20
2606	2	2011	2015	19
2607	2	2016	2021	37
2607	2	2011	2015	39
2608	2	2016	2021	9
2608	2	2011	2015	8
2609	2	2016	2021	201
2609	2	2011	2015	182
2610	2	2016	2021	11
2610	2	2011	2015	3
2611	2	2016	2021	8
2611	2	2011	2015	16
2612	2	2016	2021	66
2612	2	2011	2015	59
2613	2	2016	2021	81
2613	2	2011	2015	68
2614	2	2016	2021	90
2614	2	2011	2015	67
2615	2	2016	2021	140
2615	2	2011	2015	139
2616	2	2016	2021	77
2616	2	2011	2015	45
2617	2	2016	2021	5
2617	2	2011	2015	8
2618	2	2016	2021	136
2618	2	2011	2015	145
2619	2	2016	2021	50
2619	2	2011	2015	49
2620	2	2016	2021	30
2620	2	2011	2015	31
2621	2	2016	2021	39
2621	2	2011	2015	43
2622	2	2016	2021	55
2622	2	2011	2015	41
2623	2	2016	2021	36
2623	2	2011	2015	24
2624	2	2016	2021	7
2624	2	2011	2015	3
2625	2	2016	2021	21
2625	2	2011	2015	26
2626	2	2016	2021	1
2626	2	2011	2015	4
2627	2	2016	2021	151
2627	2	2011	2015	150
2628	2	2016	2021	71
2628	2	2011	2015	68
2629	2	2016	2021	92
2629	2	2011	2015	88
2630	2	2016	2021	52
2630	2	2011	2015	52
2631	2	2016	2021	5
2631	2	2011	2015	8
2632	2	2016	2021	108
2632	2	2011	2015	91
2633	2	2016	2021	28
2633	2	2011	2015	30
2634	2	2016	2021	36
2634	2	2011	2015	32
2635	2	2016	2021	23
2635	2	2011	2015	21
2636	2	2016	2021	29
2636	2	2011	2015	42
2637	2	2016	2021	26
2637	2	2011	2015	31
2638	2	2016	2021	23
2638	2	2011	2015	23
2639	2	2016	2021	22
2639	2	2011	2015	31
2640	2	2016	2021	45
2640	2	2011	2015	45
2641	2	2016	2021	52
2641	2	2011	2015	48
2642	2	2016	2021	8
2642	2	2011	2015	11
2643	2	2016	2021	19
2643	2	2011	2015	9
2644	2	2016	2021	26
2644	2	2011	2015	30
2645	2	2016	2021	176
2645	2	2011	2015	149
2646	2	2016	2021	19
2646	2	2011	2015	20
2647	2	2016	2021	20
2647	2	2011	2015	24
2648	2	2016	2021	119
2648	2	2011	2015	99
2649	2	2016	2021	5
2649	2	2011	2015	0
2650	2	2016	2021	80
2650	2	2011	2015	76
2651	2	2016	2021	51
2651	2	2011	2015	48
2652	2	2016	2021	48
2652	2	2011	2015	26
2653	2	2016	2021	41
2653	2	2011	2015	39
2654	2	2016	2021	19
2654	2	2011	2015	27
2655	2	2016	2021	71
2655	2	2011	2015	68
2656	2	2016	2021	123
2656	2	2011	2015	86
2657	2	2016	2021	371
2657	2	2011	2015	245
2658	2	2016	2021	92
2658	2	2011	2015	97
2659	2	2016	2021	22
2659	2	2011	2015	26
2660	2	2016	2021	6
2660	2	2011	2015	7
2661	2	2016	2021	35
2661	2	2011	2015	30
2662	2	2016	2021	40
2662	2	2011	2015	48
2663	2	2016	2021	619
2663	2	2011	2015	614
2664	2	2016	2021	104
2664	2	2011	2015	90
2665	2	2016	2021	544
2665	2	2011	2015	510
2666	2	2016	2021	244
2666	2	2011	2015	231
2667	2	2016	2021	167
2667	2	2011	2015	150
2668	2	2016	2021	372
2668	2	2011	2015	470
2669	2	2016	2021	31
2669	2	2011	2015	28
2670	2	2016	2021	55
2670	2	2011	2015	51
2671	2	2016	2021	243
2671	2	2011	2015	213
2672	2	2016	2021	42
2672	2	2011	2015	67
2673	2	2016	2021	14
2673	2	2011	2015	10
2674	2	2016	2021	5
2674	2	2011	2015	5
2675	2	2016	2021	76
2675	2	2011	2015	74
2676	2	2016	2021	78
2676	2	2011	2015	42
2677	2	2016	2021	63
2677	2	2011	2015	63
2678	2	2016	2021	75
2678	2	2011	2015	84
2679	2	2016	2021	88
2679	2	2011	2015	80
2680	2	2016	2021	234
2680	2	2011	2015	178
2681	2	2016	2021	10
2681	2	2011	2015	6
2682	2	2016	2021	29
2682	2	2011	2015	24
2683	2	2016	2021	9
2683	2	2011	2015	2
2684	2	2016	2021	39
2684	2	2011	2015	44
2685	2	2016	2021	18
2685	2	2011	2015	11
2686	2	2016	2021	20
2686	2	2011	2015	15
2687	2	2016	2021	143
2687	2	2011	2015	147
2688	2	2016	2021	8
2688	2	2011	2015	12
2689	2	2016	2021	36
2689	2	2011	2015	31
2690	2	2016	2021	37
2690	2	2011	2015	50
2691	2	2016	2021	43
2691	2	2011	2015	52
2692	2	2016	2021	82
2692	2	2011	2015	54
2693	2	2016	2021	321
2693	2	2011	2015	277
2694	2	2016	2021	28
2694	2	2011	2015	33
2695	2	2016	2021	609
2695	2	2011	2015	585
2696	2	2016	2021	141
2696	2	2011	2015	171
2697	2	2016	2021	58
2697	2	2011	2015	55
2698	2	2016	2021	36
2698	2	2011	2015	37
2699	2	2016	2021	47
2699	2	2011	2015	29
2700	2	2016	2021	194
2700	2	2011	2015	131
2701	2	2016	2021	13
2701	2	2011	2015	17
2702	2	2016	2021	10
2702	2	2011	2015	6
2703	2	2016	2021	34
2703	2	2011	2015	24
2704	2	2016	2021	6
2704	2	2011	2015	13
2705	2	2016	2021	8
2705	2	2011	2015	8
2706	2	2016	2021	11
2706	2	2011	2015	13
2707	2	2016	2021	14
2707	2	2011	2015	14
2708	2	2016	2021	10
2708	2	2011	2015	9
2709	2	2016	2021	50
2709	2	2011	2015	55
2710	2	2016	2021	10
2710	2	2011	2015	10
2711	2	2016	2021	71
2711	2	2011	2015	62
2712	2	2016	2021	18
2712	2	2011	2015	31
2713	2	2016	2021	17
2713	2	2011	2015	20
2714	2	2016	2021	118
2714	2	2011	2015	95
2715	2	2016	2021	114
2715	2	2011	2015	122
2716	2	2016	2021	81
2716	2	2011	2015	61
2717	2	2016	2021	20
2717	2	2011	2015	12
2718	2	2016	2021	2340
2718	2	2011	2015	2264
2719	2	2016	2021	8
2719	2	2011	2015	5
2720	2	2016	2021	12
2720	2	2011	2015	9
2721	2	2016	2021	278
2721	2	2011	2015	267
2722	2	2016	2021	25
2722	2	2011	2015	16
2723	2	2016	2021	31
2723	2	2011	2015	22
2724	2	2016	2021	6
2724	2	2011	2015	5
2725	2	2016	2021	4
2725	2	2011	2015	3
2726	2	2016	2021	12
2726	2	2011	2015	6
2727	2	2016	2021	8
2727	2	2011	2015	11
2728	2	2016	2021	5
2728	2	2011	2015	9
2729	2	2016	2021	13
2729	2	2011	2015	10
2730	2	2016	2021	19
2730	2	2011	2015	8
2731	2	2016	2021	9
2731	2	2011	2015	10
2732	2	2016	2021	117
2732	2	2011	2015	100
2733	2	2016	2021	58
2733	2	2011	2015	66
2734	2	2016	2021	15
2734	2	2011	2015	22
2735	2	2016	2021	6
2735	2	2011	2015	8
2736	2	2016	2021	47
2736	2	2011	2015	59
2737	2	2016	2021	4
2737	2	2011	2015	5
2738	2	2016	2021	62
2738	2	2011	2015	72
2739	2	2016	2021	29
2739	2	2011	2015	24
2740	2	2016	2021	7
2740	2	2011	2015	10
2741	2	2016	2021	87
2741	2	2011	2015	75
2742	2	2016	2021	21
2742	2	2011	2015	27
2743	2	2016	2021	11
2743	2	2011	2015	7
2744	2	2016	2021	161
2744	2	2011	2015	127
2745	2	2016	2021	36
2745	2	2011	2015	33
2746	2	2016	2021	14
2746	2	2011	2015	10
2747	2	2016	2021	7
2747	2	2011	2015	7
2748	2	2016	2021	315
2748	2	2011	2015	276
2749	2	2016	2021	385
2749	2	2011	2015	297
2750	2	2016	2021	26
2750	2	2011	2015	22
2751	2	2016	2021	30
2751	2	2011	2015	27
2752	2	2016	2021	11
2752	2	2011	2015	9
2753	2	2016	2021	16
2753	2	2011	2015	19
2754	2	2016	2021	11
2754	2	2011	2015	8
2755	2	2016	2021	24
2755	2	2011	2015	27
2756	2	2016	2021	0
2756	2	2011	2015	2
2757	2	2016	2021	128
2757	2	2011	2015	125
2758	2	2016	2021	35
2758	2	2011	2015	36
2759	2	2016	2021	18
2759	2	2011	2015	7
2760	2	2016	2021	73
2760	2	2011	2015	64
2761	2	2016	2021	13
2761	2	2011	2015	16
2762	2	2016	2021	18
2762	2	2011	2015	24
2763	2	2016	2021	35
2763	2	2011	2015	28
2764	2	2016	2021	7
2764	2	2011	2015	6
2765	2	2016	2021	64
2765	2	2011	2015	50
2766	2	2016	2021	128
2766	2	2011	2015	103
2767	2	2016	2021	9
2767	2	2011	2015	6
2768	2	2016	2021	130
2768	2	2011	2015	130
2769	2	2016	2021	174
2769	2	2011	2015	176
2770	2	2016	2021	15
2770	2	2011	2015	27
2771	2	2016	2021	84
2771	2	2011	2015	69
2772	2	2016	2021	17
2772	2	2011	2015	14
2773	2	2016	2021	44
2773	2	2011	2015	37
2774	2	2016	2021	44
2774	2	2011	2015	86
2775	2	2016	2021	18
2775	2	2011	2015	12
2776	2	2016	2021	10
2776	2	2011	2015	15
2777	2	2016	2021	92
2777	2	2011	2015	63
2778	2	2016	2021	61
2778	2	2011	2015	53
2779	2	2016	2021	29
2779	2	2011	2015	22
2780	2	2016	2021	2
2780	2	2011	2015	3
2781	2	2016	2021	8
2781	2	2011	2015	11
2782	2	2016	2021	139
2782	2	2011	2015	111
2783	2	2016	2021	52
2783	2	2011	2015	50
2784	2	2016	2021	22
2784	2	2011	2015	16
2785	2	2016	2021	61
2785	2	2011	2015	36
2786	2	2016	2021	211
2786	2	2011	2015	146
2787	2	2016	2021	39
2787	2	2011	2015	31
2788	2	2016	2021	8
2788	2	2011	2015	15
2789	2	2016	2021	5
2789	2	2011	2015	5
2790	2	2016	2021	13
2790	2	2011	2015	15
2791	2	2016	2021	22
2791	2	2011	2015	15
2792	2	2016	2021	72
2792	2	2011	2015	67
2793	2	2016	2021	7
2793	2	2011	2015	8
2794	2	2016	2021	40
2794	2	2011	2015	39
2795	2	2016	2021	87
2795	2	2011	2015	77
2796	2	2016	2021	31
2796	2	2011	2015	18
2797	2	2016	2021	6
2797	2	2011	2015	6
2798	2	2016	2021	22
2798	2	2011	2015	34
2799	2	2016	2021	10
2799	2	2011	2015	6
2800	2	2016	2021	6
2800	2	2011	2015	9
2801	2	2016	2021	11
2801	2	2011	2015	9
2802	2	2016	2021	8
2802	2	2011	2015	9
2803	2	2016	2021	40
2803	2	2011	2015	45
2804	2	2016	2021	5
2804	2	2011	2015	11
2805	2	2016	2021	41
2805	2	2011	2015	24
2806	2	2016	2021	3
2806	2	2011	2015	4
2807	2	2016	2021	19
2807	2	2011	2015	26
2808	2	2016	2021	137
2808	2	2011	2015	108
2809	2	2016	2021	18
2809	2	2011	2015	10
2810	2	2016	2021	8
2810	2	2011	2015	7
2811	2	2016	2021	47
2811	2	2011	2015	45
2812	2	2016	2021	50
2812	2	2011	2015	35
2813	2	2016	2021	9
2813	2	2011	2015	7
2814	2	2016	2021	63
2814	2	2011	2015	56
2815	2	2016	2021	19
2815	2	2011	2015	10
2816	2	2016	2021	30
2816	2	2011	2015	33
2817	2	2016	2021	284
2817	2	2011	2015	233
2818	2	2016	2021	63
2818	2	2011	2015	57
2819	2	2016	2021	34
2819	2	2011	2015	34
2820	2	2016	2021	8
2820	2	2011	2015	12
2821	2	2016	2021	16
2821	2	2011	2015	16
2822	2	2016	2021	5
2822	2	2011	2015	16
2823	2	2016	2021	182
2823	2	2011	2015	194
2824	2	2016	2021	18
2824	2	2011	2015	18
2825	2	2016	2021	17
2825	2	2011	2015	21
2826	2	2016	2021	6
2826	2	2011	2015	5
2827	2	2016	2021	77
2827	2	2011	2015	83
2828	2	2016	2021	35
2828	2	2011	2015	27
2829	2	2016	2021	15
2829	2	2011	2015	19
2830	2	2016	2021	3
2830	2	2011	2015	4
2831	2	2016	2021	20
2831	2	2011	2015	27
2832	2	2016	2021	12
2832	2	2011	2015	12
2833	2	2016	2021	61
2833	2	2011	2015	79
2834	2	2016	2021	11
2834	2	2011	2015	8
2835	2	2016	2021	13
2835	2	2011	2015	20
2836	2	2016	2021	6
2836	2	2011	2015	10
2837	2	2016	2021	11
2837	2	2011	2015	15
2838	2	2016	2021	8
2838	2	2011	2015	9
2839	2	2016	2021	12
2839	2	2011	2015	12
2840	2	2016	2021	10
2840	2	2011	2015	12
2841	2	2016	2021	14
2841	2	2011	2015	26
2842	2	2016	2021	4
2842	2	2011	2015	4
2843	2	2016	2021	56
2843	2	2011	2015	37
2844	2	2016	2021	64
2844	2	2011	2015	61
2845	2	2016	2021	16
2845	2	2011	2015	20
2846	2	2016	2021	23
2846	2	2011	2015	21
2847	2	2016	2021	26
2847	2	2011	2015	28
2848	2	2016	2021	8
2848	2	2011	2015	7
2849	2	2016	2021	23
2849	2	2011	2015	32
2850	2	2016	2021	23
2850	2	2011	2015	12
2851	2	2016	2021	13
2851	2	2011	2015	25
2852	2	2016	2021	3
2852	2	2011	2015	5
2853	2	2016	2021	69
2853	2	2011	2015	85
2854	2	2016	2021	85
2854	2	2011	2015	87
2855	2	2016	2021	5
2855	2	2011	2015	1
2856	2	2016	2021	28
2856	2	2011	2015	33
2857	2	2016	2021	11
2857	2	2011	2015	17
2858	2	2016	2021	24
2858	2	2011	2015	30
2859	2	2016	2021	105
2859	2	2011	2015	99
2860	2	2016	2021	19
2860	2	2011	2015	25
2861	2	2016	2021	209
2861	2	2011	2015	189
2862	2	2016	2021	70
2862	2	2011	2015	59
2863	2	2016	2021	21
2863	2	2011	2015	20
2864	2	2016	2021	8
2864	2	2011	2015	9
2865	2	2016	2021	21
2865	2	2011	2015	21
2866	2	2016	2021	14
2866	2	2011	2015	11
2867	2	2016	2021	20
2867	2	2011	2015	12
2868	2	2016	2021	25
2868	2	2011	2015	19
2869	2	2016	2021	28
2869	2	2011	2015	34
2870	2	2016	2021	50
2870	2	2011	2015	48
2871	2	2016	2021	927
2871	2	2011	2015	916
2872	2	2016	2021	7
2872	2	2011	2015	8
2873	2	2016	2021	73
2873	2	2011	2015	56
2874	2	2016	2021	5
2874	2	2011	2015	6
2875	2	2016	2021	5
2875	2	2011	2015	4
2876	2	2016	2021	5
2876	2	2011	2015	8
2877	2	2016	2021	29
2877	2	2011	2015	29
2878	2	2016	2021	1
2878	2	2011	2015	1
2879	2	2016	2021	69
2879	2	2011	2015	57
2880	2	2016	2021	48
2880	2	2011	2015	60
2881	2	2016	2021	135
2881	2	2011	2015	152
2882	2	2016	2021	61
2882	2	2011	2015	48
2883	2	2016	2021	34
2883	2	2011	2015	24
2884	2	2016	2021	21
2884	2	2011	2015	19
2885	2	2016	2021	38
2885	2	2011	2015	35
2886	2	2016	2021	46
2886	2	2011	2015	38
2887	2	2016	2021	32
2887	2	2011	2015	20
2888	2	2016	2021	106
2888	2	2011	2015	91
2889	2	2016	2021	11
2889	2	2011	2015	7
2890	2	2016	2021	12
2890	2	2011	2015	16
2891	2	2016	2021	18
2891	2	2011	2015	16
2892	2	2016	2021	73
2892	2	2011	2015	82
2893	2	2016	2021	37
2893	2	2011	2015	26
2894	2	2016	2021	10
2894	2	2011	2015	11
2895	2	2016	2021	4
2895	2	2011	2015	7
2896	2	2016	2021	6
2896	2	2011	2015	5
2897	2	2016	2021	8
2897	2	2011	2015	13
2898	2	2016	2021	90
2898	2	2011	2015	103
2899	2	2016	2021	32
2899	2	2011	2015	39
2900	2	2016	2021	17
2900	2	2011	2015	14
2901	2	2016	2021	8
2901	2	2011	2015	9
2902	2	2016	2021	5
2902	2	2011	2015	6
2903	2	2016	2021	27
2903	2	2011	2015	24
2904	2	2016	2021	47
2904	2	2011	2015	38
2905	2	2016	2021	1
2905	2	2011	2015	4
2906	2	2016	2021	9
2906	2	2011	2015	10
2907	2	2016	2021	10
2907	2	2011	2015	12
2908	2	2016	2021	323
2908	2	2011	2015	325
2909	2	2016	2021	11
2909	2	2011	2015	14
2910	2	2016	2021	17
2910	2	2011	2015	12
2911	2	2016	2021	15
2911	2	2011	2015	17
2912	2	2016	2021	15
2912	2	2011	2015	14
2913	2	2016	2021	1
2913	2	2011	2015	3
2914	2	2016	2021	520
2914	2	2011	2015	492
2915	2	2016	2021	14
2915	2	2011	2015	14
2916	2	2016	2021	97
2916	2	2011	2015	102
2917	2	2016	2021	5
2917	2	2011	2015	12
2918	2	2016	2021	7
2918	2	2011	2015	4
2919	2	2016	2021	20
2919	2	2011	2015	22
2920	2	2016	2021	14
2920	2	2011	2015	8
2921	2	2016	2021	7
2921	2	2011	2015	5
2922	2	2016	2021	203
2922	2	2011	2015	172
2923	2	2016	2021	114
2923	2	2011	2015	98
2924	2	2016	2021	8
2924	2	2011	2015	13
2925	2	2016	2021	18
2925	2	2011	2015	16
2926	2	2016	2021	56
2926	2	2011	2015	40
2927	2	2016	2021	49
2927	2	2011	2015	29
2928	2	2016	2021	190
2928	2	2011	2015	142
2929	2	2016	2021	35
2929	2	2011	2015	42
2930	2	2016	2021	34
2930	2	2011	2015	50
2931	2	2016	2021	4
2931	2	2011	2015	8
2932	2	2016	2021	9
2932	2	2011	2015	9
2933	2	2016	2021	27
2933	2	2011	2015	20
2934	2	2016	2021	20
2934	2	2011	2015	32
2935	2	2016	2021	16
2935	2	2011	2015	14
2936	2	2016	2021	5
2936	2	2011	2015	3
2937	2	2016	2021	2
2937	2	2011	2015	2
2938	2	2016	2021	113
2938	2	2011	2015	95
2939	2	2016	2021	19
2939	2	2011	2015	23
2940	2	2016	2021	7
2940	2	2011	2015	8
2941	2	2016	2021	44
2941	2	2011	2015	42
2942	2	2016	2021	5
2942	2	2011	2015	13
2943	2	2016	2021	21
2943	2	2011	2015	19
2944	2	2016	2021	5
2944	2	2011	2015	7
2945	2	2016	2021	24
2945	2	2011	2015	21
2946	2	2016	2021	176
2946	2	2011	2015	133
2947	2	2016	2021	42
2947	2	2011	2015	30
2948	2	2016	2021	16
2948	2	2011	2015	11
2949	2	2016	2021	3
2949	2	2011	2015	5
2950	2	2016	2021	28
2950	2	2011	2015	24
2951	2	2016	2021	74
2951	2	2011	2015	79
2952	2	2016	2021	46
2952	2	2011	2015	33
2953	2	2016	2021	10
2953	2	2011	2015	9
2954	2	2016	2021	34
2954	2	2011	2015	19
2955	2	2016	2021	11
2955	2	2011	2015	19
2956	2	2016	2021	22
2956	2	2011	2015	27
2957	2	2016	2021	4
2957	2	2011	2015	6
2958	2	2016	2021	91
2958	2	2011	2015	80
2959	2	2016	2021	11
2959	2	2011	2015	13
2960	2	2016	2021	43
2960	2	2011	2015	32
2961	2	2016	2021	21
2961	2	2011	2015	21
2962	2	2016	2021	3
2962	2	2011	2015	6
2963	2	2016	2021	14
2963	2	2011	2015	12
2964	2	2016	2021	484
2964	2	2011	2015	371
2965	2	2016	2021	51
2965	2	2011	2015	30
2966	2	2016	2021	12
2966	2	2011	2015	14
2967	2	2016	2021	4
2967	2	2011	2015	6
2968	2	2016	2021	3
2968	2	2011	2015	1
2969	2	2016	2021	46
2969	2	2011	2015	10
2970	2	2016	2021	7
2970	2	2011	2015	15
2971	2	2016	2021	4
2971	2	2011	2015	4
2972	2	2016	2021	23
2972	2	2011	2015	22
2973	2	2016	2021	23
2973	2	2011	2015	16
2974	2	2016	2021	27
2974	2	2011	2015	28
2975	2	2016	2021	38
2975	2	2011	2015	36
2976	2	2016	2021	17
2976	2	2011	2015	19
2977	2	2016	2021	3
2977	2	2011	2015	4
2978	2	2016	2021	17
2978	2	2011	2015	20
2979	2	2016	2021	46
2979	2	2011	2015	31
2980	2	2016	2021	14
2980	2	2011	2015	13
2981	2	2016	2021	8
2981	2	2011	2015	11
2982	2	2016	2021	12
2982	2	2011	2015	6
2983	2	2016	2021	18
2983	2	2011	2015	20
2984	2	2016	2021	11
2984	2	2011	2015	7
2985	2	2016	2021	13
2985	2	2011	2015	16
2986	2	2016	2021	18
2986	2	2011	2015	18
2987	2	2016	2021	8
2987	2	2011	2015	14
2988	2	2016	2021	28
2988	2	2011	2015	16
2989	2	2016	2021	96
2989	2	2011	2015	102
2990	2	2016	2021	12
2990	2	2011	2015	11
2991	2	2016	2021	6
2991	2	2011	2015	9
2992	2	2016	2021	58
2992	2	2011	2015	72
2993	2	2016	2021	6
2993	2	2011	2015	6
2994	2	2016	2021	30
2994	2	2011	2015	19
2995	2	2016	2021	3
2995	2	2011	2015	4
2996	2	2016	2021	9
2996	2	2011	2015	9
2997	2	2016	2021	30
2997	2	2011	2015	34
2998	2	2016	2021	21
2998	2	2011	2015	32
2999	2	2016	2021	32
2999	2	2011	2015	24
3000	2	2016	2021	48
3000	2	2011	2015	34
3001	2	2016	2021	14
3001	2	2011	2015	16
3002	2	2016	2021	19
3002	2	2011	2015	26
3003	2	2016	2021	14
3003	2	2011	2015	9
3004	2	2016	2021	24
3004	2	2011	2015	23
3005	2	2016	2021	8
3005	2	2011	2015	4
3006	2	2016	2021	9
3006	2	2011	2015	8
3007	2	2016	2021	9
3007	2	2011	2015	11
3008	2	2016	2021	11
3008	2	2011	2015	4
3009	2	2016	2021	57
3009	2	2011	2015	73
3010	2	2016	2021	65
3010	2	2011	2015	55
3011	2	2016	2021	13
3011	2	2011	2015	19
3012	2	2016	2021	13
3012	2	2011	2015	10
3013	2	2016	2021	6
3013	2	2011	2015	1
3014	2	2016	2021	24
3014	2	2011	2015	29
3015	2	2016	2021	66
3015	2	2011	2015	42
3016	2	2016	2021	7
3016	2	2011	2015	5
3017	2	2016	2021	13
3017	2	2011	2015	15
3018	2	2016	2021	27
3018	2	2011	2015	25
3019	2	2016	2021	524
3019	2	2011	2015	499
3020	2	2016	2021	7
3020	2	2011	2015	6
3021	2	2016	2021	20
3021	2	2011	2015	28
3022	2	2016	2021	10
3022	2	2011	2015	7
3023	2	2016	2021	25
3023	2	2011	2015	27
3024	2	2016	2021	49
3024	2	2011	2015	32
3025	2	2016	2021	28
3025	2	2011	2015	26
3026	2	2016	2021	30
3026	2	2011	2015	32
3027	2	2016	2021	42
3027	2	2011	2015	36
3028	2	2016	2021	11
3028	2	2011	2015	5
3029	2	2016	2021	19
3029	2	2011	2015	20
3030	2	2016	2021	17
3030	2	2011	2015	28
3031	2	2016	2021	1383
3031	2	2011	2015	1264
3032	2	2016	2021	35
3032	2	2011	2015	37
3033	2	2016	2021	27
3033	2	2011	2015	19
3034	2	2016	2021	82
3034	2	2011	2015	81
3035	2	2016	2021	20
3035	2	2011	2015	15
3036	2	2016	2021	25
3036	2	2011	2015	25
3037	2	2016	2021	12
3037	2	2011	2015	6
3038	2	2016	2021	8
3038	2	2011	2015	14
3039	2	2016	2021	6
3039	2	2011	2015	4
3040	2	2016	2021	3
3040	2	2011	2015	3
3041	2	2016	2021	33
3041	2	2011	2015	32
3042	2	2016	2021	11
3042	2	2011	2015	15
3043	2	2016	2021	60
3043	2	2011	2015	44
3044	2	2016	2021	9
3044	2	2011	2015	7
3045	2	2016	2021	119
3045	2	2011	2015	127
3046	2	2016	2021	34
3046	2	2011	2015	25
3047	2	2016	2021	1
3047	2	2011	2015	3
3048	2	2016	2021	9
3048	2	2011	2015	3
3049	2	2016	2021	10
3049	2	2011	2015	5
3050	2	2016	2021	35
3050	2	2011	2015	50
3051	2	2016	2021	5
3051	2	2011	2015	11
3052	2	2016	2021	20
3052	2	2011	2015	8
3053	2	2016	2021	20
3053	2	2011	2015	14
3054	2	2016	2021	26
3054	2	2011	2015	21
3055	2	2016	2021	8
3055	2	2011	2015	9
3056	2	2016	2021	36
3056	2	2011	2015	29
3057	2	2016	2021	7
3057	2	2011	2015	5
3058	2	2016	2021	47
3058	2	2011	2015	32
3059	2	2016	2021	1867
3059	2	2011	2015	1565
3060	2	2016	2021	2
3060	2	2011	2015	2
3061	2	2016	2021	25
3061	2	2011	2015	24
3062	2	2016	2021	15
3062	2	2011	2015	8
3063	2	2016	2021	4
3063	2	2011	2015	8
3064	2	2016	2021	24
3064	2	2011	2015	30
3065	2	2016	2021	14
3065	2	2011	2015	9
3066	2	2016	2021	11
3066	2	2011	2015	5
3067	2	2016	2021	9
3067	2	2011	2015	11
3068	2	2016	2021	17
3068	2	2011	2015	12
3069	2	2016	2021	118
3069	2	2011	2015	101
3070	2	2016	2021	12
3070	2	2011	2015	17
3071	2	2016	2021	66
3071	2	2011	2015	64
3072	2	2016	2021	141
3072	2	2011	2015	118
3073	2	2016	2021	9
3073	2	2011	2015	12
3074	2	2016	2021	47
3074	2	2011	2015	34
3075	2	2016	2021	53
3075	2	2011	2015	26
3076	2	2016	2021	27
3076	2	2011	2015	26
3077	2	2016	2021	13
3077	2	2011	2015	11
3078	2	2016	2021	3
3078	2	2011	2015	5
3079	2	2016	2021	4
3079	2	2011	2015	4
3080	2	2016	2021	18
3080	2	2011	2015	24
3081	2	2016	2021	15
3081	2	2011	2015	10
3082	2	2016	2021	10
3082	2	2011	2015	17
3083	2	2016	2021	7
3083	2	2011	2015	10
3084	2	2016	2021	5
3084	2	2011	2015	6
3085	2	2016	2021	17
3085	2	2011	2015	17
3086	2	2016	2021	3
3086	2	2011	2015	5
3087	2	2016	2021	10
3087	2	2011	2015	4
3088	2	2016	2021	38
3088	2	2011	2015	43
3089	2	2016	2021	2
3089	2	2011	2015	3
3090	2	2016	2021	94
3090	2	2011	2015	78
3091	2	2016	2021	14
3091	2	2011	2015	24
3092	2	2016	2021	60
3092	2	2011	2015	63
3093	2	2016	2021	109
3093	2	2011	2015	63
3094	2	2016	2021	189
3094	2	2011	2015	195
3095	2	2016	2021	100
3095	2	2011	2015	71
3096	2	2016	2021	56
3096	2	2011	2015	53
3097	2	2016	2021	19
3097	2	2011	2015	15
3098	2	2016	2021	223
3098	2	2011	2015	204
3099	2	2016	2021	14
3099	2	2011	2015	13
3100	2	2016	2021	105
3100	2	2011	2015	86
3101	2	2016	2021	89
3101	2	2011	2015	123
3102	2	2016	2021	9
3102	2	2011	2015	9
3103	2	2016	2021	21
3103	2	2011	2015	16
3104	2	2016	2021	10
3104	2	2011	2015	10
3105	2	2016	2021	20
3105	2	2011	2015	17
3106	2	2016	2021	12
3106	2	2011	2015	11
3107	2	2016	2021	0
3107	2	2011	2015	1
3108	2	2016	2021	10
3108	2	2011	2015	16
3109	2	2016	2021	11
3109	2	2011	2015	17
3110	2	2016	2021	14
3110	2	2011	2015	6
3111	2	2016	2021	6
3111	2	2011	2015	3
3112	2	2016	2021	48
3112	2	2011	2015	33
3113	2	2016	2021	11
3113	2	2011	2015	10
3114	2	2016	2021	15
3114	2	2011	2015	10
3115	2	2016	2021	13
3115	2	2011	2015	12
3116	2	2016	2021	6
3116	2	2011	2015	4
3117	2	2016	2021	5
3117	2	2011	2015	6
3118	2	2016	2021	63
3118	2	2011	2015	61
3119	2	2016	2021	41
3119	2	2011	2015	36
3120	2	2016	2021	11
3120	2	2011	2015	25
3121	2	2016	2021	10
3121	2	2011	2015	12
3122	2	2016	2021	3
3122	2	2011	2015	7
3123	2	2016	2021	37
3123	2	2011	2015	29
3124	2	2016	2021	19
3124	2	2011	2015	13
3125	2	2016	2021	23
3125	2	2011	2015	20
3126	2	2016	2021	101
3126	2	2011	2015	93
3127	2	2016	2021	36
3127	2	2011	2015	37
3128	2	2016	2021	11
3128	2	2011	2015	8
3129	2	2016	2021	41
3129	2	2011	2015	29
3130	2	2016	2021	4
3130	2	2011	2015	1
3131	2	2016	2021	5
3131	2	2011	2015	2
3132	2	2016	2021	204
3132	2	2011	2015	127
3133	2	2016	2021	34
3133	2	2011	2015	25
3134	2	2016	2021	3124
3134	2	2011	2015	2680
3135	2	2016	2021	10
3135	2	2011	2015	10
3136	2	2016	2021	21
3136	2	2011	2015	16
3137	2	2016	2021	12
3137	2	2011	2015	10
3138	2	2016	2021	25
3138	2	2011	2015	25
3139	2	2016	2021	3
3139	2	2011	2015	0
3140	2	2016	2021	43
3140	2	2011	2015	45
3141	2	2016	2021	94
3141	2	2011	2015	87
3142	2	2016	2021	22
3142	2	2011	2015	9
3143	2	2016	2021	4
3143	2	2011	2015	6
3144	2	2016	2021	20
3144	2	2011	2015	15
3145	2	2016	2021	1
3145	2	2011	2015	7
3146	2	2016	2021	27
3146	2	2011	2015	22
3147	2	2016	2021	10
3147	2	2011	2015	8
3148	2	2016	2021	12
3148	2	2011	2015	8
3149	2	2016	2021	11
3149	2	2011	2015	5
3150	2	2016	2021	0
3150	2	2011	2015	0
3151	2	2016	2021	49
3151	2	2011	2015	20
3152	2	2016	2021	31
3152	2	2011	2015	24
3153	2	2016	2021	12
3153	2	2011	2015	9
3154	2	2016	2021	918
3154	2	2011	2015	770
3155	2	2016	2021	65
3155	2	2011	2015	77
3156	2	2016	2021	29
3156	2	2011	2015	32
3157	2	2016	2021	439
3157	2	2011	2015	402
3158	2	2016	2021	34
3158	2	2011	2015	34
3159	2	2016	2021	17
3159	2	2011	2015	13
3160	2	2016	2021	3
3160	2	2011	2015	9
3161	2	2016	2021	887
3161	2	2011	2015	864
3162	2	2016	2021	47
3162	2	2011	2015	54
3163	2	2016	2021	22
3163	2	2011	2015	19
3164	2	2016	2021	218
3164	2	2011	2015	201
3165	2	2016	2021	82
3165	2	2011	2015	60
3166	2	2016	2021	21
3166	2	2011	2015	17
3167	2	2016	2021	27
3167	2	2011	2015	45
3168	2	2016	2021	4
3168	2	2011	2015	6
3169	2	2016	2021	34
3169	2	2011	2015	21
3170	2	2016	2021	173
3170	2	2011	2015	136
3171	2	2016	2021	42
3171	2	2011	2015	42
3172	2	2016	2021	487
3172	2	2011	2015	421
3173	2	2016	2021	17
3173	2	2011	2015	13
3174	2	2016	2021	56
3174	2	2011	2015	50
3175	2	2016	2021	9
3175	2	2011	2015	12
3176	2	2016	2021	9
3176	2	2011	2015	11
3177	2	2016	2021	33
3177	2	2011	2015	28
3178	2	2016	2021	28
3178	2	2011	2015	7
3179	2	2016	2021	156
3179	2	2011	2015	157
3180	2	2016	2021	36
3180	2	2011	2015	31
3181	2	2016	2021	8
3181	2	2011	2015	14
3182	2	2016	2021	12
3182	2	2011	2015	9
3183	2	2016	2021	2
3183	2	2011	2015	6
3184	2	2016	2021	107
3184	2	2011	2015	81
3185	2	2016	2021	7
3185	2	2011	2015	1
3186	2	2016	2021	16
3186	2	2011	2015	18
3187	2	2016	2021	6
3187	2	2011	2015	10
3188	2	2016	2021	24
3188	2	2011	2015	22
3189	2	2016	2021	51
3189	2	2011	2015	44
3190	2	2016	2021	8
3190	2	2011	2015	8
3191	2	2016	2021	5
3191	2	2011	2015	6
3192	2	2016	2021	286
3192	2	2011	2015	294
3193	2	2016	2021	41
3193	2	2011	2015	38
3194	2	2016	2021	5
3194	2	2011	2015	6
3195	2	2016	2021	16
3195	2	2011	2015	20
3196	2	2016	2021	9
3196	2	2011	2015	6
3197	2	2016	2021	9
3197	2	2011	2015	17
3198	2	2016	2021	28
3198	2	2011	2015	37
3199	2	2016	2021	9
3199	2	2011	2015	4
3200	2	2016	2021	26
3200	2	2011	2015	15
3201	2	2016	2021	19
3201	2	2011	2015	23
3202	2	2016	2021	10
3202	2	2011	2015	8
3203	2	2016	2021	3
3203	2	2011	2015	0
3204	2	2016	2021	6
3204	2	2011	2015	2
3205	2	2016	2021	3
3205	2	2011	2015	11
3206	2	2016	2021	38
3206	2	2011	2015	30
3207	2	2016	2021	14
3207	2	2011	2015	20
3208	2	2016	2021	5
3208	2	2011	2015	4
3209	2	2016	2021	12
3209	2	2011	2015	8
3210	2	2016	2021	14
3210	2	2011	2015	17
3211	2	2016	2021	5
3211	2	2011	2015	9
3212	2	2016	2021	52
3212	2	2011	2015	21
3213	2	2016	2021	43
3213	2	2011	2015	39
3214	2	2016	2021	3
3214	2	2011	2015	1
3215	2	2016	2021	11
3215	2	2011	2015	11
3216	2	2016	2021	10
3216	2	2011	2015	8
3217	2	2016	2021	49
3217	2	2011	2015	55
3218	2	2016	2021	264
3218	2	2011	2015	281
3219	2	2016	2021	8
3219	2	2011	2015	14
3220	2	2016	2021	100
3220	2	2011	2015	100
3221	2	2016	2021	4
3221	2	2011	2015	3
3222	2	2016	2021	1
3222	2	2011	2015	4
3223	2	2016	2021	13
3223	2	2011	2015	20
3224	2	2016	2021	4
3224	2	2011	2015	2
3225	2	2016	2021	3
3225	2	2011	2015	4
3226	2	2016	2021	7
3226	2	2011	2015	11
3227	2	2016	2021	107
3227	2	2011	2015	75
3228	2	2016	2021	8
3228	2	2011	2015	2
3229	2	2016	2021	8
3229	2	2011	2015	7
3230	2	2016	2021	18
3230	2	2011	2015	9
3231	2	2016	2021	27
3231	2	2011	2015	19
3232	2	2016	2021	17
3232	2	2011	2015	16
3233	2	2016	2021	7
3233	2	2011	2015	7
3234	2	2016	2021	12
3234	2	2011	2015	12
3235	2	2016	2021	7
3235	2	2011	2015	7
3236	2	2016	2021	35
3236	2	2011	2015	21
3237	2	2016	2021	37
3237	2	2011	2015	25
3238	2	2016	2021	11
3238	2	2011	2015	19
3239	2	2016	2021	1
3239	2	2011	2015	3
3240	2	2016	2021	36
3240	2	2011	2015	22
3241	2	2016	2021	12
3241	2	2011	2015	9
3242	2	2016	2021	99
3242	2	2011	2015	111
3243	2	2016	2021	26
3243	2	2011	2015	19
3244	2	2016	2021	4
3244	2	2011	2015	2
3245	2	2016	2021	78
3245	2	2011	2015	52
3246	2	2016	2021	16
3246	2	2011	2015	18
3247	2	2016	2021	22
3247	2	2011	2015	16
3248	2	2016	2021	7
3248	2	2011	2015	22
3249	2	2016	2021	13
3249	2	2011	2015	19
3250	2	2016	2021	3
3250	2	2011	2015	3
3251	2	2016	2021	1
3251	2	2011	2015	5
3252	2	2016	2021	3
3252	2	2011	2015	2
3253	2	2016	2021	26
3253	2	2011	2015	23
3254	2	2016	2021	30
3254	2	2011	2015	17
3255	2	2016	2021	15
3255	2	2011	2015	14
3256	2	2016	2021	36
3256	2	2011	2015	30
3257	2	2016	2021	15
3257	2	2011	2015	17
3258	2	2016	2021	5
3258	2	2011	2015	9
3259	2	2016	2021	280
3259	2	2011	2015	239
3260	2	2016	2021	12
3260	2	2011	2015	15
3261	2	2016	2021	15
3261	2	2011	2015	14
3262	2	2016	2021	73
3262	2	2011	2015	68
3263	2	2016	2021	12
3263	2	2011	2015	21
3264	2	2016	2021	20
3264	2	2011	2015	6
3265	2	2016	2021	3
3265	2	2011	2015	1
3266	2	2016	2021	203
3266	2	2011	2015	161
3267	2	2016	2021	120
3267	2	2011	2015	79
3268	2	2016	2021	15
3268	2	2011	2015	10
3269	2	2016	2021	3
3269	2	2011	2015	8
3270	2	2016	2021	31
3270	2	2011	2015	20
3271	2	2016	2021	4
3271	2	2011	2015	4
3272	2	2016	2021	22
3272	2	2011	2015	23
3273	2	2016	2021	14
3273	2	2011	2015	12
3274	2	2016	2021	27
3274	2	2011	2015	24
3275	2	2016	2021	22
3275	2	2011	2015	22
3276	2	2016	2021	12
3276	2	2011	2015	13
3277	2	2016	2021	79
3277	2	2011	2015	62
3278	2	2016	2021	62
3278	2	2011	2015	62
3279	2	2016	2021	9
3279	2	2011	2015	11
3280	2	2016	2021	38
3280	2	2011	2015	24
3281	2	2016	2021	14
3281	2	2011	2015	12
3282	2	2016	2021	33
3282	2	2011	2015	28
3283	2	2016	2021	30
3283	2	2011	2015	38
3284	2	2016	2021	441
3284	2	2011	2015	394
3285	2	2016	2021	16
3285	2	2011	2015	16
3286	2	2016	2021	4
3286	2	2011	2015	2
3287	2	2016	2021	54
3287	2	2011	2015	41
3288	2	2016	2021	680
3288	2	2011	2015	624
3289	2	2016	2021	14
3289	2	2011	2015	17
3290	2	2016	2021	14
3290	2	2011	2015	10
3291	2	2016	2021	7
3291	2	2011	2015	7
3292	2	2016	2021	3
3292	2	2011	2015	6
3293	2	2016	2021	6
3293	2	2011	2015	8
3294	2	2016	2021	13
3294	2	2011	2015	16
3295	2	2016	2021	6
3295	2	2011	2015	2
3296	2	2016	2021	14
3296	2	2011	2015	10
3297	2	2016	2021	249
3297	2	2011	2015	216
3298	2	2016	2021	35
3298	2	2011	2015	35
3299	2	2016	2021	20
3299	2	2011	2015	25
3300	2	2016	2021	8
3300	2	2011	2015	9
3301	2	2016	2021	53
3301	2	2011	2015	47
3302	2	2016	2021	13
3302	2	2011	2015	20
3303	2	2016	2021	22
3303	2	2011	2015	35
3304	2	2016	2021	7
3304	2	2011	2015	12
3305	2	2016	2021	30
3305	2	2011	2015	31
3306	2	2016	2021	133
3306	2	2011	2015	92
3307	2	2016	2021	11
3307	2	2011	2015	24
3308	2	2016	2021	2
3308	2	2011	2015	5
3309	2	2016	2021	60
3309	2	2011	2015	52
3310	2	2016	2021	12
3310	2	2011	2015	20
3311	2	2016	2021	319
3311	2	2011	2015	329
3312	2	2016	2021	12
3312	2	2011	2015	6
3313	2	2016	2021	18
3313	2	2011	2015	12
3314	2	2016	2021	4
3314	2	2011	2015	7
3315	2	2016	2021	40
3315	2	2011	2015	27
3316	2	2016	2021	57
3316	2	2011	2015	42
3317	2	2016	2021	38
3317	2	2011	2015	43
3318	2	2016	2021	16
3318	2	2011	2015	12
3319	2	2016	2021	17
3319	2	2011	2015	11
3320	2	2016	2021	7
3320	2	2011	2015	12
3321	2	2016	2021	4
3321	2	2011	2015	4
3322	2	2016	2021	4
3322	2	2011	2015	9
3323	2	2016	2021	9
3323	2	2011	2015	8
3324	2	2016	2021	13
3324	2	2011	2015	10
3325	2	2016	2021	2
3325	2	2011	2015	6
3326	2	2016	2021	9
3326	2	2011	2015	8
3327	2	2016	2021	41
3327	2	2011	2015	45
3328	2	2016	2021	44
3328	2	2011	2015	51
3329	2	2016	2021	26
3329	2	2011	2015	21
3330	2	2016	2021	5
3330	2	2011	2015	7
3331	2	2016	2021	180
3331	2	2011	2015	119
3332	2	2016	2021	40
3332	2	2011	2015	19
3333	2	2016	2021	32
3333	2	2011	2015	15
3334	2	2016	2021	8
3334	2	2011	2015	10
3335	2	2016	2021	16
3335	2	2011	2015	14
3336	2	2016	2021	14
3336	2	2011	2015	12
3337	2	2016	2021	25
3337	2	2011	2015	18
3338	2	2016	2021	6
3338	2	2011	2015	7
3339	2	2016	2021	13
3339	2	2011	2015	19
3340	2	2016	2021	12
3340	2	2011	2015	15
3341	2	2016	2021	20
3341	2	2011	2015	25
3342	2	2016	2021	58
3342	2	2011	2015	52
3343	2	2016	2021	12
3343	2	2011	2015	6
3344	2	2016	2021	132
3344	2	2011	2015	127
3345	2	2016	2021	14
3345	2	2011	2015	15
3346	2	2016	2021	4
3346	2	2011	2015	6
3347	2	2016	2021	47
3347	2	2011	2015	51
3348	2	2016	2021	12
3348	2	2011	2015	12
3349	2	2016	2021	15
3349	2	2011	2015	20
3350	2	2016	2021	2
3350	2	2011	2015	7
3351	2	2016	2021	93
3351	2	2011	2015	104
3352	2	2016	2021	12
3352	2	2011	2015	14
3353	2	2016	2021	7
3353	2	2011	2015	5
3354	2	2016	2021	6
3354	2	2011	2015	6
3355	2	2016	2021	38
3355	2	2011	2015	48
3356	2	2016	2021	55
3356	2	2011	2015	44
3357	2	2016	2021	4
3357	2	2011	2015	9
3358	2	2016	2021	33
3358	2	2011	2015	34
3359	2	2016	2021	14
3359	2	2011	2015	10
3360	2	2016	2021	6
3360	2	2011	2015	8
3361	2	2016	2021	425
3361	2	2011	2015	425
3362	2	2016	2021	6
3362	2	2011	2015	1
3363	2	2016	2021	6
3363	2	2011	2015	10
3364	2	2016	2021	9
3364	2	2011	2015	11
3365	2	2016	2021	23
3365	2	2011	2015	42
3366	2	2016	2021	5
3366	2	2011	2015	2
3367	2	2016	2021	5
3367	2	2011	2015	2
3368	2	2016	2021	10
3368	2	2011	2015	5
3369	2	2016	2021	43
3369	2	2011	2015	51
3370	2	2016	2021	17
3370	2	2011	2015	13
3371	2	2016	2021	16
3371	2	2011	2015	13
3372	2	2016	2021	9
3372	2	2011	2015	13
3373	2	2016	2021	21
3373	2	2011	2015	17
3374	2	2016	2021	789
3374	2	2011	2015	618
3375	2	2016	2021	24
3375	2	2011	2015	20
3376	2	2016	2021	54
3376	2	2011	2015	61
3377	2	2016	2021	4
3377	2	2011	2015	8
3378	2	2016	2021	28
3378	2	2011	2015	13
3379	2	2016	2021	47
3379	2	2011	2015	34
3380	2	2016	2021	2
3380	2	2011	2015	4
3381	2	2016	2021	13
3381	2	2011	2015	13
3382	2	2016	2021	7
3382	2	2011	2015	3
3383	2	2016	2021	3
3383	2	2011	2015	1
3384	2	2016	2021	13
3384	2	2011	2015	7
3385	2	2016	2021	40
3385	2	2011	2015	39
3386	2	2016	2021	7
3386	2	2011	2015	6
3387	2	2016	2021	5
3387	2	2011	2015	16
3388	2	2016	2021	16
3388	2	2011	2015	24
3389	2	2016	2021	14
3389	2	2011	2015	21
3390	2	2016	2021	39
3390	2	2011	2015	40
3391	2	2016	2021	15
3391	2	2011	2015	19
3392	2	2016	2021	8
3392	2	2011	2015	6
3393	2	2016	2021	45
3393	2	2011	2015	39
3394	2	2016	2021	11
3394	2	2011	2015	8
3395	2	2016	2021	8
3395	2	2011	2015	8
3396	2	2016	2021	39
3396	2	2011	2015	18
3397	2	2016	2021	129
3397	2	2011	2015	126
3398	2	2016	2021	3
3398	2	2011	2015	5
3399	2	2016	2021	63
3399	2	2011	2015	68
3400	2	2016	2021	75
3400	2	2011	2015	66
3401	2	2016	2021	19
3401	2	2011	2015	18
3402	2	2016	2021	49
3402	2	2011	2015	39
3403	2	2016	2021	42
3403	2	2011	2015	55
3404	2	2016	2021	7
3404	2	2011	2015	10
3405	2	2016	2021	8
3405	2	2011	2015	6
3406	2	2016	2021	10
3406	2	2011	2015	13
3407	2	2016	2021	8
3407	2	2011	2015	4
3408	2	2016	2021	15
3408	2	2011	2015	14
3409	2	2016	2021	6
3409	2	2011	2015	7
3410	2	2016	2021	23
3410	2	2011	2015	20
3411	2	2016	2021	69
3411	2	2011	2015	68
3412	2	2016	2021	44
3412	2	2011	2015	37
3413	2	2016	2021	2
3413	2	2011	2015	4
3414	2	2016	2021	24
3414	2	2011	2015	20
3415	2	2016	2021	5
3415	2	2011	2015	5
3416	2	2016	2021	12
3416	2	2011	2015	14
3417	2	2016	2021	4
3417	2	2011	2015	0
3418	2	2016	2021	226
3418	2	2011	2015	206
3419	2	2016	2021	3
3419	2	2011	2015	1
3420	2	2016	2021	10
3420	2	2011	2015	8
3421	2	2016	2021	63
3421	2	2011	2015	59
3422	2	2016	2021	6
3422	2	2011	2015	5
3423	2	2016	2021	11
3423	2	2011	2015	12
3424	2	2016	2021	120
3424	2	2011	2015	92
3425	2	2016	2021	64
3425	2	2011	2015	59
3426	2	2016	2021	8
3426	2	2011	2015	4
3427	2	2016	2021	8
3427	2	2011	2015	7
3428	2	2016	2021	12
3428	2	2011	2015	7
3429	2	2016	2021	236
3429	2	2011	2015	193
3430	2	2016	2021	32
3430	2	2011	2015	29
3431	2	2016	2021	297
3431	2	2011	2015	208
3432	2	2016	2021	1
3432	2	2011	2015	6
3433	2	2016	2021	39
3433	2	2011	2015	51
3434	2	2016	2021	320
3434	2	2011	2015	358
3435	2	2016	2021	10
3435	2	2011	2015	8
3436	2	2016	2021	2
3436	2	2011	2015	3
3437	2	2016	2021	58
3437	2	2011	2015	59
3438	2	2016	2021	4
3438	2	2011	2015	4
3439	2	2016	2021	94
3439	2	2011	2015	76
3440	2	2016	2021	58
3440	2	2011	2015	46
3441	2	2016	2021	143
3441	2	2011	2015	129
3442	2	2016	2021	7
3442	2	2011	2015	3
3443	2	2016	2021	100
3443	2	2011	2015	115
3444	2	2016	2021	9
3444	2	2011	2015	14
3445	2	2016	2021	42
3445	2	2011	2015	55
3446	2	2016	2021	433
3446	2	2011	2015	478
3447	2	2016	2021	10
3447	2	2011	2015	11
3448	2	2016	2021	18
3448	2	2011	2015	17
3449	2	2016	2021	32
3449	2	2011	2015	39
3450	2	2016	2021	14
3450	2	2011	2015	11
3451	2	2016	2021	6
3451	2	2011	2015	6
3452	2	2016	2021	5
3452	2	2011	2015	3
3453	2	2016	2021	6
3453	2	2011	2015	8
3454	2	2016	2021	436
3454	2	2011	2015	398
3455	2	2016	2021	31
3455	2	2011	2015	24
3456	2	2016	2021	3
3456	2	2011	2015	1
3457	2	2016	2021	8
3457	2	2011	2015	12
3458	2	2016	2021	5
3458	2	2011	2015	3
3459	2	2016	2021	13
3459	2	2011	2015	8
3460	2	2016	2021	62
3460	2	2011	2015	36
3461	2	2016	2021	6
3461	2	2011	2015	4
3462	2	2016	2021	36
3462	2	2011	2015	34
3463	2	2016	2021	82
3463	2	2011	2015	71
3464	2	2016	2021	9
3464	2	2011	2015	13
3465	2	2016	2021	9
3465	2	2011	2015	17
3466	2	2016	2021	22
3466	2	2011	2015	17
3467	2	2016	2021	57
3467	2	2011	2015	35
3468	2	2016	2021	22
3468	2	2011	2015	23
3469	2	2016	2021	4674
3469	2	2011	2015	4305
3470	2	2016	2021	6
3470	2	2011	2015	5
3471	2	2016	2021	10
3471	2	2011	2015	3
3472	2	2016	2021	111
3472	2	2011	2015	88
3473	2	2016	2021	4
3473	2	2011	2015	8
3474	2	2016	2021	14
3474	2	2011	2015	19
3475	2	2016	2021	5
3475	2	2011	2015	9
3476	2	2016	2021	19
3476	2	2011	2015	18
3477	2	2016	2021	124
3477	2	2011	2015	127
3478	2	2016	2021	15
3478	2	2011	2015	11
3479	2	2016	2021	9
3479	2	2011	2015	2
3480	2	2016	2021	3
3480	2	2011	2015	1
3481	2	2016	2021	10
3481	2	2011	2015	7
3482	2	2016	2021	16
3482	2	2011	2015	14
3483	2	2016	2021	2
3483	2	2011	2015	11
3484	2	2016	2021	14
3484	2	2011	2015	23
3485	2	2016	2021	61
3485	2	2011	2015	77
3486	2	2016	2021	13
3486	2	2011	2015	22
3487	2	2016	2021	37
3487	2	2011	2015	31
3488	2	2016	2021	2
3488	2	2011	2015	2
3489	2	2016	2021	16
3489	2	2011	2015	7
3490	2	2016	2021	13
3490	2	2011	2015	6
3491	2	2016	2021	48
3491	2	2011	2015	45
3492	2	2016	2021	7
3492	2	2011	2015	1
3493	2	2016	2021	14
3493	2	2011	2015	14
3494	2	2016	2021	39
3494	2	2011	2015	34
3495	2	2016	2021	18
3495	2	2011	2015	12
3496	2	2016	2021	46
3496	2	2011	2015	39
3497	2	2016	2021	12
3497	2	2011	2015	21
3498	2	2016	2021	6
3498	2	2011	2015	12
3499	2	2016	2021	6
3499	2	2011	2015	5
3500	2	2016	2021	31
3500	2	2011	2015	24
3501	2	2016	2021	87
3501	2	2011	2015	60
3502	2	2016	2021	31
3502	2	2011	2015	25
3503	2	2016	2021	9
3503	2	2011	2015	6
3504	2	2016	2021	10
3504	2	2011	2015	12
3505	2	2016	2021	5
3505	2	2011	2015	5
3506	2	2016	2021	15
3506	2	2011	2015	38
3507	2	2016	2021	520
3507	2	2011	2015	472
3508	2	2016	2021	40
3508	2	2011	2015	34
3509	2	2016	2021	61
3509	2	2011	2015	51
3510	2	2016	2021	2
3510	2	2011	2015	1
3511	2	2016	2021	9
3511	2	2011	2015	7
3512	2	2016	2021	26
3512	2	2011	2015	24
3513	2	2016	2021	21
3513	2	2011	2015	20
3514	2	2016	2021	28
3514	2	2011	2015	27
3515	2	2016	2021	8
3515	2	2011	2015	13
3516	2	2016	2021	10
3516	2	2011	2015	13
3517	2	2016	2021	95
3517	2	2011	2015	71
3518	2	2016	2021	20
3518	2	2011	2015	15
3519	2	2016	2021	467
3519	2	2011	2015	358
3520	2	2016	2021	300
3520	2	2011	2015	216
3521	2	2016	2021	16
3521	2	2011	2015	18
3522	2	2016	2021	164
3522	2	2011	2015	153
3523	2	2016	2021	19
3523	2	2011	2015	16
3524	2	2016	2021	22
3524	2	2011	2015	19
3525	2	2016	2021	31
3525	2	2011	2015	40
3526	2	2016	2021	3
3526	2	2011	2015	6
3527	2	2016	2021	170
3527	2	2011	2015	126
3528	2	2016	2021	16
3528	2	2011	2015	9
3529	2	2016	2021	3
3529	2	2011	2015	2
3530	2	2016	2021	10
3530	2	2011	2015	17
3531	2	2016	2021	8
3531	2	2011	2015	4
3532	2	2016	2021	15
3532	2	2011	2015	6
3533	2	2016	2021	61
3533	2	2011	2015	47
3534	2	2016	2021	216
3534	2	2011	2015	166
3535	2	2016	2021	7
3535	2	2011	2015	15
3536	2	2016	2021	68
3536	2	2011	2015	67
3537	2	2016	2021	10
3537	2	2011	2015	15
3538	2	2016	2021	15
3538	2	2011	2015	14
3539	2	2016	2021	20
3539	2	2011	2015	26
3540	2	2016	2021	5
3540	2	2011	2015	7
3541	2	2016	2021	52
3541	2	2011	2015	39
3542	2	2016	2021	208
3542	2	2011	2015	159
3543	2	2016	2021	31
3543	2	2011	2015	33
3544	2	2016	2021	30
3544	2	2011	2015	29
3545	2	2016	2021	39
3545	2	2011	2015	26
3546	2	2016	2021	67
3546	2	2011	2015	41
3547	2	2016	2021	29
3547	2	2011	2015	16
3548	2	2016	2021	62
3548	2	2011	2015	35
3549	2	2016	2021	99
3549	2	2011	2015	106
3550	2	2016	2021	68
3550	2	2011	2015	74
3551	2	2016	2021	12
3551	2	2011	2015	6
3552	2	2016	2021	18
3552	2	2011	2015	29
3553	2	2016	2021	13
3553	2	2011	2015	14
3554	2	2016	2021	1
3554	2	2011	2015	1
3555	2	2016	2021	0
3555	2	2011	2015	3
3556	2	2016	2021	20
3556	2	2011	2015	12
3557	2	2016	2021	8
3557	2	2011	2015	10
3558	2	2016	2021	30
3558	2	2011	2015	33
3559	2	2016	2021	45
3559	2	2011	2015	53
3560	2	2016	2021	6
3560	2	2011	2015	2
3561	2	2016	2021	48
3561	2	2011	2015	43
3562	2	2016	2021	10
3562	2	2011	2015	13
3563	2	2016	2021	195
3563	2	2011	2015	129
3564	2	2016	2021	4
3564	2	2011	2015	1
3565	2	2016	2021	14
3565	2	2011	2015	10
3566	2	2016	2021	4
3566	2	2011	2015	0
3567	2	2016	2021	552
3567	2	2011	2015	452
3568	2	2016	2021	120
3568	2	2011	2015	94
3569	2	2016	2021	482
3569	2	2011	2015	429
3570	2	2016	2021	11
3570	2	2011	2015	9
3571	2	2016	2021	62
3571	2	2011	2015	52
3572	2	2016	2021	37
3572	2	2011	2015	17
3573	2	2016	2021	13
3573	2	2011	2015	7
3574	2	2016	2021	1
3574	2	2011	2015	0
3575	2	2016	2021	18
3575	2	2011	2015	15
3576	2	2016	2021	7
3576	2	2011	2015	12
3577	2	2016	2021	23
3577	2	2011	2015	15
3578	2	2016	2021	29
3578	2	2011	2015	16
3579	2	2016	2021	178
3579	2	2011	2015	134
3580	2	2016	2021	33
3580	2	2011	2015	26
3581	2	2016	2021	4
3581	2	2011	2015	9
3582	2	2016	2021	42
3582	2	2011	2015	30
3583	2	2016	2021	20
3583	2	2011	2015	18
3584	2	2016	2021	249
3584	2	2011	2015	238
3585	2	2016	2021	142
3585	2	2011	2015	152
3586	2	2016	2021	39
3586	2	2011	2015	31
3587	2	2016	2021	44
3587	2	2011	2015	31
3588	2	2016	2021	21
3588	2	2011	2015	21
3589	2	2016	2021	22
3589	2	2011	2015	19
3590	2	2016	2021	67
3590	2	2011	2015	77
3591	2	2016	2021	170
3591	2	2011	2015	164
3592	2	2016	2021	164
3592	2	2011	2015	163
3593	2	2016	2021	6
3593	2	2011	2015	8
3594	2	2016	2021	41
3594	2	2011	2015	37
3595	2	2016	2021	4
3595	2	2011	2015	7
3596	2	2016	2021	7
3596	2	2011	2015	7
3597	2	2016	2021	55
3597	2	2011	2015	55
3598	2	2016	2021	9
3598	2	2011	2015	8
3599	2	2016	2021	5
3599	2	2011	2015	4
3600	2	2016	2021	102
3600	2	2011	2015	102
3601	2	2016	2021	56
3601	2	2011	2015	68
3602	2	2016	2021	35
3602	2	2011	2015	44
3603	2	2016	2021	53
3603	2	2011	2015	59
3604	2	2016	2021	87
3604	2	2011	2015	101
3605	2	2016	2021	39
3605	2	2011	2015	35
3606	2	2016	2021	77
3606	2	2011	2015	84
3607	2	2016	2021	78
3607	2	2011	2015	79
3608	2	2016	2021	14
3608	2	2011	2015	14
3609	2	2016	2021	6
3609	2	2011	2015	8
3610	2	2016	2021	41
3610	2	2011	2015	27
3611	2	2016	2021	20
3611	2	2011	2015	29
3612	2	2016	2021	306
3612	2	2011	2015	263
3613	2	2016	2021	1333
3613	2	2011	2015	1055
3614	2	2016	2021	34
3614	2	2011	2015	48
3615	2	2016	2021	2
3615	2	2011	2015	1
3616	2	2016	2021	48
3616	2	2011	2015	45
3617	2	2016	2021	48
3617	2	2011	2015	63
3618	2	2016	2021	59
3618	2	2011	2015	64
3619	2	2016	2021	41
3619	2	2011	2015	45
3620	2	2016	2021	166
3620	2	2011	2015	173
3621	2	2016	2021	259
3621	2	2011	2015	276
3622	2	2016	2021	127
3622	2	2011	2015	139
3623	2	2016	2021	44
3623	2	2011	2015	48
3624	2	2016	2021	98
3624	2	2011	2015	80
3625	2	2016	2021	64
3625	2	2011	2015	74
3626	2	2016	2021	24
3626	2	2011	2015	22
3627	2	2016	2021	24
3627	2	2011	2015	23
3628	2	2016	2021	4
3628	2	2011	2015	3
3629	2	2016	2021	116
3629	2	2011	2015	115
3630	2	2016	2021	35
3630	2	2011	2015	39
3631	2	2016	2021	59
3631	2	2011	2015	77
3632	2	2016	2021	573
3632	2	2011	2015	545
3633	2	2016	2021	92
3633	2	2011	2015	87
3634	2	2016	2021	371
3634	2	2011	2015	390
3635	2	2016	2021	97
3635	2	2011	2015	112
3636	2	2016	2021	24
3636	2	2011	2015	27
3637	2	2016	2021	3
3637	2	2011	2015	5
3638	2	2016	2021	125
3638	2	2011	2015	133
3639	2	2016	2021	29
3639	2	2011	2015	23
3640	2	2016	2021	99
3640	2	2011	2015	108
3641	2	2016	2021	6
3641	2	2011	2015	4
3642	2	2016	2021	27
3642	2	2011	2015	30
3643	2	2016	2021	52
3643	2	2011	2015	50
3644	2	2016	2021	11
3644	2	2011	2015	18
3645	2	2016	2021	61
3645	2	2011	2015	55
3646	2	2016	2021	18
3646	2	2011	2015	22
3647	2	2016	2021	79
3647	2	2011	2015	76
3648	2	2016	2021	110
3648	2	2011	2015	101
3649	2	2016	2021	107
3649	2	2011	2015	103
3650	2	2016	2021	21
3650	2	2011	2015	34
3651	2	2016	2021	129
3651	2	2011	2015	143
3652	2	2016	2021	18
3652	2	2011	2015	24
3653	2	2016	2021	21
3653	2	2011	2015	24
3654	2	2016	2021	11
3654	2	2011	2015	13
3655	2	2016	2021	12
3655	2	2011	2015	9
3656	2	2016	2021	169
3656	2	2011	2015	144
3657	2	2016	2021	17
3657	2	2011	2015	21
3658	2	2016	2021	55
3658	2	2011	2015	53
3659	2	2016	2021	112
3659	2	2011	2015	94
3660	2	2016	2021	26
3660	2	2011	2015	37
3661	2	2016	2021	79
3661	2	2011	2015	56
3662	2	2016	2021	54
3662	2	2011	2015	40
3663	2	2016	2021	19
3663	2	2011	2015	19
3664	2	2016	2021	26
3664	2	2011	2015	37
3665	2	2016	2021	62
3665	2	2011	2015	42
3666	2	2016	2021	28
3666	2	2011	2015	20
3667	2	2016	2021	20
3667	2	2011	2015	11
3668	2	2016	2021	110
3668	2	2011	2015	102
3669	2	2016	2021	7
3669	2	2011	2015	3
3670	2	2016	2021	111
3670	2	2011	2015	108
3671	2	2016	2021	34
3671	2	2011	2015	25
3672	2	2016	2021	47
3672	2	2011	2015	50
3673	2	2016	2021	54
3673	2	2011	2015	55
3674	2	2016	2021	102
3674	2	2011	2015	121
3675	2	2016	2021	112
3675	2	2011	2015	127
3676	2	2016	2021	21
3676	2	2011	2015	24
3677	2	2016	2021	12
3677	2	2011	2015	7
3678	2	2016	2021	94
3678	2	2011	2015	82
3679	2	2016	2021	23
3679	2	2011	2015	31
3680	2	2016	2021	57
3680	2	2011	2015	48
3681	2	2016	2021	39
3681	2	2011	2015	43
3682	2	2016	2021	54
3682	2	2011	2015	66
3683	2	2016	2021	4
3683	2	2011	2015	2
3684	2	2016	2021	27
3684	2	2011	2015	35
3685	2	2016	2021	12
3685	2	2011	2015	15
3686	2	2016	2021	6
3686	2	2011	2015	6
3687	2	2016	2021	33
3687	2	2011	2015	19
3688	2	2016	2021	19
3688	2	2011	2015	27
3689	2	2016	2021	28
3689	2	2011	2015	35
3690	2	2016	2021	82
3690	2	2011	2015	94
3691	2	2016	2021	9
3691	2	2011	2015	8
3692	2	2016	2021	33
3692	2	2011	2015	41
3693	2	2016	2021	10
3693	2	2011	2015	6
3694	2	2016	2021	6
3694	2	2011	2015	6
3695	2	2016	2021	12
3695	2	2011	2015	22
3696	2	2016	2021	22
3696	2	2011	2015	27
3697	2	2016	2021	63
3697	2	2011	2015	92
3698	2	2016	2021	5
3698	2	2011	2015	6
3699	2	2016	2021	31
3699	2	2011	2015	39
3700	2	2016	2021	8
3700	2	2011	2015	3
3701	2	2016	2021	27
3701	2	2011	2015	44
3702	2	2016	2021	99
3702	2	2011	2015	73
3703	2	2016	2021	31
3703	2	2011	2015	26
3704	2	2016	2021	15
3704	2	2011	2015	11
3705	2	2016	2021	4
3705	2	2011	2015	6
3706	2	2016	2021	59
3706	2	2011	2015	51
3707	2	2016	2021	7
3707	2	2011	2015	9
3708	2	2016	2021	162
3708	2	2011	2015	159
3709	2	2016	2021	70
3709	2	2011	2015	63
3710	2	2016	2021	213
3710	2	2011	2015	252
3711	2	2016	2021	16
3711	2	2011	2015	15
3712	2	2016	2021	30
3712	2	2011	2015	29
3713	2	2016	2021	12
3713	2	2011	2015	10
3714	2	2016	2021	263
3714	2	2011	2015	244
3715	2	2016	2021	27
3715	2	2011	2015	27
3716	2	2016	2021	66
3716	2	2011	2015	72
3717	2	2016	2021	272
3717	2	2011	2015	280
3718	2	2016	2021	84
3718	2	2011	2015	95
3719	2	2016	2021	31
3719	2	2011	2015	33
3720	2	2016	2021	3472
3720	2	2011	2015	2972
3721	2	2016	2021	320
3721	2	2011	2015	350
3722	2	2016	2021	112
3722	2	2011	2015	107
3723	2	2016	2021	4
3723	2	2011	2015	0
3724	2	2016	2021	9
3724	2	2011	2015	7
3725	2	2016	2021	15
3725	2	2011	2015	10
3726	2	2016	2021	82
3726	2	2011	2015	80
3727	2	2016	2021	426
3727	2	2011	2015	413
3728	2	2016	2021	21
3728	2	2011	2015	24
3729	2	2016	2021	38
3729	2	2011	2015	45
3730	2	2016	2021	42
3730	2	2011	2015	39
3731	2	2016	2021	53
3731	2	2011	2015	49
3732	2	2016	2021	17
3732	2	2011	2015	20
3733	2	2016	2021	69
3733	2	2011	2015	69
3734	2	2016	2021	87
3734	2	2011	2015	76
3735	2	2016	2021	19
3735	2	2011	2015	19
3736	2	2016	2021	97
3736	2	2011	2015	106
3737	2	2016	2021	53
3737	2	2011	2015	51
3738	2	2016	2021	6
3738	2	2011	2015	5
3739	2	2016	2021	31
3739	2	2011	2015	36
3740	2	2016	2021	4
3740	2	2011	2015	4
3741	2	2016	2021	24
3741	2	2011	2015	23
3742	2	2016	2021	14
3742	2	2011	2015	16
3743	2	2016	2021	37
3743	2	2011	2015	33
3744	2	2016	2021	38
3744	2	2011	2015	48
3745	2	2016	2021	35
3745	2	2011	2015	45
3746	2	2016	2021	114
3746	2	2011	2015	99
3747	2	2016	2021	30
3747	2	2011	2015	36
3748	2	2016	2021	35
3748	2	2011	2015	26
3749	2	2016	2021	70
3749	2	2011	2015	77
3750	2	2016	2021	37
3750	2	2011	2015	34
3751	2	2016	2021	78
3751	2	2011	2015	76
3752	2	2016	2021	9
3752	2	2011	2015	15
3753	2	2016	2021	24
3753	2	2011	2015	20
3754	2	2016	2021	25
3754	2	2011	2015	39
3755	2	2016	2021	136
3755	2	2011	2015	120
3756	2	2016	2021	18
3756	2	2011	2015	23
3757	2	2016	2021	31
3757	2	2011	2015	48
3758	2	2016	2021	20
3758	2	2011	2015	27
3759	2	2016	2021	48
3759	2	2011	2015	38
3760	2	2016	2021	12
3760	2	2011	2015	23
3761	2	2016	2021	20
3761	2	2011	2015	15
3762	2	2016	2021	16
3762	2	2011	2015	10
3763	2	2016	2021	66
3763	2	2011	2015	67
3764	2	2016	2021	20
3764	2	2011	2015	22
3765	2	2016	2021	60
3765	2	2011	2015	58
3766	2	2016	2021	40
3766	2	2011	2015	31
3767	2	2016	2021	65
3767	2	2011	2015	59
3768	2	2016	2021	18
3768	2	2011	2015	15
3769	2	2016	2021	43
3769	2	2011	2015	32
3770	2	2016	2021	25
3770	2	2011	2015	29
3771	2	2016	2021	373
3771	2	2011	2015	320
3772	2	2016	2021	17
3772	2	2011	2015	19
3773	2	2016	2021	40
3773	2	2011	2015	41
3774	2	2016	2021	29
3774	2	2011	2015	15
3775	2	2016	2021	56
3775	2	2011	2015	53
3776	2	2016	2021	58
3776	2	2011	2015	58
3777	2	2016	2021	19
3777	2	2011	2015	13
3778	2	2016	2021	60
3778	2	2011	2015	59
3779	2	2016	2021	94
3779	2	2011	2015	69
3780	2	2016	2021	77
3780	2	2011	2015	80
3781	2	2016	2021	47
3781	2	2011	2015	76
3782	2	2016	2021	127
3782	2	2011	2015	123
3783	2	2016	2021	22
3783	2	2011	2015	27
3784	2	2016	2021	78
3784	2	2011	2015	97
3785	2	2016	2021	48
3785	2	2011	2015	48
3786	2	2016	2021	74
3786	2	2011	2015	64
3787	2	2016	2021	8
3787	2	2011	2015	8
3788	2	2016	2021	29
3788	2	2011	2015	33
3789	2	2016	2021	14
3789	2	2011	2015	11
3790	2	2016	2021	92
3790	2	2011	2015	91
3791	2	2016	2021	110
3791	2	2011	2015	112
3792	2	2016	2021	74
3792	2	2011	2015	57
3793	2	2016	2021	28
3793	2	2011	2015	33
3794	2	2016	2021	67
3794	2	2011	2015	85
3795	2	2016	2021	21
3795	2	2011	2015	19
3796	2	2016	2021	32
3796	2	2011	2015	42
3797	2	2016	2021	5
3797	2	2011	2015	8
3798	2	2016	2021	82
3798	2	2011	2015	84
3799	2	2016	2021	30
3799	2	2011	2015	38
3800	2	2016	2021	20
3800	2	2011	2015	7
3801	2	2016	2021	35
3801	2	2011	2015	25
3802	2	2016	2021	85
3802	2	2011	2015	71
3803	2	2016	2021	2
3803	2	2011	2015	2
3804	2	2016	2021	37
3804	2	2011	2015	37
3805	2	2016	2021	31
3805	2	2011	2015	27
3806	2	2016	2021	54
3806	2	2011	2015	42
3807	2	2016	2021	29
3807	2	2011	2015	37
3808	2	2016	2021	86
3808	2	2011	2015	87
3809	2	2016	2021	71
3809	2	2011	2015	74
3810	2	2016	2021	756
3810	2	2011	2015	705
3811	2	2016	2021	12
3811	2	2011	2015	13
3812	2	2016	2021	5
3812	2	2011	2015	6
3813	2	2016	2021	71
3813	2	2011	2015	70
3814	2	2016	2021	53
3814	2	2011	2015	29
3815	2	2016	2021	6
3815	2	2011	2015	11
3816	2	2016	2021	42
3816	2	2011	2015	38
3817	2	2016	2021	12
3817	2	2011	2015	11
3818	2	2016	2021	85
3818	2	2011	2015	64
3819	2	2016	2021	30
3819	2	2011	2015	15
3820	2	2016	2021	5
3820	2	2011	2015	13
3821	2	2016	2021	30
3821	2	2011	2015	23
3822	2	2016	2021	7
3822	2	2011	2015	13
3823	2	2016	2021	67
3823	2	2011	2015	49
3824	2	2016	2021	5
3824	2	2011	2015	4
3825	2	2016	2021	59
3825	2	2011	2015	57
3826	2	2016	2021	2
3826	2	2011	2015	4
3827	2	2016	2021	2
3827	2	2011	2015	7
3828	2	2016	2021	4
3828	2	2011	2015	6
3829	2	2016	2021	123
3829	2	2011	2015	130
3830	2	2016	2021	6
3830	2	2011	2015	5
3831	2	2016	2021	18
3831	2	2011	2015	29
3832	2	2016	2021	172
3832	2	2011	2015	158
3833	2	2016	2021	14
3833	2	2011	2015	12
3834	2	2016	2021	11
3834	2	2011	2015	18
3835	2	2016	2021	33
3835	2	2011	2015	37
3836	2	2016	2021	21
3836	2	2011	2015	19
3837	2	2016	2021	13
3837	2	2011	2015	7
3838	2	2016	2021	37
3838	2	2011	2015	30
3839	2	2016	2021	20
3839	2	2011	2015	15
3840	2	2016	2021	43
3840	2	2011	2015	59
3841	2	2016	2021	21
3841	2	2011	2015	13
3842	2	2016	2021	58
3842	2	2011	2015	59
3843	2	2016	2021	79
3843	2	2011	2015	64
3844	2	2016	2021	5
3844	2	2011	2015	2
3845	2	2016	2021	9
3845	2	2011	2015	3
3846	2	2016	2021	3
3846	2	2011	2015	7
3847	2	2016	2021	93
3847	2	2011	2015	108
3848	2	2016	2021	44
3848	2	2011	2015	51
3849	2	2016	2021	175
3849	2	2011	2015	165
3850	2	2016	2021	70
3850	2	2011	2015	78
3851	2	2016	2021	13
3851	2	2011	2015	16
3852	2	2016	2021	158
3852	2	2011	2015	198
3853	2	2016	2021	13
3853	2	2011	2015	14
3854	2	2016	2021	9
3854	2	2011	2015	10
3855	2	2016	2021	8
3855	2	2011	2015	13
3856	2	2016	2021	104
3856	2	2011	2015	75
3857	2	2016	2021	13
3857	2	2011	2015	19
3858	2	2016	2021	28
3858	2	2011	2015	29
3859	2	2016	2021	108
3859	2	2011	2015	86
3860	2	2016	2021	56
3860	2	2011	2015	61
3861	2	2016	2021	36
3861	2	2011	2015	39
3862	2	2016	2021	88
3862	2	2011	2015	91
3863	2	2016	2021	124
3863	2	2011	2015	130
3864	2	2016	2021	35
3864	2	2011	2015	34
3865	2	2016	2021	6
3865	2	2011	2015	8
3866	2	2016	2021	73
3866	2	2011	2015	63
3867	2	2016	2021	16
3867	2	2011	2015	11
3868	2	2016	2021	7
3868	2	2011	2015	15
3869	2	2016	2021	48
3869	2	2011	2015	47
3870	2	2016	2021	11
3870	2	2011	2015	12
3871	2	2016	2021	609
3871	2	2011	2015	509
3872	2	2016	2021	25
3872	2	2011	2015	46
3873	2	2016	2021	25
3873	2	2011	2015	22
3874	2	2016	2021	83
3874	2	2011	2015	93
3875	2	2016	2021	66
3875	2	2011	2015	91
3876	2	2016	2021	23
3876	2	2011	2015	23
3877	2	2016	2021	89
3877	2	2011	2015	87
3878	2	2016	2021	22
3878	2	2011	2015	21
3879	2	2016	2021	44
3879	2	2011	2015	48
3880	2	2016	2021	11
3880	2	2011	2015	6
3881	2	2016	2021	70
3881	2	2011	2015	63
3882	2	2016	2021	132
3882	2	2011	2015	121
3883	2	2016	2021	12
3883	2	2011	2015	10
3884	2	2016	2021	13
3884	2	2011	2015	6
3885	2	2016	2021	36
3885	2	2011	2015	56
3886	2	2016	2021	33
3886	2	2011	2015	46
3887	2	2016	2021	37
3887	2	2011	2015	49
3888	2	2016	2021	265
3888	2	2011	2015	240
3889	2	2016	2021	5
3889	2	2011	2015	7
3890	2	2016	2021	28
3890	2	2011	2015	27
3891	2	2016	2021	68
3891	2	2011	2015	68
3892	2	2016	2021	2097
3892	2	2011	2015	2024
3893	2	2016	2021	52
3893	2	2011	2015	50
3894	2	2016	2021	5
3894	2	2011	2015	8
3895	2	2016	2021	343
3895	2	2011	2015	309
3896	2	2016	2021	24
3896	2	2011	2015	25
3897	2	2016	2021	24
3897	2	2011	2015	27
3898	2	2016	2021	60
3898	2	2011	2015	50
3899	2	2016	2021	50
3899	2	2011	2015	42
3900	2	2016	2021	196
3900	2	2011	2015	167
3901	2	2016	2021	79
3901	2	2011	2015	70
3902	2	2016	2021	65
3902	2	2011	2015	71
3903	2	2016	2021	29
3903	2	2011	2015	32
3904	2	2016	2021	29
3904	2	2011	2015	36
3905	2	2016	2021	54
3905	2	2011	2015	60
3906	2	2016	2021	246
3906	2	2011	2015	212
3907	2	2016	2021	82
3907	2	2011	2015	66
3908	2	2016	2021	5
3908	2	2011	2015	3
3909	2	2016	2021	15
3909	2	2011	2015	16
3910	2	2016	2021	59
3910	2	2011	2015	56
3911	2	2016	2021	8
3911	2	2011	2015	13
3912	2	2016	2021	56
3912	2	2011	2015	37
3913	2	2016	2021	11
3913	2	2011	2015	21
3914	2	2016	2021	13
3914	2	2011	2015	9
3915	2	2016	2021	20
3915	2	2011	2015	20
3916	2	2016	2021	139
3916	2	2011	2015	126
3917	2	2016	2021	10
3917	2	2011	2015	8
3918	2	2016	2021	51
3918	2	2011	2015	44
3919	2	2016	2021	180
3919	2	2011	2015	224
3920	2	2016	2021	39
3920	2	2011	2015	45
3921	2	2016	2021	18
3921	2	2011	2015	20
3922	2	2016	2021	8
3922	2	2011	2015	5
3923	2	2016	2021	78
3923	2	2011	2015	58
3924	2	2016	2021	175
3924	2	2011	2015	198
3925	2	2016	2021	43
3925	2	2011	2015	42
3926	2	2016	2021	77
3926	2	2011	2015	78
3927	2	2016	2021	18
3927	2	2011	2015	21
3928	2	2016	2021	14
3928	2	2011	2015	23
3929	2	2016	2021	2
3929	2	2011	2015	2
3930	2	2016	2021	21
3930	2	2011	2015	22
3931	2	2016	2021	29
3931	2	2011	2015	24
3932	2	2016	2021	10
3932	2	2011	2015	10
3933	2	2016	2021	15
3933	2	2011	2015	17
3934	2	2016	2021	63
3934	2	2011	2015	95
3935	2	2016	2021	27
3935	2	2011	2015	27
3936	2	2016	2021	131
3936	2	2011	2015	178
3937	2	2016	2021	80
3937	2	2011	2015	86
3938	2	2016	2021	435
3938	2	2011	2015	475
3939	2	2016	2021	38
3939	2	2011	2015	31
3940	2	2016	2021	30
3940	2	2011	2015	28
3941	2	2016	2021	25
3941	2	2011	2015	11
3942	2	2016	2021	6
3942	2	2011	2015	8
3943	2	2016	2021	42
3943	2	2011	2015	41
3944	2	2016	2021	63
3944	2	2011	2015	78
3945	2	2016	2021	6
3945	2	2011	2015	3
3946	2	2016	2021	203
3946	2	2011	2015	195
3947	2	2016	2021	80
3947	2	2011	2015	90
3948	2	2016	2021	40
3948	2	2011	2015	23
3949	2	2016	2021	51
3949	2	2011	2015	55
3950	2	2016	2021	21
3950	2	2011	2015	26
3951	2	2016	2021	105
3951	2	2011	2015	118
3952	2	2016	2021	25
3952	2	2011	2015	21
3953	2	2016	2021	14
3953	2	2011	2015	24
3954	2	2016	2021	61
3954	2	2011	2015	62
3955	2	2016	2021	12
3955	2	2011	2015	11
3956	2	2016	2021	151
3956	2	2011	2015	175
3957	2	2016	2021	10
3957	2	2011	2015	16
3958	2	2016	2021	41
3958	2	2011	2015	32
3959	2	2016	2021	10
3959	2	2011	2015	14
3960	2	2016	2021	255
3960	2	2011	2015	277
3961	2	2016	2021	10
3961	2	2011	2015	0
3962	2	2016	2021	113
3962	2	2011	2015	107
3963	2	2016	2021	95
3963	2	2011	2015	115
3964	2	2016	2021	44
3964	2	2011	2015	45
3965	2	2016	2021	43
3965	2	2011	2015	51
3966	2	2016	2021	5
3966	2	2011	2015	6
3967	2	2016	2021	21
3967	2	2011	2015	23
3968	2	2016	2021	78
3968	2	2011	2015	102
3969	2	2016	2021	35
3969	2	2011	2015	54
3970	2	2016	2021	38
3970	2	2011	2015	37
3971	2	2016	2021	10
3971	2	2011	2015	14
3972	2	2016	2021	19
3972	2	2011	2015	19
3973	2	2016	2021	9
3973	2	2011	2015	8
3974	2	2016	2021	20
3974	2	2011	2015	19
3975	2	2016	2021	54
3975	2	2011	2015	49
3976	2	2016	2021	11
3976	2	2011	2015	11
3977	2	2016	2021	20
3977	2	2011	2015	18
3978	2	2016	2021	302
3978	2	2011	2015	197
3979	2	2016	2021	406
3979	2	2011	2015	298
3980	2	2016	2021	17
3980	2	2011	2015	15
3981	2	2016	2021	103
3981	2	2011	2015	106
3982	2	2016	2021	37
3982	2	2011	2015	42
3983	2	2016	2021	2
3983	2	2011	2015	5
3984	2	2016	2021	208
3984	2	2011	2015	199
3985	2	2016	2021	34
3985	2	2011	2015	49
3986	2	2016	2021	190
3986	2	2011	2015	236
3987	2	2016	2021	29
3987	2	2011	2015	33
3988	2	2016	2021	30
3988	2	2011	2015	24
3989	2	2016	2021	18
3989	2	2011	2015	13
3990	2	2016	2021	15
3990	2	2011	2015	8
3991	2	2016	2021	2
3991	2	2011	2015	4
3992	2	2016	2021	19
3992	2	2011	2015	30
3993	2	2016	2021	351
3993	2	2011	2015	273
3994	2	2016	2021	15
3994	2	2011	2015	15
3995	2	2016	2021	3
3995	2	2011	2015	1
3996	2	2016	2021	278
3996	2	2011	2015	295
3997	2	2016	2021	126
3997	2	2011	2015	158
3998	2	2016	2021	170
3998	2	2011	2015	131
3999	2	2016	2021	11
3999	2	2011	2015	9
4000	2	2016	2021	24
4000	2	2011	2015	14
4001	2	2016	2021	85
4001	2	2011	2015	99
4002	2	2016	2021	58
4002	2	2011	2015	56
4003	2	2016	2021	63
4003	2	2011	2015	44
4004	2	2016	2021	41
4004	2	2011	2015	20
4005	2	2016	2021	12
4005	2	2011	2015	14
4006	2	2016	2021	28
4006	2	2011	2015	22
4007	2	2016	2021	12
4007	2	2011	2015	9
4008	2	2016	2021	10
4008	2	2011	2015	4
4009	2	2016	2021	53
4009	2	2011	2015	58
4010	2	2016	2021	5977
4010	2	2011	2015	5263
4011	2	2016	2021	37
4011	2	2011	2015	35
4012	2	2016	2021	8
4012	2	2011	2015	12
4013	2	2016	2021	11
4013	2	2011	2015	15
4014	2	2016	2021	58
4014	2	2011	2015	45
4015	2	2016	2021	25
4015	2	2011	2015	18
4016	2	2016	2021	9
4016	2	2011	2015	4
4017	2	2016	2021	26
4017	2	2011	2015	29
4018	2	2016	2021	24
4018	2	2011	2015	26
4019	2	2016	2021	121
4019	2	2011	2015	95
4020	2	2016	2021	9
4020	2	2011	2015	6
4021	2	2016	2021	12
4021	2	2011	2015	8
4022	2	2016	2021	69
4022	2	2011	2015	52
4023	2	2016	2021	145
4023	2	2011	2015	117
4024	2	2016	2021	51
4024	2	2011	2015	62
4025	2	2016	2021	40
4025	2	2011	2015	40
4026	2	2016	2021	152
4026	2	2011	2015	151
4027	2	2016	2021	304
4027	2	2011	2015	295
4028	2	2016	2021	7
4028	2	2011	2015	10
4029	2	2016	2021	8
4029	2	2011	2015	12
4030	2	2016	2021	13
4030	2	2011	2015	4
4031	2	2016	2021	63
4031	2	2011	2015	63
4032	2	2016	2021	243
4032	2	2011	2015	216
4033	2	2016	2021	21
4033	2	2011	2015	28
4034	2	2016	2021	62
4034	2	2011	2015	57
4035	2	2016	2021	40
4035	2	2011	2015	54
4036	2	2016	2021	171
4036	2	2011	2015	150
4037	2	2016	2021	7
4037	2	2011	2015	7
4038	2	2016	2021	12
4038	2	2011	2015	19
4039	2	2016	2021	25
4039	2	2011	2015	25
4040	2	2016	2021	10
4040	2	2011	2015	9
4041	2	2016	2021	166
4041	2	2011	2015	170
4042	2	2016	2021	15
4042	2	2011	2015	18
4043	2	2016	2021	71
4043	2	2011	2015	71
4044	2	2016	2021	30
4044	2	2011	2015	28
4045	2	2016	2021	18
4045	2	2011	2015	27
4046	2	2016	2021	5
4046	2	2011	2015	14
4047	2	2016	2021	20
4047	2	2011	2015	26
4048	2	2016	2021	15
4048	2	2011	2015	14
4049	2	2016	2021	83
4049	2	2011	2015	75
4050	2	2016	2021	78
4050	2	2011	2015	82
4051	2	2016	2021	24
4051	2	2011	2015	22
4052	2	2016	2021	44
4052	2	2011	2015	48
4053	2	2016	2021	30
4053	2	2011	2015	26
4054	2	2016	2021	9
4054	2	2011	2015	6
4055	2	2016	2021	28
4055	2	2011	2015	15
4056	2	2016	2021	45
4056	2	2011	2015	39
4057	2	2016	2021	23
4057	2	2011	2015	33
4058	2	2016	2021	42
4058	2	2011	2015	30
4059	2	2016	2021	44
4059	2	2011	2015	47
4060	2	2016	2021	71
4060	2	2011	2015	78
4061	2	2016	2021	32
4061	2	2011	2015	33
4062	2	2016	2021	124
4062	2	2011	2015	121
4063	2	2016	2021	15
4063	2	2011	2015	20
4064	2	2016	2021	132
4064	2	2011	2015	105
4065	2	2016	2021	30
4065	2	2011	2015	37
4066	2	2016	2021	139
4066	2	2011	2015	127
4067	2	2016	2021	23
4067	2	2011	2015	33
4068	2	2016	2021	15
4068	2	2011	2015	19
4069	2	2016	2021	1
4069	2	2011	2015	2
4070	2	2016	2021	74
4070	2	2011	2015	79
4071	2	2016	2021	8
4071	2	2011	2015	10
4072	2	2016	2021	4
4072	2	2011	2015	2
4073	2	2016	2021	42
4073	2	2011	2015	60
4074	2	2016	2021	102
4074	2	2011	2015	138
4075	2	2016	2021	31
4075	2	2011	2015	30
4076	2	2016	2021	81
4076	2	2011	2015	50
4077	2	2016	2021	24
4077	2	2011	2015	39
4078	2	2016	2021	39
4078	2	2011	2015	47
4079	2	2016	2021	33
4079	2	2011	2015	20
4080	2	2016	2021	14
4080	2	2011	2015	18
4081	2	2016	2021	320
4081	2	2011	2015	383
4082	2	2016	2021	49
4082	2	2011	2015	55
4083	2	2016	2021	62
4083	2	2011	2015	62
4084	2	2016	2021	20
4084	2	2011	2015	19
4085	2	2016	2021	14
4085	2	2011	2015	22
4086	2	2016	2021	29
4086	2	2011	2015	28
4087	2	2016	2021	23
4087	2	2011	2015	17
4088	2	2016	2021	90
4088	2	2011	2015	102
4089	2	2016	2021	1
4089	2	2011	2015	1
4090	2	2016	2021	80
4090	2	2011	2015	66
4091	2	2016	2021	237
4091	2	2011	2015	177
4092	2	2016	2021	188
4092	2	2011	2015	200
4093	2	2016	2021	15
4093	2	2011	2015	19
4094	2	2016	2021	29
4094	2	2011	2015	37
4095	2	2016	2021	360
4095	2	2011	2015	321
4096	2	2016	2021	140
4096	2	2011	2015	141
4097	2	2016	2021	30
4097	2	2011	2015	43
4098	2	2016	2021	41
4098	2	2011	2015	46
4099	2	2016	2021	324
4099	2	2011	2015	256
4100	2	2016	2021	255
4100	2	2011	2015	247
4101	2	2016	2021	16
4101	2	2011	2015	27
4102	2	2016	2021	6
4102	2	2011	2015	5
4103	2	2016	2021	53
4103	2	2011	2015	53
4104	2	2016	2021	5
4104	2	2011	2015	8
4105	2	2016	2021	8
4105	2	2011	2015	6
4106	2	2016	2021	2
4106	2	2011	2015	4
4107	2	2016	2021	2
4107	2	2011	2015	11
4108	2	2016	2021	151
4108	2	2011	2015	168
4109	2	2016	2021	24
4109	2	2011	2015	26
4110	2	2016	2021	39
4110	2	2011	2015	28
4111	2	2016	2021	133
4111	2	2011	2015	147
4112	2	2016	2021	56
4112	2	2011	2015	50
4113	2	2016	2021	10
4113	2	2011	2015	16
4114	2	2016	2021	21
4114	2	2011	2015	22
4115	2	2016	2021	27
4115	2	2011	2015	32
4116	2	2016	2021	150
4116	2	2011	2015	148
4117	2	2016	2021	78
4117	2	2011	2015	105
4118	2	2016	2021	129
4118	2	2011	2015	123
4119	2	2016	2021	4
4119	2	2011	2015	3
4120	2	2016	2021	17
4120	2	2011	2015	7
4121	2	2016	2021	32
4121	2	2011	2015	28
4122	2	2016	2021	45
4122	2	2011	2015	51
4123	2	2016	2021	40
4123	2	2011	2015	34
4124	2	2016	2021	55
4124	2	2011	2015	62
4125	2	2016	2021	24
4125	2	2011	2015	27
4126	2	2016	2021	48
4126	2	2011	2015	54
4127	2	2016	2021	12
4127	2	2011	2015	12
4128	2	2016	2021	74
4128	2	2011	2015	59
4129	2	2016	2021	50
4129	2	2011	2015	46
4130	2	2016	2021	14
4130	2	2011	2015	20
4131	2	2016	2021	29
4131	2	2011	2015	28
4132	2	2016	2021	28
4132	2	2011	2015	32
4133	2	2016	2021	3
4133	2	2011	2015	4
4134	2	2016	2021	131
4134	2	2011	2015	138
4135	2	2016	2021	31
4135	2	2011	2015	39
4136	2	2016	2021	46
4136	2	2011	2015	39
4137	2	2016	2021	78
4137	2	2011	2015	99
4138	2	2016	2021	15
4138	2	2011	2015	27
4139	2	2016	2021	7
4139	2	2011	2015	6
4140	2	2016	2021	7
4140	2	2011	2015	6
4141	2	2016	2021	52
4141	2	2011	2015	35
4142	2	2016	2021	102
4142	2	2011	2015	76
4143	2	2016	2021	110
4143	2	2011	2015	125
4144	2	2016	2021	344
4144	2	2011	2015	269
4145	2	2016	2021	57
4145	2	2011	2015	41
4146	2	2016	2021	531
4146	2	2011	2015	438
4147	2	2016	2021	20
4147	2	2011	2015	18
4148	2	2016	2021	3
4148	2	2011	2015	12
4149	2	2016	2021	8
4149	2	2011	2015	8
4150	2	2016	2021	30
4150	2	2011	2015	48
4151	2	2016	2021	11
4151	2	2011	2015	4
4152	2	2016	2021	16
4152	2	2011	2015	9
4153	2	2016	2021	2
4153	2	2011	2015	2
4154	2	2016	2021	51
4154	2	2011	2015	48
4155	2	2016	2021	21
4155	2	2011	2015	23
4156	2	2016	2021	11
4156	2	2011	2015	10
4157	2	2016	2021	38
4157	2	2011	2015	29
4158	2	2016	2021	79
4158	2	2011	2015	83
4159	2	2016	2021	95
4159	2	2011	2015	55
4160	2	2016	2021	341
4160	2	2011	2015	318
4161	2	2016	2021	66
4161	2	2011	2015	56
4162	2	2016	2021	8
4162	2	2011	2015	11
4163	2	2016	2021	20
4163	2	2011	2015	31
4164	2	2016	2021	3
4164	2	2011	2015	3
4165	2	2016	2021	66
4165	2	2011	2015	68
4166	2	2016	2021	36
4166	2	2011	2015	33
4167	2	2016	2021	34
4167	2	2011	2015	26
4168	2	2016	2021	19
4168	2	2011	2015	19
4169	2	2016	2021	8
4169	2	2011	2015	8
4170	2	2016	2021	385
4170	2	2011	2015	353
4171	2	2016	2021	13
4171	2	2011	2015	13
4172	2	2016	2021	34
4172	2	2011	2015	48
4173	2	2016	2021	34
4173	2	2011	2015	38
4174	2	2016	2021	31
4174	2	2011	2015	35
4175	2	2016	2021	1
4175	2	2011	2015	4
4176	2	2016	2021	70
4176	2	2011	2015	67
4177	2	2016	2021	46
4177	2	2011	2015	37
4178	2	2016	2021	24
4178	2	2011	2015	18
4179	2	2016	2021	12
4179	2	2011	2015	10
4180	2	2016	2021	8368
4180	2	2011	2015	7869
4181	2	2016	2021	50
4181	2	2011	2015	39
4182	2	2016	2021	14
4182	2	2011	2015	11
4183	2	2016	2021	57
4183	2	2011	2015	48
4184	2	2016	2021	59
4184	2	2011	2015	48
4185	2	2016	2021	9
4185	2	2011	2015	6
4186	2	2016	2021	5
4186	2	2011	2015	10
4187	2	2016	2021	14
4187	2	2011	2015	14
4188	2	2016	2021	16
4188	2	2011	2015	15
4189	2	2016	2021	31
4189	2	2011	2015	36
4190	2	2016	2021	41
4190	2	2011	2015	26
4191	2	2016	2021	51
4191	2	2011	2015	41
4192	2	2016	2021	35
4192	2	2011	2015	31
4193	2	2016	2021	15
4193	2	2011	2015	22
4194	2	2016	2021	7
4194	2	2011	2015	17
4195	2	2016	2021	2
4195	2	2011	2015	4
4196	2	2016	2021	62
4196	2	2011	2015	65
4197	2	2016	2021	25
4197	2	2011	2015	16
4198	2	2016	2021	32
4198	2	2011	2015	29
4199	2	2016	2021	113
4199	2	2011	2015	135
4200	2	2016	2021	69
4200	2	2011	2015	76
4201	2	2016	2021	20
4201	2	2011	2015	9
4202	2	2016	2021	15
4202	2	2011	2015	9
4203	2	2016	2021	152
4203	2	2011	2015	131
4204	2	2016	2021	51
4204	2	2011	2015	42
4205	2	2016	2021	30
4205	2	2011	2015	26
4206	2	2016	2021	304
4206	2	2011	2015	335
4207	2	2016	2021	501
4207	2	2011	2015	425
4208	2	2016	2021	5
4208	2	2011	2015	9
4209	2	2016	2021	36
4209	2	2011	2015	42
4210	2	2016	2021	32
4210	2	2011	2015	26
4211	2	2016	2021	80
4211	2	2011	2015	64
4212	2	2016	2021	49
4212	2	2011	2015	64
4213	2	2016	2021	21
4213	2	2011	2015	17
4214	2	2016	2021	22
4214	2	2011	2015	20
4215	2	2016	2021	56
4215	2	2011	2015	80
4216	2	2016	2021	5
4216	2	2011	2015	6
4217	2	2016	2021	13
4217	2	2011	2015	14
4218	2	2016	2021	195
4218	2	2011	2015	194
4219	2	2016	2021	138
4219	2	2011	2015	122
4220	2	2016	2021	29
4220	2	2011	2015	21
4221	2	2016	2021	89
4221	2	2011	2015	64
4222	2	2016	2021	51
4222	2	2011	2015	53
4223	2	2016	2021	10
4223	2	2011	2015	6
4224	2	2016	2021	42
4224	2	2011	2015	34
4225	2	2016	2021	3
4225	2	2011	2015	5
4226	2	2016	2021	22
4226	2	2011	2015	20
4227	2	2016	2021	5
4227	2	2011	2015	12
4228	2	2016	2021	42
4228	2	2011	2015	38
4229	2	2016	2021	2
4229	2	2011	2015	1
4230	2	2016	2021	36
4230	2	2011	2015	30
4231	2	2016	2021	13
4231	2	2011	2015	25
4232	2	2016	2021	91
4232	2	2011	2015	84
4233	2	2016	2021	22
4233	2	2011	2015	32
4234	2	2016	2021	30
4234	2	2011	2015	33
4235	2	2016	2021	129
4235	2	2011	2015	96
4236	2	2016	2021	36
4236	2	2011	2015	29
4237	2	2016	2021	6
4237	2	2011	2015	5
4238	2	2016	2021	45
4238	2	2011	2015	47
4239	2	2016	2021	2
4239	2	2011	2015	3
4240	2	2016	2021	59
4240	2	2011	2015	66
4241	2	2016	2021	10
4241	2	2011	2015	11
4242	2	2016	2021	33
4242	2	2011	2015	36
4243	2	2016	2021	30
4243	2	2011	2015	29
4244	2	2016	2021	98
4244	2	2011	2015	102
4245	2	2016	2021	6
4245	2	2011	2015	6
4246	2	2016	2021	500
4246	2	2011	2015	488
4247	2	2016	2021	4
4247	2	2011	2015	6
4248	2	2016	2021	129
4248	2	2011	2015	135
4249	2	2016	2021	53
4249	2	2011	2015	45
4250	2	2016	2021	71
4250	2	2011	2015	69
4251	2	2016	2021	19
4251	2	2011	2015	18
4252	2	2016	2021	18
4252	2	2011	2015	21
4253	2	2016	2021	197
4253	2	2011	2015	188
4254	2	2016	2021	9
4254	2	2011	2015	12
4255	2	2016	2021	3
4255	2	2011	2015	4
4256	2	2016	2021	33
4256	2	2011	2015	28
4257	2	2016	2021	6
4257	2	2011	2015	10
4258	2	2016	2021	46
4258	2	2011	2015	48
4259	2	2016	2021	43
4259	2	2011	2015	29
4260	2	2016	2021	42
4260	2	2011	2015	33
4261	2	2016	2021	65
4261	2	2011	2015	47
4262	2	2016	2021	12
4262	2	2011	2015	14
4263	2	2016	2021	7
4263	2	2011	2015	8
4264	2	2016	2021	58
4264	2	2011	2015	52
4265	2	2016	2021	35
4265	2	2011	2015	39
4266	2	2016	2021	100
4266	2	2011	2015	93
4267	2	2016	2021	147
4267	2	2011	2015	168
4268	2	2016	2021	10
4268	2	2011	2015	4
4269	2	2016	2021	21
4269	2	2011	2015	28
4270	2	2016	2021	43
4270	2	2011	2015	38
4271	2	2016	2021	47
4271	2	2011	2015	42
4272	2	2016	2021	60
4272	2	2011	2015	51
4273	2	2016	2021	101
4273	2	2011	2015	80
4274	2	2016	2021	13
4274	2	2011	2015	19
4275	2	2016	2021	225
4275	2	2011	2015	182
4276	2	2016	2021	25
4276	2	2011	2015	22
4277	2	2016	2021	1
4277	2	2011	2015	5
4278	2	2016	2021	36
4278	2	2011	2015	32
4279	2	2016	2021	94
4279	2	2011	2015	103
4280	2	2016	2021	84
4280	2	2011	2015	89
4281	2	2016	2021	3
4281	2	2011	2015	2
4282	2	2016	2021	15
4282	2	2011	2015	9
4283	2	2016	2021	2
4283	2	2011	2015	6
4284	2	2016	2021	49
4284	2	2011	2015	29
4285	2	2016	2021	19
4285	2	2011	2015	18
4286	2	2016	2021	20
4286	2	2011	2015	22
4287	2	2016	2021	2
4287	2	2011	2015	7
4288	2	2016	2021	246
4288	2	2011	2015	268
4289	2	2016	2021	159
4289	2	2011	2015	111
4290	2	2016	2021	82
4290	2	2011	2015	78
4291	2	2016	2021	7
4291	2	2011	2015	2
4292	2	2016	2021	130
4292	2	2011	2015	96
4293	2	2016	2021	3
4293	2	2011	2015	7
\.
