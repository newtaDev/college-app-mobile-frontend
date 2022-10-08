import '../../../../shared/helpers/helpers.dart';
import 'profile.dart';

const assetImage = 'assets/images/profile_pic.png';

final profile = Profile(
  id: '1',
  name: 'Newton Michael 💙',
  profilePic: Helpers.randomImages[2],
  bannerPic: Helpers.randomImages[1],
  username: '@newta',
  tags: ['Flutter', 'Dart', 'Creative'],
  description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc ut aliquam tincidunt, nunc nisl aliquam nisl, eu aliquam nunc nisl euismod nunc. Sed euismod, nunc ut aliquam tincidunt, nunc nisl aliquam nisl, eu aliquam nunc nisl euismod nunc.',
  slogan:
      '💙 Flutter Freelance Dev | ✍🏽 Technical writer | Exploring 💫 creative coding',
);
