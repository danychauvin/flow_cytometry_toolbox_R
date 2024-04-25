# Presentation Outline
Hi everyone, my name is Dany.
Thank you for giving me the opportunity to apply for this data analyst position and to do this interview today. I am very happy to be here to present myself and also to get to know you.
I will first talk about myself, and then I'll discuss the data analysis assignment I was given.

## Who am I
Duration: 5 minutes

~~Picture of Nantes, Paris, Basel~~
I come from the west of France, a city called Nantes, but I actually did most of studies in Paris area, where I did an engineering school and got a master in biophysics. After this, I felt that I really wanted to do fundamental research. So I joined the Griffiths lab that was using micrometric droplets to study molecular evolution in home-made flow cytometry setups.

What was it looking like? Like this.
~~Picture of me and Anton in the lab, videos of droplets moving around, and 
The main output of what I did there: setting up my own droplet flow cytometry station, with a microscope, high-speed camera, lasers, PMT's and acquisition cards to sort droplets containing mutants, according to their fluorescence phenotype, analyze these flow cytometry data, sequencing data and map the phenotype of thousands of mutant enzymes.

~~Picture of the distributions of phenotypes~~
Then I landed in Basel-Shaft, where I started a post-doc in the Van Nimwegen group. There I performed microfluidics experiments that are looking like these ones. All these E.coli cells are genetically identical... but still, they display very different fluorescence. Expression is stochastic you might say. Yes, but something else is stochastic: their growth-rate. And looking at dozens of experiments in different conditions, dozens thousands full cell cycles, we essentially discovered that, these growth-rate fluctuations can explain a substantial amount of protein concentration variations.

And here I am now. I am living in France across the border, me and my partner have a little boy. And we love climbing. Extremely original...

I think it's been 5 minutes. Let me talk to you about the data analysis "assignment".

## The analysis
Duration: 15 minutes

### What's the question adressed by the authors of the study?

If you infect mice with a modest amount of pneumococcus, lung infection will develop and the mice will get sick, and eventually recover. If you try to infect the mice a second time, mice immune system will remember of the previous infection, and the mice won't get that sick.

Now, what does happen, if the second time, you infect mice with a distinct serotype of pneumococcus.

Turns out that, mice won't get sick either. A phenomenon called "heterotypic immunity". Your immune system encountered a distinct serotype in the past, but it still manages to protect yourself.

What's happening? It is thought that after infection, some resident immune cells stayed within the infected lungs, and are responsible for this heterotypic immunity. But, their phenotype is largely unknown.

### What do they do?

They propose to shed light on the heterogenity of lung immune resident cells (B and T cells), by phenotyping as many B and T cell types as they can, looking at as many cell markers as they can, that is 20.

Here is the list of marker they are looking at, together with associated probes, in lung resident B and T. 
~~list of markers, CD4 and CD8 pictures probably~~

And they look at these, in 6 mice per conditions:
- preSpn, where the mice were not submitted to Pneumococcus
- saline, negative control where the mice were injected PBS
- postSpn, where mice were injected a sublethal dose of pneumococcus

To look at that many probes at the same time, they use Full Spectrum Flow Cytometry. In a nutshell, to assess cell marker expression level via its probe, the entire emission spectrum of the fluorescent probe is looked at.

For each fluorophore, the signal from all the detectors is used.
~~picture of a spectrum versus emission band~~
And in the real sample, all these signals, coming from all these probes, in all detectors are going to add up.

What you need a nice set of controls, as many controls as probes, to measure single emission spectra, that you put into a mixing matrix, that you subsequently use to unmix signals from your real sample, get to know what the amount of each probe each cell is displaying.

### Sanity checks I would have I done

#### Look at the control and sample raw data.

- Are single probe controls suitable?

- Full Spectrum Flow Cytometry requires having good controls, otherwise the unmixing procedure is prone to fail, and then you cannot say anything about your probes. An important requisite, is that control samples, should contain enough bright enough positive and negative events, that display the same autofluorescence properties.

#### Apply the unmixing procesure to the controls, generate NxN plots to check unmixing

### What do we have

