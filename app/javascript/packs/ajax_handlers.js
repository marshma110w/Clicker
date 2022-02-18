handleAjax = function(event){
    const level = document.getElementById('level')
    const score = document.getElementById('score')
    const next = document.getElementById('next_lvl')

    console.log('AJAX handled')
    const answer = event.detail[0]
    console.log(answer)
    if (answer['action'] == 'click'){
        score.innerText = answer['score']
    }
    else if (answer['action'] == 'level_up'){
        level.innerText = answer['level']
        score.innerText = answer['score']
        next.innerText = (answer['level']*10)**2
    }
}


document.addEventListener('ajax:success', handleAjax)