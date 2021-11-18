# Welcome to BSOT repository
BSOT (Base-Band Sounding Tool) is a wideband channel sounding simulator with different scenarios and configurations, providing the channel's characterization in terms of delay and Doppler spreading.

Simulator outcomes are produced in terms of channel sounding parameters and plots by menas the pulse compression technique with direct cross-correlation at the receiver.

## Features
- Channel characterization in terms of delay and Doppler spreading;
- COST 207 statistical model as a synthetic channel for benchmarking;
- Sounding by pulse compression technique with direct cross-correlation at the receiver;
- Six types of sounding sequences (Random, Kasami, Gold, m-Sequence, Zadoff-Chu and Golay);
- Framework for performance result evaluation, including robustness evaluation with different lengths, sampling rates, and SNR values;
- Functions to save the results and plots;
- Several useful utility functions.

## Citation
If you use BSOT, please cite our paper at IEEE Latin America Transactions, "Wideband Channel Sounding Tool and Sounding Sequences Evaluation" (**The source code will be made publicly available after that we have received the acceptance of this publication.**). Here is a suitable BibTeX entry:

```python
@inproceedings{marcos2021,
  title = {{Wideband Channel Sounding Tool and Sounding Sequences Evaluation}},
  author = {José M. Leal B. Filho and Vicente A. de Sousa Jr. and Danilo de S. Pena, Leonardo H. Gonsioroski}
  booktitle = {IEEE Latin America Transactions},
  year = {2021}
}
```

## Academic works
- Book chapter: Análise de Desempenho de Métodos de DOA sujeitos a Modelos de Ruído Impulsivo com Misturas Gaussinas, to appear in Brazilian Journals Publicações;
- Filho, J. Marcos Leal B.; Sousa Jr., Vicente A. de ; Pena, Danilo de S. ; Gonsioroski, Leonardo Henrique . CANAL SEM FIOBANDA LARGA: FUNÇÕES DE CARACTERIZAÇÃO E PROTOTIPAGEM EM SOFTWARE. In: Edilson Antonio Catapan. (Org.). Os impactos de estudos voltados para as ciências exatas (Vol. 1). 1ed.São José dos Pinhais: Brazilian Journals Editora, 2020, v. 01, p. 346-390 (DOI: [http://dx.doi.org/10.35587/brj.ed.0000605](http://dx.doi.org/10.35587/brj.ed.0000605)).
- Paper: J. Marcos Leal B. Filho; Millena Michely de M. Campos ; Vicente A. de Sousa Jr . Técnicas de Sondagem Banda Larga e Ultra-larga. In: IX Fórum de Pesquisa e Inovação, 2019, Brasil. Novos Atores e Cenários em Operações Espaciais, 2019. v. 9. p. 107-109;
- Master Thesis: J. Marcos Leal B. Filho, Desempenho de algoritmos de localização de sinais de áudio sujeitos a ruído impulsivo (2021) - Federal University of Rio Grande do Norte; 

## People
- José Marcos (main developer)
- Danilo Pena (contributor)
- Leonardo Gonsioroski (contributor)
- Vicente Sousa (advisor)

## License
BSOT is released under the MIT license.

## Acknowledgments
José Marcos would like to thank Barreira do Inferno Launch Center (CLBI) for the resource support.
