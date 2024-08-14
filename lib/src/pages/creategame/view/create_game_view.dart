import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/src/core/exports/constants_exports.dart';

import '../viewmodel/create_game_view_model.dart';
import '../widget/app_button.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_textform_field.dart';
import '../widget/type_writer_text.dart';

class CreateGameView extends StatelessWidget {
  const CreateGameView({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateGameViewModel createGameViewModel =
        context.watch<CreateGameViewModel>();

    return Scaffold(
      backgroundColor: ColorConstants.lightBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TypewriterText(
              text: "Oyun Oluştur",
            ),

            80.verticalSpace,
            CustomTextFormField(
              hintText: "Oyun Adı Giriniz",
              controller: createGameViewModel.roomNameController,
            ),
            30.verticalSpace,
            CustomDropdownMenu(
                items: BoardGameColors.values
                    .map(
                      (e) => e.name,
                    )
                    .toList(),
                text: createGameViewModel.selectedBoardBGColor ??
                    "Tahta Renk Seçiniz",
                onChanged: (p0) =>
                    createGameViewModel.changeSelectedColor(p0.toString())),
            30.verticalSpace,
            CustomDropdownMenu(
                items: const ["3x3", "4x4", "5x5"],
                text: createGameViewModel.selectedBoxValue ??
                    "Tahta İçin Kutu Sayısı Seçiniz",
                onChanged: (p0) => createGameViewModel.changeSelectedBoxValue(
                      p0.toString(),
                    )),
            30.verticalSpace,
            AppButton(
              onPressed: () {
                createGameViewModel.createGameRoom();
              },
            ),
          ],
        ),
      ),
    );
  }
}