- Unfortunately, raw data are not available... So I cannot really judge.
- The data, that I actually have, is a subset of the data they unmixed:
~~Picture showing the gating of single cells~~

- They got rid of the debris, and doublets using scattering properties and then they used viability staining as well as CD45 expression to select T and B cells.
- Then, they exploded the population along another cell marker, intraveinous CD45.2, to select only for extravascular cells, i.e cells residing in the lungs. And these cells are all I had access too.
- A priori, I would have kept CD45- cells.

### What next

- The proposed dataset, was not transformed for proper vizualisation. To be able to compare with their work, I did the same as what they did in Omics (asinh with a 6000 cofactor, to be able to compare distributions with them). The simpler the transform, the better.

#### Descriptive analysis

- First, I want to know how many cells I have per data set.
~~Number of cells per data set~~
- I can already see that I have much fewer cells in my controls compared to my sample.
- Certainly because cells that did not encounter pneumococcus, did not have immune cells profileration. Possibly because less events were actually recorded? We do not know. But here already, I am expecting more variability between replicates, given that we have fewer cells.
- I already foresee that having such differences in terms of number of cells might make difficult the comparison between preSpn/saline and postSpn.

#### Single marker 1D distribution

- At this point, the next thing I would have done, is to look at the 1D density distribution of all my cell markers in my data set:
	- Reproducibility checks between mice
	- Is everything alright with data transformation
	- Do I already see striking differences in terms of distributions?

Conclusion:

- We indeed witness more variability between replica for the negative controls and postSpn samples are much less variable.
- We already see, by eye, that the only marker for which their seem to be a difference, is CD69, which is depicted as a marker of T cells compartmentalized amplification within the lymph nodes (together with CD25).

#### 2d distributions (NxN plots)

- Then I would look at 2d distributions, again to check potential problems with compensation (that can arise if the controls and the samples to do not have the same emission spectrum, which can happen if beads are used for instance).

#### 2d distributions, overlaid

- If the distributions are alright, I would pool these samples, together.
- And then compare the 3 different groups, for differences.

#### Gating and analysis strategy

- The unbiased strategy is nice... but there are some things that we know, and we should use that knowledge I think to guide the analysis.
- For instance, we know that B cells are CD19+ and that Tcells are CD19-.
- So let's already gate that in our samples, and check what's the relative proportions of these two cell types in our data.



- Then, it would make sense to compare again, for these two subpopulations,
- We know that these samples contain B and T cells, which are CD45.1+ (first allele of CD45).
- CD19






NB:

There is definitely a lot of things in there. Let's go line by line.
## postSpn79 
- Against all other scattering properties, nothing interesting to say. One population, that's it. Which also means that in terms of granularity and size, all these cells make a continuum. Then the variance it self, is hard to judge for me.
- Going along *FSC-A*:
  - *B220*: a B220 negative and a B220 positive populations. The positive population is supposed to be B2 B Cells. Naive and resident memory B cells. There indeed seems to be an enrichment for these in the sample compared to controls. But we can also find these cells in the control.
  - *CD8/IgD*: CD8/IgD neg and pos populations but no difference compared to controls.
  - *CD3*: small tail as well, but no big differences when looking at the 1d histograms, that are characterized by high variability.
  - *CD4*: clear bimodal distribution (as in saline and pre). But large part of the population is negative. Could there be an over compensation issue?
  - *GL7*: Tail towards GL7+ populations. True for saline and pre...
  

- Going vertical along *PD1*: something interesting. Distribution looks slightly bimodal. Turns out, population can be exploded:
    - B220- is slightly higher in PD1, than B220+.
    - CD4+ is slightly higher in PD1 than CD4-
    - Possibly not enough correction from PD1 to CD44 channels (BV510-A to BV570)
    - CD19- cells are slightly higher in PD1 than CD19+ cells.
    - Possibly not enough correction from PD1 to CD43 channels (BV510-A to BV750)
    - CD38- cells slightly lower than CD38+ cells in PD1.
    
