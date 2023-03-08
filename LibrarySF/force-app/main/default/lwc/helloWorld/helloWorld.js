import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    imclicked(event){
        console.log("HELLO!"+event.clientX+event.clientY);
        
    }
}