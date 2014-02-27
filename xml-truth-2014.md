```
Hpricot: 0.8.6
LibXML: 2.7.0
Nokogiri: 1.6.1
Ox: 2.1.1
Rexml: 3.1.7.3
```

C1HTMLParse | 1 | 10 | 100
---|---:|---|---
bench_hpricot | 0.880711 | 0.813474 | 0.755089
bench_libxml | LibXML::XML::Error
bench_nokogiri | 0.903748 | 0.894876 | 0.891747
bench_ox | Ox::ParseError
bench_rexml | REXML::ParseException

C2XMLWalk | 1 | 10 | 100 | 1000
---|---|---|---|---
bench_hpricot | 0.001133 | 0.004284 | 0.038072 | 0.417325
bench_libxml | 0.001349 | 0.008029 | 0.098654 | 0.977217
bench_nokogiri | 0.003474 | 0.021565 | 0.324287 | 4.016511
bench_ox | 0.001182 | 0.005570 | 0.031353 | 0.338625
bench_rexml | 0.009829 | 0.005914 | 0.059412 | 0.686192

C3BasicPath | 1 | 2 | 4
---|---|---|---
bench_hpricot | 0.346507 | 0.693111 | 1.388281
bench_libxml | 0.013190 | 0.026392 | 0.052454
bench_nokogiri | 0.013439 | 0.026879 | 0.053598
bench_ox | 0.982684 | 1.906481 | 3.996535
bench_rexml | ∞ | ∞ | ∞

C4MediumPath | 1 | 2 | 4
---|---|---|---
bench_hpricot | 1.058497 | 1.925272 | 4.062154
bench_libxml | 0.194188 | 0.387647 | 0.772557
bench_nokogiri | 0.197076 | 0.393112 | 0.775489
bench_ox | ? | ? | ?
bench_rexml | ∞ | ∞ | ∞

C6StringXML | 1 | 3
---|---|---
bench_a_split | 0.097751 | 0.451297
bench_hpricot | 0.701013 | 2.724648
bench_libxml | 0.796666 | 1.621833
bench_nokogiri | 0.484603 | 1.833424
bench_ox | 0.137312 | 0.283570

C7IOXML | 1 | 3
---|---|---
bench_a_line | 0.037397 | 0.114000
bench_hpricot | 0.719102 | 2.834480
bench_libxml | 0.675402 | 2.074367
bench_nokogiri | 0.596686 | 2.193641
bench_ox | 0.133154 | 0.285065

C8StringSmallXML | 1 | 10 | 100 | 1000
---|---|---|---|---
bench_a_split | 0.000878 | 0.002814 | 0.026803 | 0.409461
bench_hpricot | 0.001567 | 0.006740 | 0.051562 | 1.106719
bench_libxml | 0.021295 | 0.003561 | 0.031119 | 1.287018
bench_nokogiri | 0.006637 | 0.003659 | 0.031806 | 1.276726
bench_ox | 0.013644 | 0.001792 | 0.016385 | 0.317601
bench_rexml | 0.021558 | 0.209177 | 2.332435 | ~23

C9IOSmallXML | 1 | 10 | 100 | 1000
---|---|---|---|---
bench_a_line | 0.000392 | 0.001177 | 0.010412 | 0.275760
bench_hpricot | 0.001327 | 0.006719 | 0.052040 | 1.489341
bench_libxml | 0.008684 | 0.003718 | 0.032028 | 1.157042
bench_nokogiri | 0.011865 | 0.003994 | 0.033384 | 1.153226
bench_ox | 0.016081 | 0.001765 | 0.016099 | 0.156216
bench_rexml | 0.031584 | 0.207514 | 2.536789 | ~25
