import { LightningElement, wire } from 'lwc';
import getTopTracks from '@salesforce/apex/IntegrateSpotifyWithSalesforce.getTopTracks';

export default class SpotifyWithSalesforce extends LightningElement {
    topTracks=[];

    connectedCallback() {
        console.log('Testrstcnoron');
        getTopTracks({})
            .then(result => {
                console.log('Testrstcnoron');
                console.log('Result >>>>>> ', result);
                result.tracks.forEach(track => {
                    console.log('element >>>>>>> ', track);
                    let temp = {
                            imageUrl: track.album.images.length > 0 ? track.album.images[0].url : '',
                            artistName: track.artists.length > 0 ? track.artists[0].name : '',
                            name: track.name,
                            preview_url: track.preview_url,
                            id: track.id
                    };
                    this.topTracks.push(temp);

                });
                console.log('topTracks',this.topTracks);
                // this.topTracks = result.tracks.map(track => ({
                //     ...track,
                //     imageUrl: track.album.images.length > 0 ? track.album.images[0].url : '',
                //     artistName: track.artists.length > 0 ? track.artists[0].name : ''
                // }));
                // console.log('Track  >>>>>> ', this.topTracks);

            })
            .catch(error => {
                console.log(' Weather error  !!!!!!! ', error);
            })
    }

    // @wire(getTopTracks)
    // wiredTopTracks({ error, data }) {
    //     if (data) {
    //         console.log('Data >>>>>>>>', data);
    //         this.topTracks = data.map(track => ({
    //             ...track,
    //             imageUrl: track.album.images.length > 0 ? track.album.images[0].url : '',
    //             artistName: track.artists.length > 0 ? track.artists[0].name : ''
    //         }));
    //         console.log('this.topTracks >>>>> ', this.topTracks);
    //     } else if (error) {
    //         console.error('Error retrieving top tracks:', error);
    //     }
    // }
}