- Going vertical along *CD44*: -/+ populations
    - B220: CD44+B220- and CD44-B220+ which makes sense as CD44 is supposed to be a marker of memory T-cells.
    - CD8_IdG: same, but number of CD8+ positive cells is very small.
    - CD3: CD44+ are also CD3+. But this is not obvious on the final phenograph (see cluster 20 and 12).
    - CD4: CD44+ are also CD4+. But there are counter example on the final phenograph (see cluster 10, naive T-cells, but how many are there?).
    - Possibly not enough correction from PD1 to CD44 channels (BV510-A to BV570)?
    - CD19- are CD44+, CD19+ are CD44-. Coherent with Phenograph.
    - CD62L+ cells are CDD44- (very few cells)
    - CD43: Positive correlation (same cluster on the phenograph)
    - CD11a: Positive correlation (same cluster on the phenograph)
    - *CD69*: interesting and somewhat complex: lots of CD69-CD44- cells, CD69+CD44+ cells (Trm cells), and also some CD44-CD69+ (Brm cells and naive/activated B cells)
    - *CD73*: same as CD69, similar pattern: lots of CD44+CD73+, CD44-CD73-, and some CD44-CD73+. But never off together.
    - *CD38*: CD44-CD38+, CD44+CD38-. But no CD38 on the phenograph.
    - IgM: IgM+ cells are CD44-. But there is cluster 12 (a few cells that are on the top of the tail?)

- Going vertical along *CD19*:
  - B220: B220+GL19+ cells (CD19+ are actually B cells, this is the criteria used to filtering T cells). But... there are some CD19+ cells, that are not B220+.
  - 2 clusters: 4 and 12. The main difference between these two? CD44 expression. 4 is supposed to be B1 Brm cells (but, the reason escapes me), whereas 12 is supposed to be B1 Bmem cells. What's the difference?
  - CD8_IgD: 4 populations there: CD19-CD8+ (T8 Trm cells), CD19-CD8-(Various Tcells), CD19+CD8_IgD+(which are also IgM+, Bcells naive or not), CD19+CD8_IgD-(activated IgM+ Bcells).
  - CD3+ cells are CD19-. Only Tcells.
  - CD4+ cells are CD19 (vast majority)
  - GL7: GL7 cells can be either CD19+ or CD19-
  - CD62L: CD62L cells can be either CD19+ or CD19-
  - CD43: very few cells are CD43+CD19+. Most of CD43+ are CD19- (marker of T-cells activation).
  - CD11: strong correlation with CD19+ cells. CD19- cells (T-cells) are almost always CD11+.
  - CD69: 4 populations
    - CD19+CD69-: B cells
    - CD19+CD69+: Brm cells
    - CD19-CD69-: T cells (non Trm)
    - CD19+CD69+: Trm cells
  - CD73: Most of the cells are CD19+CD73- or CD19-CD73+ (as visible in the phenograph). But there are cells in the 3 quadrants.
  - CD38: all CD19+ are CD38+. Continuum CD19-CD38- to CD38+.
  - IgM: diverse degree of IgM+ for CD19+ (Bcells)
  
- Going vertical along *CD62L*. Seems interesting. It is only on for a cluster of CD4+ T Naive Cells (cluster 10).
  - CD4: CD62L+ are supposed to be CD4+ cells (according to phenograph). It does not show when plotting CD62L versus CD4. It seems that most of the cells that are CD62L+, are also CD4- (and CD3-, and CD44-). It does not show, because most of these cells are scattered in many different cluster I feel.
  - CD19:  4 populations. CD19-CD62L+ (cluster 10), CD19+CD62L+ (spread in a bunch of Bcells cluster), CD19-CD62L- (most of T cells except for cluster 10), CD19+CD62L- (spread over B-cells).
  - CD43: strange. I was expecting to see CD62L+ CD43+ on this graph. With CD62L higher for CD43+ (Tcells) than CD43- (B cells). But it is as high... maybe coming from other datasets?
  - All CD69+ cells, or... almost, are CD62L-. Which would make sense if CD62L is indeed a marker of T4 Naive cells.
  - CD38: is supposed to be memory marker. But some cells are CD62L+CD38+. I do not see them on the phenograph.






 





