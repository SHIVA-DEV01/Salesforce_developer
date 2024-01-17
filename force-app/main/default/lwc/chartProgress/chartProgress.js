import { LightningElement, track, api } from 'lwc';

const columns = [
    { label: 'Label', fieldName: 'name' },
    { label: 'Website', fieldName: 'website', type: 'url' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'CloseAt', fieldName: 'closeAt', type: 'date' },
];


export default class ChartProgress extends LightningElement {
    @track progressValue = 0;
    @api progreeEnd = 95;
    @track isShowModal = false;
    pageSizeOptionsCurrent = [5, 10, 25, 50, 75, 100]; //Page size options
    totalRecordsCurrent = 0; //Total no.of records
    pageSizeCurrent; //No.of records to be displayed per page
    totalPagesCurrent; //Total no.of pages
    pageNumberCurrent = 1; //Page number    
    recordsToDisplayCurrent = []; //Records to be displayed on the page

    circleStyle = '';


    data = [];
    columns = columns;

    get bDisableFirstCurrent() {
        return this.pageNumberCurrent == 1;
    }
    get bDisableLastCurrent() {
        if (this.totalPagesCurrent == 0) {
            return true;
        }
        else {
            return this.pageNumberCurrent == this.totalPagesCurrent;
        }

    }

    handleNext() {
        this.pageNumber = this.pageNumber + 1;
        this.getAccounts();
    }

    //handle prev
    handlePrev() {
        this.pageNumber = this.pageNumber - 1;
        this.getAccounts();
    }
    connectedCallback() {
        this.updateProgress();
        const data = [...Array(100)].map((_, index) => {
            return {
                name: `Name (${index})`,
                website: 'www.salesforce.com',
                amount: Math.floor(Math.random() * 100),
                phone: `${Math.floor(Math.random() * 9000000000) + 1000000000}`,
                closeAt: new Date(
                    Date.now() + 86400000 * Math.ceil(Math.random() * 20)
                ),
            };
        });
        this.data = data;
        // For Pagination of the table....
        this.totalRecordsCurrent = data.length; // update total records count         
        this.pageSizeCurrent = this.pageSizeOptionsCurrent[2]; //set pageSize with default value as first option
        this.paginationCurrentHelper(); // call helper menthod to update pagination logic
        // }
    }



    handleClick() {
        this.isShowModal = true;
    }

    hideModalBox() {
        this.isShowModal = false;
    }

    updateProgress() {
        let progressStartValue = 0;
        const progressEndValue = this.progreeEnd;
        const speed = 100;

        const progressInterval = setInterval(() => {
            if (progressEndValue === 0) {
                clearInterval(progressInterval);
            }
            else {
                progressStartValue++;
                this.progressValue = progressStartValue;
            }
            this.circleStyle = progressStartValue <= 30 ? `background: conic-gradient(#2D3436 ${progressStartValue * 3.6}deg, #ededed 0deg)` : progressStartValue <= 60 ? `background: conic-gradient(#41cbf2 ${progressStartValue * 3.6}deg, #ededed 0deg)` : progressStartValue <= 90 ? `background: conic-gradient(#e6f241 ${progressStartValue * 3.6}deg, #ededed 0deg)` : `background: conic-gradient(#f26d41 ${progressStartValue * 3.6}deg, #ededed 0deg)`;
            if (progressStartValue === progressEndValue) {
                clearInterval(progressInterval);
            }
        }, speed);
    }

    handleCurrentRecordsPerPage(event) {
		this.pageSizeCurrent = event.target.value;
		this.paginationCurrentHelper();
	}
	currentPreviousPage() {
		this.pageNumberCurrent = this.pageNumberCurrent - 1;
		this.paginationCurrentHelper();
	}
	currentNextPage() {
		this.pageNumberCurrent = this.pageNumberCurrent + 1;
		this.paginationCurrentHelper();
	}
	currentFirstPage() {
		this.pageNumberCurrent = 1;
		this.paginationCurrentHelper();
	}
	currentLastPage() {
		this.pageNumberCurrent = this.totalPagesCurrent;
		this.paginationCurrentHelper();
	}

    paginationCurrentHelper() {
		this.recordsToDisplayCurrent = [];
		// calculate total pages
		this.totalPagesCurrent = Math.ceil(this.totalRecordsCurrent / this.pageSizeCurrent);
		// set page number 
		if (this.pageNumberCurrent <= 1) {
			this.pageNumberCurrent = 1;
		} else if (this.pageNumberCurrent >= this.totalPagesCurrent) {
			this.pageNumberCurrent = this.totalPagesCurrent;
		}
		// set records to display on current page 
		for (let i = (this.pageNumberCurrent - 1) * this.pageSizeCurrent; i < this.pageNumberCurrent * this.pageSizeCurrent; i++) {
			if (i === this.totalRecordsCurrent) {
				break;
			}
			this.recordsToDisplayCurrent.push(this.data[i]);
		}

	}

}