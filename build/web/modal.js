/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* global handleClick */

const modalHandler = document.querySelector('.modalHandler');
const modal = document.querySelector('.modal');

modalHandler.addEventListener('click', handleClick);

function handleClick(event){
    modal.classList.toggle('d-block');
    modal.style.backdropFilter = 'blur(10px)';
}
