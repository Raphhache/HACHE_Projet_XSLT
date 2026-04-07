# HACHE_Projet_XSLT

# Objectif du projet 

Ce projet consiste en la transformation d'un texte issu d'un projet XML-TEI en HTML grâce à XSLT. 

# Texte encodé 

Mon projet XML-TEI avait pour but d'encoder trois textes issus de romans épistolaires francophones de l'époque moderne. J'ai choisi de ne sélectionner qu'un seul de ces trois textes pour la transformation en HTML. Mon choix s'est porté sur la lettre cent soixante-quinze des __Liaisons dangereuses__, célèbre roman publié par Choderlos de Laclos en 1782.

J'ai choisi ce texte car j'apprécie particulièrement ce roman, que j'ai étudié au cours de mes études supérieures.

# Contenu et organisation du dépôt 

- HACHE_texte_encodé.xml : Lettre cent soixante-quinze des __Liaisons dangereuses__ encodée en XML-TEI.
  
- HACHE_feuille_style.xsl : Feuile de style XSL permettant la transformation.
  
- accueil.html : Page d'accueil du site, contenant quelques informations sur le roman, l'édition utilisée et l'auteur (faite à partir de la teiHeader du document xml).

- index_personnages.html : Index des personnages évoqués dans cette lettre.
  
- index_lieux.html : Index des lieux évoqués dans cette lettre.

Dans la transformation, j'ai choisi de scinder la lettre en deux parties, chacune visible dans une page html différente. Ce choix repose sur une division plutôt thématique du texte : la première partie évoque la vie de Mme de Merteuil, et la deuxième le sort de Cécile de Volanges et de son union avec le chevalier Danceny. 

- premiere_partie.html : Page html dans laquelle apparaît la première partie du texte (en-tête et cinq premiers paragraphes de la lettre)
  
- deuxieme_partie.html : Page html dans laquelle apparaît la deuxième partie du texte (quatre premiers paragraphes de la lettre, puis date et lieu)
