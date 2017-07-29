// https://www.codewars.com/kata/l1-bartender-drinks/train/javascript

const getDrinkByProfession = param => ({
  jabroni: 'Patron Tequila',
  school_counselor: 'Anything with Alcohol',
  programmer: 'Hipster Craft Beer',
  bike_gang_member: 'Moonshine',
  politician: 'Your tax dollars',
  rapper: 'Cristal',
}[param.toLowerCase().replace(/ /g, '_')] || 'Beer')
