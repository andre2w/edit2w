# Edit2w

###English
An TEdit with a Query routine integrated to make easier searchs. 

#### Installing

* Open a new Package on Delphi (File > New > Package).
* On the Project Manager add the files of src folder to the package (right click > Add) and rename the package.
* Compile and Install (right click > Compile/Install).

Now the component will apear in the Standart pallete in your Tool Pallete.

#### Setting up 

* ADBConnection : It's your database connection, It works with DBExpress and FireDAC.
* FAConnectionType : DBX for DBExpress, and FDC for FireDAC.
* ATable        : The table or view you want to search.
* AOpenScreen   : Y/N field. If you want the screen to show when the query returns more than one result.
* AFieldsToShow : The fields that you want to show in the Grid.

  You can have how many fields you want, just use ';' as delimiter. Example: COSTUMERID;NAME;PHONE
  
* AFilter       : TODO - If you want to filter the results of the query.
* Result        : After you the execution your query the result will be stored in this field as a String.
* AFieldToSearch: The fields that you want to search.  
* 
  You can have two fields, the first will be for the ID of the table, so if you only digit numbers the where will use a '=' instead of a 'like'.

* AFieldToResult: It's the field that you want as result, it always return a String.
* ALanguage: EN for english, and PT for portuguese.






###Português

#### Instalando

* Abra um novo Package no Delphi (File > New > Package).
* No Project Manager adicione os arquivos da pasta src no pacote (Click com botão direito > Add) e renomeie o pacote.
* Compile e Instale (Click com botão direito > Compile/Install).

Agora o componente ira aparecer na paleta Standart no seu Tool Pallete.

#### Configurando

* ADBConnection : É a sua conexão com o banco de dados, funciona com o DBExpress ou FireDAC. 
* FAConnectionType : DBX para DBExpress, e FDC para FireDAC.
* ATable        : A tabela ou view em que você deseja pesquisar.
* AOpenScreen   : Caso você deseja mostar uma janela com os resultados quando a query retornar mais de um resultado preencha com Y, senão N;
* AFieldsToShow : Campos para mostar na tela de pesquisa.

  Você pode usar quantos campos quiser, somente usar o delimitador ';'. Exemplo: CLIENTEID;NOME;TELEFONE
  
* AFilter       : Caso você deseje filtrar os resultados da query. Exemplo: CEP = 87200000
* Result        : Campo aonde o resultado será armazenado, ele sempre retornara uma string.
* AFieldToSearch: Campos que você deseja procurar.  

  Você pode ter até dois campos, o primeiro deve ser o ID da tabela, caso não houver letras ele ira usar '=', caso contrarior ele pesquisa pelo segundo campo utilizando o 'like'.

* AFieldToResult: Campo que você deseja retornar. sempre sera uma String.
* ALanguage: EN para Ingles, and PT para Portugues.


