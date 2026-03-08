// Depoimentos alternáveis para a seção de depoimentos
const depoimentos = [
  { texto: "Simplesmente amei o resultado dos meus cílios! Atendimento impecável e ambiente super aconchegante.", autor: "— Mariana Souza" },
  { texto: "Minhas unhas ficaram perfeitas e duraram semanas. Recomendo de olhos fechados!", autor: "— Camila Ribeiro" },
  { texto: "Equipe muito atenciosa, trabalho delicado e de alta qualidade. Já virei cliente fiel!", autor: "— Juliana Lima" },
  { texto: "Nunca fui tão bem atendida, o resultado ficou maravilhoso!", autor: "— Fernanda Alves" },
  { texto: "Ambiente limpo, profissionais cuidadosas e resultado incrível.", autor: "— Bianca Martins" },
  { texto: "Amei o alongamento de cílios, ficou super natural!", autor: "— Priscila Duarte" },
  { texto: "Unhas lindas, atendimento rápido e eficiente. Super recomendo!", autor: "— Larissa Costa" },
  { texto: "Me senti muito especial, voltarei sempre!", autor: "— Rafaela Torres" },
  { texto: "O melhor lugar para cuidar da beleza, amei tudo!", autor: "— Gabriela Nunes" },
  { texto: "Profissionais excelentes, resultado impecável.", autor: "— Aline Ferreira" },
  { texto: "Atendimento diferenciado, ambiente acolhedor e resultado perfeito!", autor: "— Paula Mendes" },
  { texto: "Fui indicada por uma amiga e amei, virei cliente fiel!", autor: "— Tainá Rocha" }
];

const cards = document.querySelectorAll('.testimonial-card');
let usados = [];

cards.forEach((card) => {
  let depIdx;
  do {
    depIdx = Math.floor(Math.random() * depoimentos.length);
  } while (usados.includes(depIdx));
  usados.push(depIdx);
  card.querySelector('.testimonial-text').textContent = depoimentos[depIdx].texto;
  card.querySelector('.testimonial-author').textContent = depoimentos[depIdx].autor;
});
