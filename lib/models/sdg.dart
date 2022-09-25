// ignore_for_file: public_member_api_docs, sort_constructors_first
class SDG {
  String goal;
  String name;
  int subtitle;
  String description;
  String image;
  String header;
  SDG({
    required this.goal,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.header,
  });

  static List<SDG> generateList() {
    return [
      SDG(
          goal: 'Goal 1',
          name: 'No Poverty',
          subtitle: 0,
          description: 'End Poverty In All Its Forms Everywhere',
          image: 'assets/1.png',
          header:
              'https://drive.google.com/uc?export=view&id=1XjuT6BPQHyKDOnsfMTycpSIUL7r2gXVh'),
      SDG(
        goal: 'Goal 2',
        name: 'Zero Hunger',
        subtitle: 0,
        description:
            'End Hunger, achieve food security and improved nutrition and promote sustainable agriculture.',
        image: 'assets/2.png',
        header:
            'https://drive.google.com/uc?export=view&id=1AJFqaSR7tFznRk4R7EQHmKY-0DFi5_6W',
      ),
      SDG(
        goal: 'Goal 3',
        name: 'Good Health and Well-Being',
        subtitle: 0,
        description:
            'Ensure healthy lives and promote well-being for all at all ages.',
        image: 'assets/3.png',
        header:
            'https://drive.google.com/uc?export=view&id=1uvviJvAn_5gj0jYYeOFgWeX3DaZdDsQR',
      ),
      SDG(
          goal: 'Goal 4',
          name: 'Quality Education',
          subtitle: 0,
          description:
              'Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all.',
          image: 'assets/4.png',
          header:
              'https://drive.google.com/uc?export=view&id=19fQ5FhRQBR8vI2L6zcCPNc6STM_IFFYh'),
      SDG(
          goal: 'Goal 5',
          name: 'Gender Equality',
          subtitle: 0,
          description:
              'Achieve gender equality and empower all women and girls.',
          image: 'assets/5.png',
          header:
              'https://drive.google.com/uc?export=view&id=1FoeyKzOyVe9v3kJ24r2QdFdEVnzbBPC3'),
      SDG(
          goal: 'Goal 6',
          name: 'Clean Water and Sanitation',
          subtitle: 0,
          description:
              'Ensure availability and sustainable management of water and sanitation for all.',
          image: 'assets/6.png',
          header:
              'https://drive.google.com/uc?export=view&id=16OGcGwiokjlBe-2a7OX7GyT1RTuNCgKA'),
      SDG(
          goal: 'Goal 7',
          name: 'Affordable and Clean Energy',
          subtitle: 0,
          description:
              'Ensure access to affordable, reliable, sustainable and modern energy for all.',
          image: 'assets/7.png',
          header:
              'https://drive.google.com/uc?export=view&id=1I77A9zR0OsT_gJJFUzz-6BSFP196hpY3'),
      SDG(
          goal: 'Goal 8',
          name: 'Decent Work and Economic Growth',
          subtitle: 0,
          description:
              'Promote sustained, inclusive and sustainable economic growth, full and productive employment and decent work for all.',
          image: 'assets/8.png',
          header:
              'https://drive.google.com/uc?export=view&id=1uf8lzjHCnBXks9MpU0bFC4zeAG8alCFA'),
      SDG(
          goal: 'Goal 9',
          name: 'Industry, Innovation, and Infrastructure',
          subtitle: 0,
          description:
              'Build resilient infrastructure, promote inclusive and sustainable industrialization and foster innovation.',
          image: 'assets/9.png',
          header:
              'https://drive.google.com/uc?export=view&id=1l1UiAz23KpVk-Ok0C_W9IbKKGtyV-CdA'),
      SDG(
          goal: 'Goal 10',
          name: 'Reduced Inequalities',
          subtitle: 0,
          description: 'Reduce inequality within and among countries',
          image: 'assets/10.png',
          header:
              'https://drive.google.com/uc?export=view&id=10jDkf99736leLjzwFA1rqJL_PxsNMc-e'),
      SDG(
          goal: 'Goal 11',
          name: 'Sustainable Cities and Communities',
          subtitle: 0,
          description:
              'Make cities and human settlements inclusive, safe, resilient and sustainable.',
          image: 'assets/11.png',
          header:
              'https://drive.google.com/uc?export=view&id=1agaBoct0L_cE7gn5zAPHp5qxyBVdG0Sq'),
      SDG(
          goal: 'Goal 12',
          name: 'Responsible Consumption and Production',
          subtitle: 0,
          description:
              'Ensure sustainable consumption and production patterns.',
          image: 'assets/12.png',
          header:
              'https://drive.google.com/uc?export=view&id=1Zsc6oinyLQ7u8nk7o_q4I5UWUFfivQdf'),
      SDG(
          goal: 'Goal 13',
          name: 'Climate Action',
          subtitle: 0,
          description:
              'Take urgent action to combat climate change and its impacts',
          image: 'assets/13.png',
          header:
              'https://drive.google.com/uc?export=view&id=19GMEOkYoZ_FfzIdtOaqvwvJxHOxF1HO1'),
      SDG(
          goal: 'Goal 14',
          name: 'Life Below Water',
          subtitle: 0,
          description:
              'Conserve and sustainably use the oceans, seas and marine resources for sustainable development.',
          image: 'assets/14.png',
          header:
              'https://drive.google.com/uc?export=view&id=1dkBu99yeG2qX3oU_x6Pq0EuXrwfaXJeB'),
      SDG(
          goal: 'Goal 15',
          name: 'Life on Land',
          subtitle: 0,
          description:
              'Protect, restore and promote sustainable use of terrestrial ecosystems, sustainably manage forests, combat desertification, and halt and reverse land degradation and halt biodiversity loss.',
          image: 'assets/15.png',
          header:
              'https://drive.google.com/uc?export=view&id=1StWIsrhVM682ek-aHWV90WxvpIx0rWwG'),
      SDG(
          goal: 'Goal 16',
          name: 'Peace, Justice, and Strong Institutions',
          subtitle: 0,
          description:
              'Promote peaceful and inclusive societies for sustainable development, provide access to justice for all and build effective, accountable and inclusive institutions at all levels.',
          image: 'assets/16.png',
          header:
              'https://drive.google.com/uc?export=view&id=1YibnuVx5Z9v_Bixo5Trxr39_NcK5ZA9P'),
      SDG(
          goal: 'Goal 17',
          name: 'Partnership for the goals',
          subtitle: 0,
          description:
              'Strengthen the means of implementation and revitalize the Global Partnership for Sustainable Development.',
          image: 'assets/17.png',
          header:
              'https://drive.google.com/uc?export=view&id=1MmmuNZBcyBcnd7NKOKnIn3jJkSEUf-kD'),
    ];
  }
}
