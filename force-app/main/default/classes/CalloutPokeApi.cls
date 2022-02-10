public with sharing class CalloutPokeApi{

    public static final String URL = 'https://pokeapi.co/api/v2/pokemon?limit=10';
    @AuraEnabled(cacheable = true)
    public static List<Object> getAllPokemons(){

        //Instanciar las clases Http, HttpRequest y HttpResponse
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL) ;
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> results = new Map<String, Object>();
        List<Object> listResponse = new List<Object>();
        Integer counter = 0;
        Map<String, Object> pokeName = new Map<String, Object>();
        List<String> name = new List<String>();
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200){
            // Deserialize the JSON string into collections of primitive data types.
            results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            listResponse = (List<Object>)results.get('results');
        }

        if (!listResponse.isEmpty()){
            for (Object o : listResponse){
                pokeName = (Map<String, Object>)o;
                if (counter < 10){
                    name.add((String) pokeName.get('name'));
                }
            }
        }

        System.debug('Name Poke: ' + name);
        return listResponse;
    }

}