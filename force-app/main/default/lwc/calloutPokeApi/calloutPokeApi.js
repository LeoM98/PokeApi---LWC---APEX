import { LightningElement, track} from 'lwc';
import getAllPokemons from '@salesforce/apex/CalloutPokeApi.getAllPokemons';

const columns = [
    { label: 'Nombre', fieldName: 'name', type: 'text' },
    { label: 'Sitio Web', fieldName: 'url', type: 'url' },

];
export default class CalloutPokeApi extends LightningElement {

    @track error;
    @track pokemonList = [];
    @track cols = columns;

    connectedCallback(){
        getAllPokemons()
        .then((result)=>{
            this.pokemonList = result;
            this.error = undefined;
        })
        .catch(error =>{
            this.error = error;
            this.pokemonList = undefined;
        });
    }

}