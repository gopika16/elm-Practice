const firstYear = 2000
const secondYear = 2030
const leapYears = []
for (let i = firstYear+1 ; i<secondYear ;i++) {
    if (i % 4 == 0 || (i % 100 == 0 && i % 400 == 0) ) {
        leapYears.push(i)
    }
}
console.log(leapYears)
// VM298:9 (7) [2004, 2008, 2012, 2016, 2020, 2024, 2028]





//4


function getLeapYears(first, second, arr) {
    if (first % 4 == 0 || (first % 100 == 0 && first % 400 == 0) ) {
        arr.push(first)
    }
    if (first == second) {
        return
    } else {
        getLeapYears(first+1, second, arr)
    }
}

const arr = []
getLeapYears(1000, 2000, arr)
