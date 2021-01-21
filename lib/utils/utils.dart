class Utils {
  String formatDate(DateTime dateTime) {
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }

  String convertMonth(String md) {
    switch (md) {
      case "01":
        return "Jan";
        break;

      case "02":
        return "Fev";
        break;

      case "03":
        return "Mar";
        break;

      case "04":
        return "Avr";
        break;

      case "05":
        return "Mai";
        break;

      case "06":
        return "Juin";
        break;

      case "07":
        return "Juil";
        break;

      case "08":
        return "Aout";
        break;

      case "09":
        return "Sep";
        break;

      case "10":
        return "Oct";
        break;

      case "11":
        return "Nov";
        break;

      case "12":
        return "Dec";
        break;

      default:
        return 'Format incorrect';
    }
  }

  String parseMonh(int montNum){
    switch (montNum) {
      case 1:
        return "Janvier";
        break;

      case 2:
        return "Fevrier";
        break;

      case 3:
        return "Mars";
        break;

      case 4:
        return "Avril";
        break;

      case 5:
        return "Mai";
        break;

      case 6:
        return "Juin";
        break;

      case 7:
        return "Juillet";
        break;

      case 8:
        return "Août";
        break;

      case 9:
        return "Septembre";
        break;

      case 10:
        return "Octobre";
        break;

      case 11:
        return "Novembre";
        break;

      case 12:
        return "Decembre";
        break;

      default:
        return 'Format incorrect';
    }
  }

  String displayDate(String jsonDate) {
    var mois = convertMonth(jsonDate.substring(5, 7));
    return "${jsonDate.substring(8, 10)} $mois, ${jsonDate.substring(0, 4)}";
  }
}
