<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:output method="html"/>
   
    
   
   <!-- VARIABLES XSL -->
    
    <xsl:variable name="mention">Mentions dans le texte : </xsl:variable> <!-- variable xsl : "mention", appelée avant chaque compte des mentions des différents personnages dans le corps de la lettre, 
        et permet simplement d'introduire, dans le fichier de sortie, le résultat de ces comptes -->
    
    <xsl:variable name="numero_lettre">
        <xsl:value-of select="replace(//opener/title, 'Lettre CLXXV', 'Lettre Cent soixante-quinze')"/> <!-- fonction XPath : Un replace qui permet de remplacer le numéro de la lettre écrit à l'origine en chiffres romains par une numérotation en toutes lettres. 
        J'ai choisi de stocker cette fonction dans la variable "numero_lettre" afin de pouvoir indiquer le numéro de la lettre à la fois dans ma page d'accueil et dans ma page debut_texte -->
    </xsl:variable>
    
    <xsl:variable name="siecle_1"> <!-- La variable "siecle_1" contient des conditions <xsl:choose>, qui permet de reconnaître le siècle à partir d'une date. J'ai choisi de faire cela car le texte encodé est une édition largement ultérieure à la version originale.
            J'ai donc tenté d'appliquer cette variable à la date de la parution originale du livre, et à celle de cette édition.  -->
        <xsl:choose>
            <xsl:when test="starts-with((//date)[1], '18')">
                <p>(XIXème siècle)</p>
            </xsl:when>
            <xsl:when test="starts-with((//date)[1], '17')">
                <p>(XVIIIème siècle)</p>
            </xsl:when>
            <xsl:otherwise>
                <p>(Siècle inconnu)</p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="siecle_2"> <!-- J'ai dû créer une deuxième variable, identique à la précédente pour indexer précisément chaque occurence de l'élement <date>. Si je ne le faisais pas,
    le processeur xslt s'arrêtait à la première occurence de la balise, et affichait le même siècle partout. -->
        <xsl:choose>
            <xsl:when test="starts-with((//date)[2], '18')">
                <p>(XIXème siècle)</p>
            </xsl:when>
            <xsl:when test="starts-with((//date)[2], '17')">
                <p>(XVIIIème siècle)</p>
            </xsl:when>
            <xsl:otherwise>
                <p>(Siècle inconnu)</p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <!-- VARIABLE XSL POUR LE HEAD ET LA NAVBAR DES DOCUMENTS HTML -->
    <xsl:variable name="head">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>Les liaisons dangereuses</title>
                <style>
                    body {
                    font-family: "Garamond", serif;
                    background-color: #fdfaf4;
                    line-height: 1.6;
                    padding: 40px;
                    }
                    h1 {
                    text-align: center;
                    color: #8b0000;
                    border-bottom: 2px solid #8b0000;
                    }
                </style>
            </head>
    </xsl:variable>
    
    <xsl:variable name="navbar"> <!-- Barre de navigation avec des liens hypertextes permettant d'aller d'une page à une autre. -->
        <nav class="navigation-bar">
            <a href="index_personnages.html">Index des personnages</a>
            <a href="index_lieux.html">Index des lieux</a>
            <a href="premiere_partie.html">Première partie</a>
            <a href="deuxieme_partie.html">Deuxième partie</a>
        </nav>
        <style>
            .navigation-bar {
            text-align: center; 
            padding: 20px;
            }
            
            .navigation-bar a {
            display: inline-block;
            margin: 0 20px; 
            text-decoration: none;
            color: #2c3e50;
            font-family: sans-serif;
            }
        </style>
    </xsl:variable>
    
    <!-- TEMPLATES -->
    <xsl:template match="/"> 
        <xsl:call-template name="accueil"/>
        <xsl:call-template name="index_personnages"/>
        <xsl:call-template name="index_lieux"/>
        <xsl:call-template name="premiere_partie"/>
        <xsl:call-template name="deuxieme_partie"/>
    </xsl:template>
    
    <!-- Template pour la page d'accueil -->
    <xsl:template name="accueil" match="teiHeader">
        <xsl:result-document href="accueil.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$head"/> 
                <body>
                    <main>
                        <h1><xsl:value-of select="upper-case(//monogr/title)"/></h1> <!-- fonction XPath : un upper-case() qui permet de retourner le nom de l'auteur en majuscules -->
                        <p><xsl:copy-of select="$navbar"/></p>
                        <p class="auteur">
                            <strong>Auteur : </strong>
                            <br><xsl:value-of select="tokenize(//author/name, '-')"/> </br> <!-- fonction XPath : un tokenize() qui retourne le nom de l'auteur sans les tirets (pas de réelle utilité à part des raisons esthétiques) -->
                            <br><xsl:value-of select="//author/date"/></br>
                        </p>
                        
                        <div class="edition">
                            <p><xsl:value-of select="$numero_lettre"/></p>
                            <p>Édité par : <xsl:value-of select="//editor"/></p>
                            <p>Lieu et date : <xsl:value-of select="//pubPlace"/>, <xsl:value-of select="//imprint/date"/> 
                                <xsl:copy-of select="$siecle_1"/></p>
                            <p>Publié sur internet par : <xsl:value-of select="//distributor"/></p>
                        </div>
                        
                        <hr/>
                        
                        <div class="description">
                            <h3>Informations :</h3>
                            <p><xsl:value-of select="//language"/></p>
                            <p><xsl:value-of select="//creation/date"/></p>
                            <p><xsl:value-of select="$siecle_2"/></p>
                        </div>
                    </main>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Template pour l'index des personnages -->
    <xsl:template name="index_personnages" match="div">
        <xsl:result-document href="index_personnages.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$head"/>
                
                <body>
                    <header>
                        <h1>Index des personnages mentionnés dans cette lettre</h1>
                        <p><xsl:copy-of select="$navbar"/></p>
                    </header>
                    
                    <main>
                        <section>
                            <h2>Personnages mentionnés et identifiés</h2>
                            <table class="personnages-lettre">
                                <thead>
                                    <tr>
                                        <th>Identité</th>
                                        <th>Nombre de mentions</th>
                                    </tr>
                                </thead>
                                <style>
                                .personnages-lettre {
                                margin-left: 70px; /* Ajustez la valeur selon vos besoins */
                                }
                                </style>
                                <tbody>
                                    <tr>
                                        <td><xsl:value-of select="//person[@xml:id='Vol_001']"/></td> <!-- Prédicat XPath qui permet de sélectionner le contenu de l'élément <person> dont l'attribut @xml:id est égal à 'Vol_001'(prédicat réutilisé ensuite pour chaque personnage) -->
                                        <td><xsl:value-of select="count(//persName[@ref='#Vol_001'])"/></td> <!-- fonction XPath : un count() permettant de compter le nombre de fois où les différents personnages sont mentionnés dans le texte -->
                                    </tr>
                                    <tr>
                                        <td><xsl:value-of select="//person[@xml:id='Vol_002']"/></td>
                                        <td><xsl:value-of select="count(//persName[@ref='#Vol_002'])"/></td>
                                    </tr>
                                    <tr>
                                        <td><xsl:value-of select="//person[@xml:id='Mert_001']"/></td>
                                        <td><xsl:value-of select="count(//persName[@ref='#Mert_001'])"/></td>
                                    </tr>
                                    <tr>
                                        <td><xsl:value-of select="//person[@xml:id='Dan_001']"/></td>
                                        <td><xsl:value-of select="count(//persName[@ref='#Dan_001'])"/></td>
                                    </tr>
                                    <tr>
                                        <td><xsl:value-of select="//person[@xml:id='Ros_001']"/></td>
                                        <td><xsl:value-of select="count(//persName[@ref='#Ros_001'])"/></td>
                                    </tr>
                                </tbody>
                            </table>
                        </section>
                        
                        <section class="anonymes">
                            <h2>Personnages non identifiés (Inconnus)</h2>
                            <p><em>Les personnages suivants n'ont pas de nom, ni d'identité à proprement parler dans le roman. 
                            Dans cette lettre, ils sont désignés de cette façon :</em></p>
                            <ul>
                                <xsl:for-each select="//body//persName"> <!-- Boucle qui contient une condition -->
                                    <xsl:if test="not(@ref)"> <!-- Dans les Liaisons dangereuses, certains personnages sont volontairement inconnus et non identifiés. J'ai donc du les encoder sans attribut "ref". La condition suivante,
                                        en ne cherchant que les persName qui n'ont pas d'attribut ref, permet d'afficher leurs noms tels qu'ils sont écrits dans le texte, en indiquant qu'ils ne sont pas identifiés.--> <!-- Cette condition utilise également la fonction XPath not() -->
                                        <p> <xsl:value-of select="."/> : Personnage non identifié </p>
                                    </xsl:if>
                                </xsl:for-each>
                            </ul>
                        </section>
                    </main>
                    
                    <footer>
                        <p><a href="accueil.html">Retour à l'accueil</a></p>
                    </footer>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Template pour l'index des lieux -->
    <xsl:template name="index_lieux">
        <xsl:result-document href="index_lieux.html" method="html">
            <html lang="fr">
                <xsl:copy-of select="$head"/>
                
                <body>
                    <h1>Index des lieux mentionnés dans cette lettre</h1>
                    <p><xsl:copy-of select="$navbar"/></p>
                    
                    <ul>
                        <xsl:for-each select="//listPlace/place"> <!-- Règle avec une boucle : J'ai utilisé xsl:sort pour trier les noms des lieux mentionnés dans le texte par ordre alphabétique -->
                            <xsl:sort select="./placeName" data-type="text" order="ascending"/>
                            
                            <li>
                                <p>Nom de l'endroit : <xsl:value-of select="./placeName"/></p>
                                <p>Coordonnées géographiques : <xsl:value-of select="./location/geo"/></p>
                                <p>Identifiant wikidata : <xsl:value-of select="./idno"/></p>
                            </li>
                        </xsl:for-each>
                    </ul>
                    
                    <p><a href="accueil.html">Retour à l'accueil</a></p>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
   
    
    <!-- template pour la première partie de la lettre -->
    <xsl:template name="premiere_partie" match="//body">
        <xsl:result-document href="premiere_partie.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$head"/>
                
                <body>
                    <main>
                        <h1> <xsl:value-of select="$numero_lettre"/></h1>
                        <p><xsl:copy-of select="$navbar"/></p>
                        
                         <p class="correspondants">
                            <strong>De : </strong> <xsl:value-of select="//opener/persName[@ref='#Vol_001']"/> 
                            <br/>
                            <strong>À : </strong> <xsl:value-of select="//opener/persName[@ref='#Ros_001']"/>
                        </p>  
                        
                        <hr/>
                        
                        <div class="texte-lettre">
                            <xsl:copy-of select="//body/div/p[1]"/> <!-- Prédicat XPath, qui sélectionne la première balise <p> dans le corps de la lettre -->
                            <xsl:copy-of select="//body/div/p[2]"/>
                            <xsl:copy-of select="//body/div/p[3]"/>
                            <xsl:copy-of select="//body/div/p[4]"/>
                            <xsl:copy-of select="//body/div/p[5]"/>
                        </div>
                    </main>
                    
                    <footer>
                        <p><a href="accueil.html">Retour à l'accueil</a></p>  
                        <p><p><a href="deuxieme_partie.html">Suite du texte</a></p></p>
                    </footer>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- template pour la deuxième partie de la lettre -->
    <xsl:template name="deuxieme_partie">
        <xsl:result-document href="deuxieme_partie.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$head"/>
                <head>
                    <h1> <xsl:value-of select="$numero_lettre"/></h1>
                    <p><xsl:copy-of select="$navbar"/></p>
                    
                    <link rel="stylesheet" type="text/css" href="style.css"/>
                </head>
                <body>
                    <div class="texte-lettre">
                       <p><xsl:copy-of select="//body/div/p[6]"/></p>
                       <p><xsl:copy-of select="//body/div/p[7]"/></p>
                       <p><xsl:copy-of select="//body/div/p[8]"/></p>
                       <p><xsl:copy-of select="//body/div/p[9]"/></p>
                       <p><xsl:copy-of select="//body/div/closer"/></p>
                    </div>
                    
                    <footer>
                        <p><a href="accueil.html">Retour à l'accueil</a></p>
                    </footer>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>


