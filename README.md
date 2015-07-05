# Edit2w
An TEdit with a Query routine integrated to make easier searchs. 

### Installing

* Open a new Package on Delphi (File > New > Package).
* On the Project Manager add the files of src folder to the package (right click > Add) and rename the package.
* Compile and Install (right click > Compile/Install).

Now the component will apear in the Standart pallete in your Tool Pallete.

### Instalando

* Abra um novo Package no Delphi (File > New > Package).
* No Project Manager adicione os arquivos da pasta src no pacote (Click com botão direito > Add) e renomeie o pacote.
* Compile e Instale (Click com botão direito > Compile/Install).

Agora o componente ira aparecer na paleta Standart no seu Tool Pallete.

### Setting up 

* ADBConnection : It's your database connection, It works through a TSQLConnection;
* ATable        : The table or view you want to search; 
* AOpenScreen   : Doesn't work, soon to be disabled.
* AFieldsToShow : The fields that you want to show in the Grid.

  You can have how many fields you want, just use ';' as delimiter. Example: COSTUMERID;NAME;PHONE
  
* AFilter       : TODO - If you want to filter the results of the query.
* Result        : After you the execution your query the result will be stored in this field as a String.
* AFieldToSearch: The fields that you want to search.  
  You can have two fields, the first will be for the ID of the table, so if you only digit numbers the where will use a '=' instead of a 'like'
* AFieldToResult: string;

