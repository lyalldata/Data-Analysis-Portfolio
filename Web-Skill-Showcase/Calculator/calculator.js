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
