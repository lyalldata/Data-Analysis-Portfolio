let calculation = localStorage.getItem('calculation') || '';
            
    displayResult();

    function updateCalculation(value) {
    calculation += value;
    displayResult();
    
    localStorage.setItem('calculation', calculation);
    }

    // Optional: you can also create a function in order
    // to reuse this code.
    // function saveCalculation() {
    // localStorage.setItem('calculation', calculation);
    // }

    function displayResult(){
        document.querySelector('.js-display').innerHTML = calculation;
    }

    //keydowns
    document.body.addEventListener('keydown', (event) => {
        if(event.key === '1') {
            updateCalculation('1');
        } else if(event.key === '2') {  
            updateCalculation('2');
        } else if(event.key === '3') {      
            updateCalculation('3');
        } else if(event.key === '4') {      
            updateCalculation('4');
        } else if(event.key === '5') {      
            updateCalculation('5');
        } else if(event.key === '6') {      
            updateCalculation('6');
        } else if(event.key === '7') {      
            updateCalculation('7');
        } else if(event.key === '8') {      
            updateCalculation('8');
        } else if(event.key === '9') {      
            updateCalculation('9');
        } else if(event.key === '0') {      
            updateCalculation('0');
        } else if(event.key === '+') {      
            updateCalculation('+');
        } else if(event.key === '-') {      
            updateCalculation('-');
        } else if(event.key === '*') {      
            updateCalculation('*');
        } else if(event.key === '/') {      
            updateCalculation('/');
        } else if(event.key === 'Enter') {      
            calculation = eval(calculation);
            displayResult();
        } else if(event.key === 'Escape') {      
            calculation = '';
            displayResult();
        }
    });
