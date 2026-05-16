import { LightningElement,track } from 'lwc';
const Delay = 300;
export default class MovieSearch extends LightningElement {

    SelectedType = "";
    selectedSearch = "";
    selectedPagenumber = "1";
    loading = false;
    delayTimeout;
    searchResult = [];

    get typeOptions() {
    return [
         { label: 'None', value: '' },
        { label: 'Movie', value: 'movie' },
        { label: 'Series', value: 'series' },
        { label: 'Episode', value: 'episode' }
    ];
}
handleChange(event){
    let {name ,  value} = event.target;
    this.loading = true;
    if(name== 'type'){
        console.log('----name---',name);
        this.SelectedType = value;
        console.log('----this.SelectedType---',this.SelectedType);
    }else if(name == 'Search'){
        this.selectedSearch = value;
        console.log('----this.selectedSearch---',this.selectedSearch);
    }else if(name == 'pagenumber'){
        this.selectedPagenumber = value;
        console.log('-----this.selectedPagenumber---',this.selectedPagenumber);
        
        }
        clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(()=>{
        this.searchMovie();
    },Delay);
 }
async searchMovie(){
    const url = `https://www.omdbapi.com/?s=${this.selectedSearch}&type=${this.SelectedType}&page=${this.selectedPagenumber}&apikey=3b531ffb`;
    console.log('----url---',url);
    const res = await fetch(url);
    console.log('---res----',res);
    const data = await res.json();
    console.log('movie search output',data);
    this.loading = false;
    if(data.Response == 'True'){
        this.searchResult = data.Search;

    }
}

get displaySearchResult(){
    return this.searchResult.length > 0 ? true : false;
    console.log('-----this.searchResult.length-----', this.searchResult.length);
}
}