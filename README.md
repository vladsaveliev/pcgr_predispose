## Personal Cancer Genome Reporter - cancer predisposition report

### Overview

*pcgr_predispose* is a Docker-based workflow standing on the shoulders of [PCGR - Personal Cancer Genome Reporter](https://github.com/sigven). While PCGR focuses on the report of somatic variants, *pcgr_predispose* is intended for reporting of germline variants that may be of relevance for cancer predisposition.

As is the case for PCGR, *pcgr_predispose* accepts a query file encoded in the [VCF](https://samtools.github.io/hts-specs/VCFv4.2.pdf) format (i.e. analyzing SNVs and InDels). The software reports, for a selected set of known (configurable) cancer predisposition genes, two main sets of variants:

1. Germline variants that are previously reported as pathogenic/likely pathogenic/uncertain significance in ClinVar (with no conflicting interpretations)
2. Unclassified (i.e. not found in [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/)) protein-coding germline variants that are either:
	* *Novel* (i.e. not found in [gnomAD](http://gnomad.broadinstitute.org/)), or
	* *Rare* (MAF <= 0.001 in the [gnomAD](http://gnomad.broadinstitute.org/) European population)

### Example report

* [Cancer predisposition report](http://folk.uio.no/sigven/example.pcgr_predispose.html)

### Annotation resources included in _pcgr_predispose_ - 0.1.0

* [VEP v92](http://www.ensembl.org/info/docs/tools/vep/index.html) - Variant Effect Predictor release 92 (GENCODE v19/v28 as the gene reference dataset)
* [dBNSFP v3.5](https://sites.google.com/site/jpopgen/dbNSFP) - Database of non-synonymous functional predictions (August 2017)
* [gnomAD r2](http://gnomad.broadinstitute.org/) - Germline variant frequencies exome-wide (October 2017)
* [dbSNP b150](http://www.ncbi.nlm.nih.gov/SNP/) - Database of short genetic variants (February 2017)
* [1000 Genomes Project - phase3](ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/) - Germline variant frequencies genome-wide (May 2013)
* [ClinVar](http://www.ncbi.nlm.nih.gov/clinvar/) - Database of clinically related variants (April 2018)
* [DisGeNET](http://www.disgenet.org) - Database of gene-disease associations (v5.0, May 2017)
* [UniProt/SwissProt KnowledgeBase 2018_03](http://www.uniprot.org) - Resource on protein sequence and functional information (March 2018)
* [Pfam v31](http://pfam.xfam.org) - Database of protein families and domains (March 2017)
* [TSGene v2.0](http://bioinfo.mc.vanderbilt.edu/TSGene/) - Tumor suppressor/oncogene database (November 2015)

### News

* April 25th 2018 - 0.1.0 release

### Getting started

#### STEP 0: Set up PCGR

Make sure you have a working installation of the latest PCGR release (0.6*) (walk through [steps 0-3](https://github.com/sigven/pcgr#getting-started)).

#### STEP 1: Download the latest release

Download the [latest release](https://github.com/sigven/releases/) of *pcgr_predispose* (run script and configuration file)

#### STEP 2: Configuration

A few elements of the workflow can be figured using the *pcgr_predispose* configuration file, encoded in [TOML](https://github.com/toml-lang/toml) (an easy to read file format).

The initial step of the workflow performs [VCF validation](https://github.com/EBIvariation/vcf-validator) on the input VCF file. This procedure is very strict, and often causes the workflow to return an error due to various violations of the VCF specification. If the user trusts that the most critical parts of the input VCF is properly encoded,  a setting in the configuration file (`vcf_validation = false`) can be used to turn off VCF validation.

An exhaustive, pre-defined list of cancer predisposition genes can also be configured.

#### STEP 3: Run example

Run the workflow with **pcgr_predispose.py**, which takes the following arguments and options:

	usage: pcgr_predispose.py [-h] [--input_vcf INPUT_VCF] [--force_overwrite]
					 [--version] [--basic]
					 pcgr_base_dir output_dir {grch37,grch38}
					 configuration_file sample_id

	Personal Cancer Genome Reporter (PCGR) workflow for report of cancer-
	predisposing germline variants

	positional arguments:
	pcgr_base_dir         Directory that contains the PCGR data bundle
				    directory, e.g. ~/pcgr-0.6.0
	output_dir            Output directory
	{grch37,grch38}       Genome assembly build: grch37 or grch38
	configuration_file    Configuration file (TOML format)
	sample_id             Sample identifier - prefix for output files

	optional arguments:
	-h, --help            show this help message and exit
	--input_vcf INPUT_VCF
				    VCF input file with somatic query variants
				    (SNVs/InDels). (default: None)
	--force_overwrite     By default, the script will fail with an error if any
				    output file already exists. You can force the
				    overwrite of existing result files by using this flag
				    (default: False)
	--version             show program's version number and exit
	--basic               Run functional variant annotation on VCF through
				    VEP/vcfanno, omit report generation (STEP 4) (default:
				    False)



The *pcgr_predispose* software bundle contains an example VCF file. It also contains a configuration file (*pcgr_predispose.toml*). Analysis of the example VCF can be performed by the following command:

`python ~/pcgr_predispose-0.1.0/pcgr_predispose.py --input_vcf ~/pcgr_predispose-0.1.0/example.vcf.gz`
` ~/pcgr-0.6.0 ~/pcgr_predispose-0.1.0 grch37 ~/pcgr_predispose-0.1.0/pcgr_predispose_config.toml example`

Note that the example command also refers to the PCGR directory (*pcgr-0.6.0*), which needs to be present (see **STEP 0**)

This command will run the Docker-based *pcgr_predispose* workflow and produce the following output files in the _pcgr_predispose_ folder:

  1. __example.pcgr_predispose.pass.vcf.gz (.tbi)__ - Bgzipped VCF file with functional/clinical annotations
  2. __example.pcgr_predispose.pass.tsv.gz__ - Compressed TSV file with functional/clinical annotations
  3. __example.pcgr_predispose.html__ - HTML report with clinically relevant variant in cancer predisposition genes
  4. __example.pcgr_predispose.json__ - JSON dump of HTML report content


### Contact

sigven@ifi.uio.no
