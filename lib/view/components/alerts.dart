import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

showSuccessAlert(BuildContext context, [title, message]) {
  ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success, title: title, text: message));
}

showErrorAlert(BuildContext context, [title, message]) {
  ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger, title: title, text: message));
}

showInfoAlert(BuildContext context, [title, message]) {
  ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info, title: title, text: message));
}
