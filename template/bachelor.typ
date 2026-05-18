#import "/template.typ": (
  Assign, IfElseChain, Return, While, algorithm, capfig, capsubfig, captab, multicite, nwpu-thesis, zh
)

#let three-line-table(..args) = {
  let named = args.named()
  let pos = args.pos()
  table(
    stroke: none,
    ..named,
    table.hline(y: 0, stroke: 1.5pt),
    table.hline(y: 1, stroke: 0.5pt),
    ..pos,
    table.hline(stroke: 1.5pt),
  )
}

#show: nwpu-thesis.with(
  anonymous: false, // 是否开启盲审模式
  info: (
    title: ("异构无人机集群通信网络", "路由规划方法研究"),
    author: "秦紫玄",
    major: "计算机科学与技术",
    supervisor: ("陈进朝", "教授"),
    submit-date: (year: 2026, month: 6),
  ),
  abstract: (
    content: [
      异构无人机集群通信网络是无人机协同通信的重要形式。与同构无人机系统相比，异构无人机集群中不同 UAV 在最大速度、覆盖半径、通信带宽、发射功率、缓存容量和能量容量等方面存在差异，可根据任务需求承担区域覆盖、空中转发和数据汇聚等不同角色。由多架异构 UAV 构成的通信网络能够通过 UAV–地面节点链路提供任务区域覆盖，通过 UAV–UAV 链路实现空中数据转发，并通过 UAV–Sink 链路完成数据汇聚，因此适用于临时通信、区域监测和灾后应急通信等场景。

      由于 UAV 飞行轨迹会影响地面覆盖范围和链路传输质量，链路速率又会影响缓存队列泄放能力，而高速飞行和高功率发射还会加速能量消耗，异构无人机集群通信网络路由规划问题具有高维、非线性、非光滑和强时序耦合等特点。针对元启发式算法在高维连续优化问题中的局限性，围绕异构无人机集群通信网络动态路由规划方法展开研究。

      本文重点关注灾后应急通信应用中通信基础设施受损、地面任务数据持续产生和网络需快速重组的情形。在该场景下，路由规划方法并不等同于传统网络中的固定路径选择或单纯下一跳决策，而是需要结合 UAV 的运动控制、覆盖关系、链路速率和队列状态，对 UAV 的速度、航向角和发射功率进行联合优化，使无人机集群在动态移动过程中形成较优的地面覆盖与数据回传能力。也就是说，本文所研究的路由规划方法本质上是一种面向异构 UAV 控制序列的动态优化方法，其目标是在保证覆盖与回传能力优先的基础上，进一步优化系统吞吐量、队列负载和能量消耗。

      本文首先建立异构无人机集群通信网络动态路由规划模型。系统由多架异构 UAV、若干地面任务节点和固定 Sink 节点组成。UAV 在固定高度二维平面内运动，覆盖地面任务节点后产生数据到达量，并通过 UAV-UAV 链路和 UAV-Sink 链路完成数据转发与汇聚。模型同时考虑 UAV 运动约束、无线通信速率、覆盖关系、队列演化、功能性回传能力和能量消耗，并构造由归一化吞吐量、队列负载、能耗、覆盖违约和连通性违约组成的综合目标函数。

      在算法设计上，本文针对原始 L-SHADE 在动态覆盖路由问题中存在的两方面不足进行改进：一是随机初始化难以快速形成有效覆盖结构，导致搜索早期覆盖质量不足；二是参数自适应主要依赖历史成功经验，缺少对 UAV 覆盖状态的显式感知，容易在覆盖尚未稳定时过早转向性能优化。为此，本文提出覆盖状态感知 L-SHADE 算法，即 CSA-L-SHADE。该算法在 L-SHADE 连续优化框架基础上，引入覆盖优先初始化机制和覆盖状态感知参数控制机制，使搜索过程能够更好地结合地面任务节点分布和种群覆盖状态，从而提升算法对异构 UAV 动态覆盖路由问题的适配能力。

      本文在固定异构仿真环境下，对 L-SHADE、CFI-L-SHADE 和 CSA-L-SHADE 进行对比实验。实验结果表明，CSA-L-SHADE 在覆盖性能、通信吞吐、队列负载和综合目标值等指标上整体优于对比算法。与原始 L-SHADE 相比，CSA-L-SHADE 的平均覆盖率提高约 8.09%，归一化覆盖违约降低约 37.64%，吞吐量提高约 64.25%，队列负载降低约 19.64%。结果说明，覆盖优先初始化可改善初始种群覆盖不足，覆盖状态感知参数控制能够增强搜索后期的覆盖保持与性能精修能力，从而使算法在动态覆盖路由优化中获得更优的综合表现。
    ],
    keywords: ("异构无人机集群", "动态路由规划", "覆盖状态感知", "L-SHADE", "应急通信"),
  ),
  abstract-en: (
    content: [
      Heterogeneous UAV swarm communication networks are an important form of UAV collaborative communication. Compared with homogeneous UAV systems, in a heterogeneous UAV swarm, different UAVs vary in maximum speed, coverage radius, communication bandwidth, transmission power, cache capacity, and energy capacity, and can assume different roles such as regional coverage, aerial forwarding, and data aggregation according to mission requirements. A communication network composed of multiple heterogeneous UAVs can provide mission area coverage through UAV–ground node links, achieve aerial data forwarding through UAV–UAV links, and complete data aggregation through UAV–Sink links, making it suitable for scenarios such as ad hoc communication, regional monitoring, and post-disaster emergency communication.  

      Because UAV flight trajectories affect ground coverage and link transmission quality, and link rates affect cache queue release capacity, while high-speed flight and high-power transmission accelerate energy consumption, the routing planning problem in heterogeneous UAV swarm communication networks has characteristics of high dimensionality, nonlinearity, non-smoothness, and strong temporal coupling. In view of the limitations of metaheuristic algorithms in high-dimensional continuous optimization problems, research is conducted on dynamic routing planning methods for heterogeneous UAV swarm communication networks.  

      This paper focuses on scenarios in post-disaster emergency communication where communication infrastructure is damaged, ground mission data is continuously generated, and the network needs rapid reorganization. In this scenario, routing planning methods are not equivalent to fixed path selection or simple next-hop decisions in traditional networks; instead, they need to consider UAV motion control, coverage relationships, link rates, and queue states to jointly optimize UAV speed, heading angle, and transmission power, enabling the UAV swarm to achieve better ground coverage and data return capability during dynamic movement. In other words, the routing planning method studied in this paper is essentially a dynamic optimization method oriented toward heterogeneous UAV control sequences, with the goal of further optimizing system throughput, queue load, and energy consumption while prioritizing coverage and data return capabilities. 

      This paper first establishes a dynamic routing planning model for heterogeneous UAV swarm communication networks. The system consists of multiple heterogeneous UAVs, several ground mission nodes, and a fixed sink node. UAVs move in a two-dimensional plane at a fixed altitude, generating data arrival after covering ground mission nodes, and complete data forwarding and aggregation via UAV-UAV links and UAV-Sink links. The model simultaneously considers UAV motion constraints, wireless communication rates, coverage relationships, queue evolution, functional feedback capabilities, and energy consumption, and constructs a composite objective function composed of normalized throughput, queue load, energy consumption, coverage violation, and connectivity violation.  

      In terms of algorithm design, this paper addresses two shortcomings of the original L-SHADE algorithm in dynamic coverage routing problems: first, random initialization makes it difficult to quickly form an effective coverage structure, leading to insufficient coverage quality in the early stages of the search; second, parameter adaptation mainly relies on historical success experience, lacking explicit awareness of UAV coverage status, and is prone to prematurely shifting to performance optimization before coverage is stable. To address these shortcomings, this paper proposes a coverage status-aware L-SHADE algorithm, namely CSA-L-SHADE. Based on the continuous optimization framework of L-SHADE, this algorithm introduces a coverage-first initialization mechanism and a coverage status-aware parameter control mechanism, enabling the search process to better integrate the distribution of ground task nodes and the population coverage status, thereby improving the algorithm's adaptability to heterogeneous UAV dynamic coverage routing problems.

      This paper conducts comparative experiments on L-SHADE, CFI-L-SHADE, and CSA-L-SHADE in a fixed heterogeneous simulation environment. Experimental results show that CSA-L-SHADE outperforms the comparative algorithms overall in terms of coverage performance, communication throughput, queue load, and comprehensive target value. Compared to the original L-SHADE, CSA-L-SHADE improves average coverage by approximately 8.09%, reduces normalized coverage default by approximately 37.64%, increases throughput by approximately 64.25%, and reduces queue load by approximately 19.64%. These results demonstrate that coverage-first initialization improves the initial population's insufficient coverage, and coverage state-aware parameter control enhances coverage maintenance and performance refinement capabilities in the later stages of the search, thus enabling the algorithm to achieve superior overall performance in dynamic coverage routing optimization.
    ],
    keywords: ("Heterogeneous UAV Swarm", "Dynamic Route Planning", "Coverage State Awareness", "L-SHADE", "Emergency Communication"),
  ),
  appendix: [
    #align(center)[*附录 A 完整符号表*]

    #heading(level: 2, numbering: none)[A.1 集合、索引与规模参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$cal(U) = brace.l 1, 2, dots, N brace.r$], [UAV 节点集合], [-],
      [$cal(K) = brace.l 1, 2, dots, K brace.r$], [地面任务节点集合], [-],
      [$s$], [Sink 节点], [-],
      [$cal(V) = cal(U) union brace.l s brace.r$], [通信节点集合], [-],
      [$cal(T) = brace.l 0, 1, dots, T - 1 brace.r$], [离散时隙集合], [-],
      [$cal(G) = brace.l 0, 1, dots, G - 1 brace.r$], [控制段集合], [-],
      [$N$], [UAV 数量], [-],
      [$K$], [地面任务节点数量], [-],
      [$T$], [总时隙数], [-],
      [$L_c$], [单个控制段包含的时隙数], [-],
      [$G = ceil(T / L_c)$], [控制段总数], [-],
      [$D = 3 N G$], [单个候选解维度], [-],
      [$i, j$], [UAV 或通信节点索引], [-],
      [$k$], [地面任务节点索引], [-],
      [$t$], [时隙索引], [-],
      [$g$], [控制段索引], [-],
      [$cal(T)_g$], [第 $g$ 个控制段对应的时隙集合], [-],
    )

    其中，

    $
    cal(T)_g =
    brace.l
      g L_c,
      g L_c + 1,
      dots,
      min((g + 1) L_c - 1, T - 1)
    brace.r.
    $

    #heading(level: 2, numbering: none)[A.2 场景输入参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$L$], [正方形任务区域边长], [m],
      [$Delta t$], [单个时隙长度], [s],
      [$bold(q)_k = [x_k^"g", y_k^"g"]^top$], [地面任务节点 $k$ 的位置], [m],
      [$bold(p)_s = [x_s, y_s]^top$], [Sink 节点位置], [m],
      [$bold(p)_i(0)$], [UAV $i$ 的初始位置], [m],
    )

    #heading(level: 2, numbering: none)[A.3 优化变量]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$bold(u)_i(g)$], [UAV $i$ 在控制段 $g$ 的控制向量], [-],
      [$hat(v)_i(g)$], [UAV $i$ 在控制段 $g$ 的期望飞行速度], [m/s],
      [$hat(theta)_i(g)$], [UAV $i$ 在控制段 $g$ 的期望航向角], [rad],
      [$P_i^"tx"(g)$], [UAV $i$ 在控制段 $g$ 的发射功率], [W],
      [$bold(U)$], [完整优化变量集合], [-],
    )

    其中，

    $
    bold(u)_i(g)
    =
    [
      hat(v)_i(g),
      hat(theta)_i(g),
      P_i^"tx"(g)
    ],
    $

    $
    bold(U)
    =
    brace.l
      bold(u)_i(g)
      mid
      i in cal(U),
      g in cal(G)
    brace.r.
    $

    #heading(level: 2, numbering: none)[A.4 运动与安全参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$v_i^"max"$], [UAV $i$ 的最大飞行速度], [m/s],
      [$a^"max"$], [最大切向加速度], [m/s^2],
      [$Delta theta^"max"$], [单时隙最大航向变化角], [rad],
      [$omega^"max"$], [最大角速度], [rad/s],
      [$R^"min"$], [最小转弯半径], [m],
      [$d_"safe"$], [UAV 间最小安全距离], [m],
    )

    #heading(level: 2, numbering: none)[A.5 通信、覆盖与队列参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$B_i$], [UAV $i$ 的通信带宽], [Hz],
      [$P_i^"max"$], [UAV $i$ 的最大发射功率], [W],
      [$beta_0$], [参考距离增益系数], [m^2],
      [$delta$], [信道增益修正项], [m^2],
      [$sigma^2$], [噪声功率], [W],
      [$R_i^"cov"$], [UAV $i$ 的覆盖半径], [m],
      [$lambda_k$], [地面任务节点 $k$ 的数据产生率], [bit/s],
      [$Q_i^"max"$], [UAV $i$ 的最大缓存容量], [bit],
      [$epsilon_"con"$], [最小数据泄放比例系数], [-],
    )

    #heading(level: 2, numbering: none)[A.6 能量参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$E_i^"max"$], [UAV $i$ 的最大能量容量], [J],
      [$P_i^"hover"$], [UAV $i$ 的悬停功率], [W],
      [$c_(2, i)^"fly"$], [UAV $i$ 的速度平方项飞行功率系数], [W/(m/s)^2],
      [$c_(3, i)^"fly"$], [UAV $i$ 的速度立方项飞行功率系数], [W/(m/s)^3],
    )

    各 UAV 初始能量满足

    $
    E_i(0) = E_i^"max".
    $

    #heading(level: 2, numbering: none)[A.7 状态变量]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$bold(p)_i(t) = [x_i(t), y_i(t)]^top$], [UAV $i$ 在时隙 $t$ 的二维位置], [m],
      [$v_i(t)$], [UAV $i$ 在时隙 $t$ 的实际执行速度], [m/s],
      [$phi_i(t)$], [UAV $i$ 在时隙 $t$ 的实际执行航向角], [rad],
      [$Q_i(t)$], [UAV $i$ 在时隙 $t$ 的缓存队列长度], [bit],
      [$E_i(t)$], [UAV $i$ 在时隙 $t$ 的剩余能量], [J],
    )

    #heading(level: 2, numbering: none)[A.8 通信、覆盖与队列中间量]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$d_(i j)(t)$], [UAV $i$ 与 UAV $j$ 在时隙 $t$ 的距离], [m],
      [$d_(i s)(t)$], [UAV $i$ 与 Sink 在时隙 $t$ 的距离], [m],
      [$d_(i k)^"g"(t)$], [UAV $i$ 与地面任务节点 $k$ 在时隙 $t$ 的距离], [m],
      [$g_(i j)(t)$], [链路 $i -> j$ 的信道增益], [-],
      [$gamma_(i j)(t)$], [链路 $i -> j$ 的信噪比], [-],
      [$r_(i j)(t)$], [链路 $i -> j$ 的数据传输速率], [bit/s],
      [$c_(i k)(t)$], [UAV $i$ 对地面任务节点 $k$ 的覆盖指示量], [-],
      [$z_k(t)$], [地面任务节点 $k$ 在时隙 $t$ 的覆盖状态], [-],
      [$A_i(t)$], [时隙 $t$ 进入 UAV $i$ 队列的数据量], [bit],
      [$F_i^"in"(t)$], [UAV $i$ 在时隙 $t$ 的等效转发流入量], [bit],
      [$F_i^"out"(t)$], [UAV $i$ 在时隙 $t$ 的等效转发流出量], [bit],
    )

    其中，

    $
    c_(i k)(t) in brace.l 0, 1 brace.r,
    quad
    z_k(t) in brace.l 0, 1 brace.r.
    $

    #heading(level: 2, numbering: none)[A.9 评价指标与目标函数符号]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$rho_"cov"$], [任务周期平均覆盖率], [-],
      [$R_"norm"$], [归一化系统吞吐量], [-],
      [$Q_"norm"$], [归一化队列负载], [-],
      [$E_"norm"$], [归一化能耗指标], [-],
      [$V_"cov"^"norm"$], [归一化覆盖违约指标], [-],
      [$V_"con"^"norm"$], [归一化连通性违约指标], [-],
      [$J_"perf"$], [通信性能评价项], [-],
      [$J_"total"$], [综合目标函数值], [-],
    )

    #heading(level: 2, numbering: none)[A.10 目标函数权重]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$lambda_0$], [吞吐量指标权重], [-],
      [$lambda_1$], [队列指标权重], [-],
      [$lambda_2$], [能耗指标权重], [-],
      [$lambda_3$], [覆盖违约指标权重], [-],
      [$lambda_4$], [连通性违约指标权重], [-],
    )

    #pagebreak()
    #align(center)[*附录 B 实验补充参数设置*]

    #heading(level: 2, numbering: none)[B.1 通信模型参数]

    本文通信模型采用基于二维距离平方衰减的简化视距信道模型，其主要参数设置如表 B-1 所示。

    #three-line-table(
      columns: (1fr, auto),
      table.header([参数], [数值]),
      [信道增益参数 $beta_0$], [$1 times 10^(-3)$],
      [噪声功率], [$1 times 10^(-9)$],
      [连通违约系数 $epsilon$], [0.1],
      [任务节点单时隙数据量], [$5 times 10^4$ bit],
    )

    #heading(level: 2, numbering: none)[B.2 UAV 动力学约束参数]

    无人机运动过程中采用固定高度二维运动模型，并考虑速度、加速度、转角及安全距离等动力学约束，其相关参数如表 B-2 所示。

    #three-line-table(
      columns: (1fr, auto),
      table.header([参数], [数值]),
      [安全距离 $D_"safe"$], [20 m],
      [最大加速度], [5 m/s^2],
      [最大转角], [30°],
      [最大角速度], [30°/s],
      [最小转弯半径], [30 m],
    )

    #heading(level: 2, numbering: none)[B.3 CSA-L-SHADE 状态控制参数]

    CSA-L-SHADE 采用覆盖状态感知参数控制机制，根据种群覆盖状态动态调整差分进化参数 $p / F / "CR"$。其状态机相关参数设置如表 B-3 所示。

    #three-line-table(
      columns: (1fr, auto),
      table.header([参数], [数值]),
      [`elite_ratio`], [0.20],
      [$tau_H$], [0.15],
      [$tau_L$], [0.10],
      [$tau_"safe"$], [0.10],
      [$tau_"recover"$], [0.11],
      [$r_L$], [0.20],
      [$r_H$], [0.50],
      [$r_"recover"$], [0.40],
      [$delta_"stable"$], [0.002],
      [`hold_required`], [3],
    )

    CSA-L-SHADE 在不同覆盖状态下采用不同的 $p / F / "CR"$ 取值范围，其参数配置如表 B-4 所示。

    #three-line-table(
      columns: (auto, auto, auto, auto),
      table.header([状态], [$p$], [$F$ 范围], [$"CR"$ 范围]),
      [$S_1$], [0.08], [$[0.50, 0.80]$], [$[0.15, 0.40]$],
      [$S_2$], [0.10], [$[0.35, 0.60]$], [$[0.10, 0.30]$],
      [$S_3$], [0.15], [$[0.20, 0.50]$], [$[0.10, 0.35]$],
      [$S_4$], [0.08], [$[0.35, 0.60]$], [$[0.10, 0.25]$],
    )

    其中，$S_1$、$S_2$、$S_3$ 与 $S_4$ 分别表示覆盖探索状态、覆盖改进状态、覆盖稳定状态与覆盖恢复状态。
  ],
  acknowledgement: [
    致谢内容……
  ],
  design-summary: [
    本文围绕异构无人机集群通信网络动态路由规划问题展开研究，建立了包含 UAV 运动控制、无线通信、地面任务节点覆盖、数据队列、功能性回传能力和能量消耗的动态优化模型，并在 L-SHADE 基础上提出 CSA-L-SHADE 算法。该算法通过覆盖优先初始化改善随机初始化带来的低覆盖冷启动问题，并利用覆盖状态感知参数控制机制，根据种群覆盖状态动态调节搜索行为。仿真实验结果表明，CSA-L-SHADE 相较原始 L-SHADE 和 CFI-L-SHADE 在综合目标值、覆盖率、覆盖违约、吞吐量、队列负载和能耗等指标上均取得较好表现，验证了覆盖状态感知机制对异构无人机动态覆盖路由优化问题的有效性。

  ],
)

= 绪论

== 研究背景与意义
无人机（Unmanned Aerial Vehicle, UAV）具有空中巡航的能力，尤其在灾情发生后，可以快速进入受灾地区，对地面情况进行全方位、全覆盖的监测，从而为救援工作提供重要的实时数据。UAV还可以搭载各类传感器和摄像设备，获取高清晰度、多角度的图像和视频信息，为灾情的详细勘察提供可靠的技术支持。除此之外，UAV还可以根据预设的路径和航线，进行自主飞行和巡航，无需人工操控，降低人力成本，提高灾情监测的效率。因此，UAV 常用于灾后应急通信@HBGL202514005。然而，当地震、洪涝或山火破坏地面通信设施时，UAV应用场景的难点不止覆盖可行性。灾后初期，任务节点数据常呈突发到达状态。数据流又具有持续性。若 UAV 网络覆盖不及时，回传链路也未成形，缓存队列会迅速积压。随后，系统会出现时延升高、缓存紧张和数据丢失。因此，UAV 通信网络路由规划需同时考虑覆盖建立、队列演化和持续向 Sink 回传。

UAV通信网络的应用场景不仅是航迹规划或静态部署问题，而应视为轨迹控制、任务覆盖、链路传输、队列演化和能量消耗交织在一起的动态优化问题@2024Evolutionary。UAV 的速度、航向角和位置变化决定其与地面任务节点、其他 UAV 及 Sink 节点之间的空间距离，并影响覆盖关系、信道增益和链路传输速率；覆盖状态决定地面数据能否进入 UAV 队列，队列能否及时泄放又依赖于 UAV–UAV 链路和 UAV–Sink 链路的回传能力。高速飞行和高功率发射还会加快能量消耗，剩余能量反过来限制后续运动和通信。轨迹、覆盖、队列、回传和能耗之间并不是简单叠加关系，单独优化其中一个环节，可能会把压力转移到另一个环节@2024Evolutionary。在多 UAV 协同场景下，异构性会让问题更难处理。不同 UAV 在最大速度、覆盖半径和初始能量等方面存在差异，路由规划需要在有限资源条件下协调运动控制、覆盖服务、数据回传和能量消耗，统一控制策略或割裂式优化方法很难满足这一要求@9417264。

因此，该问题的优化求解难点主要来自高维变量、非线性关系、非光滑变化和强时序耦合。在时序演化过程中，当前控制量不会只影响当前收益，还会改变 UAV 位置、缓存队列和剩余能量，并继续作用于后续状态。覆盖关系具有阈值特征，距离变化可能引发离散切换；通信速率则同时受信道衰减和发射功率约束。传统精确优化方法难以直接适配该问题，其建模过程较繁，求解成本较高，面对更大规模网络时扩展能力不足@2025UAV。故本文不追求直接精确求解，而采用启发式或元启发式算法获得近似解@Das2026@AGRAWAL20241。

元启发式算法的优势在于对目标函数解析形式要求较低，能够通过仿真评价直接处理复杂约束、黑箱目标和高维连续变量。对于本文问题而言，候选解可以表示为 UAV 在多个控制段内的速度、航向角和发射功率序列，目标函数则由完整动态仿真得到。此类问题难以构造显式梯度或凸优化形式，但适合通过种群搜索在复杂解空间中逐步筛选较优控制方案。同时，元启发式算法具有较好的模型兼容性，可在不改变主体求解框架的情况下纳入覆盖违约、队列负载、能耗和回传能力等多类评价指标，因而适合作为 UAV 动态路由规划问题的近似求解方法。

在多类元启发式算法中，差分进化及其改进算法更适合处理连续变量、高维和复杂约束优化问题。其基于种群差分向量生成搜索方向，不依赖目标函数梯度，能够较自然地适配 UAV 控制序列这类实数编码问题。相比更偏离散路径编码的算法，差分进化便于同时优化速度、航向角和发射功率等连续控制量；相比单粒子式或局部搜索方法，其种群机制也有助于维持多样性，降低陷入局部覆盖模式的风险。因此，差分进化算法适合作为本文动态覆盖路由优化的基础搜索框架。

L-SHADE@LI2022350 在 SHADE@6900380 成功历史参数记忆机制基础上加入线性种群规模缩减策略，可在搜索前期保留探索能力，在后期提高收敛效率，因而适合作为 UAV 控制序列优化的基础框架。不过，原始 L-SHADE 仍是通用连续优化算法，参数自适应主要依赖历史成功经验，并不直接利用 UAV 通信网络中的覆盖状态。在动态覆盖路由问题中，覆盖状态既是目标函数中的惩罚项，也影响地面数据到达、队列演化和后续通信性能。本文据此在 L-SHADE 中加入 UAV 覆盖结构信息，设计面向覆盖状态的改进机制，使算法不仅具备高维连续搜索能力，也能更好地适应覆盖构造、覆盖稳定和性能精修等不同搜索阶段。相关结果可服务灾后应急通信、临时网络部署和无人机协同中继分析。

== 国内外研究现状
=== UAV 通信网络与动态路由规划研究
UAV 通信网络以无人机作为空中节点。其临时通信能力主要来自三类链路，包括 UAV–地面节点链路、UAV–UAV 链路和 UAV–Sink 链路@HNLG202512002。在早期阶段，相关工作更关注单架 UAV。典型问题包括位置部署、轨迹规划和空地信道建模@1025020518.nh。其优化目标集中在覆盖范围、通信速率和飞行能耗上。应急通信对多 UAV 协同提出更高要求。研究重点也随之变化，由单机轨迹优化转向协同路径规划、覆盖控制和数据回传等问题。资源分配也成为相关研究的重要内容

覆盖范围扩大后，回传压力也会增加。UAV 需要先覆盖任务节点。随后，采集数据还要经过 UAV–UAV 或 UAV–Sink 链路传回 Sink。两部分缺一不可。单纯追求覆盖率会推动 UAV 分散部署。分散部署容易拉长回传链路，并降低链路质量。相反，UAV 过度聚集会强化回传。代价是边缘区域覆盖不足@10535707。覆盖和回传必须联合建模。它是 UAV 应急通信规划中的关键问题@2024Evolutionary。

在 UAV 网络结构建模中，已有研究常引入图论连通、通信半径和 k-连通约束@1024503963.nh。部分工作还使用流约束或链路可靠性描述节点间连接关系@1022589382.nh。上述方法能描述拓扑可达性。可是在动态任务中，数据能否稳定回传，还取决于链路与队列状态。实际通信效果还受链路速率约束。UAV 队列状态与 Sink 汇聚能力也不可忽略。因此，动态 UAV 路由规划需要超出拓扑连通判断。数据在 UAV 队列中如何积压、如何传出，也应纳入模型。

现有 UAV 路径与路由研究已经从几何路径优化扩展到轨迹、链路、功率、队列和能耗共同作用的综合优化问题。不过，部分协议层路由研究更关注下一跳选择，对 UAV 连续运动控制、覆盖状态和队列演化之间的耦合刻画不足@10041916；部分轨迹优化研究虽然考虑通信速率或能耗，但较少讨论覆盖状态如何影响数据到达和系统稳定性@ELNABTY2022101564。本文由此从动态覆盖路由角度组织问题模型，将 UAV 控制、覆盖状态、通信速率和队列演化统一考虑。

=== 元启发式算法
在 UAV 路径规划、覆盖优化和通信资源分配中，问题约束往往较复杂。元启发式算法不依赖严格函数形式，工程实现也较灵活，因而具有较高适用性。不同元启发式算法并不适配同一类任务。遗传算法（Genetic Algorithm，GA）模拟生物进化，把待求解问题的初始解映射为“染色体”，使其经过选择、交叉、变异的过程从而进化为最优解，包括初始化种群、个体评价、选择运算、交叉运算、变异运算以及终止条件判断六个过程。对于路径顺序、节点访问和任务分配这类离散问题，GA更常被采用。其不足在于参数敏感，且收敛速度可能限制解质量@湛文静2023基于改进遗传算法的路径规划问题相关研究综述。粒子群算法(Particle Swarm Optimization,PSO)模拟鸟类觅食行为,在高维空间函数寻优方面具有解质量高、鲁棒性好、收敛速度快的优点,因而在神经网络训练、函数优化、模糊系统控制、模式分类领域得到广泛应用。同时,PSO算法具有程序简单、设置参数少、收敛速度快、实现容易等特点,目前已被广泛应用于静态问题优化中。然而,直接利用PSO算法跟踪动态系统,其效果不佳@刘秀梅2016动态系统中粒子群优化算法综述。差分进化算法 (differential evolution, DE) 作为一种新型、高效的启发式并行搜索技术, 具有收敛快、控制参数少且设置简单、优化结果稳健等优点@ZNXT201704001,与 GA 和 PSO 相比，DE 更适合连续变量搜索。多约束、黑箱目标和实数编码场景，也更符合其算法特点。基于这一优势，DE 及其改进算法常用于 UAV 轨迹规划、功率控制和资源联合分配。

针对DE算法的理论研究主要集中在如何提高算法的寻优能力、收敛速度以及克服启发式算法常见的早熟收敛以及搜索停滞等缺陷方面。近年来, 研究人员从多个角度不断改进算法以适应更为复杂的优化问题和满足更高的求解质量, 改进算法大致分为控制参数设置、差分策略选择、种群结构以及与其他最优化算法混合等四大类。作为差分进化算法的重要改进，L-SHADE 主要引入两类机制：成功历史参数自适应与线性种群规模缩减@LI2022350。在参数控制上，L-SHADE 会利用成功试验个体中的 F 和 CR 更新历史记忆。新的参数由历史记忆引导生成，不再主要依赖人工设定。种群规模则随迭代推进而收缩。前期较大的种群有利于全局搜索，后期缩减规模可以减少计算开销，并推动算法收敛。因此，L-SHADE 在连续变量搜索和高维黑箱优化中通常具有较好的稳定性。

=== 现有研究不足
从现有研究看，UAV 通信网络动态路由规划仍有部分问题尚未充分解决。围绕 UAV 轨迹、发射功率、吞吐量和能耗，已有研究展开较多联合优化工作。还有部分研究进一步考虑动态任务到达和队列稳定性，并将其纳入 UAV 轨迹或资源优化模型@7888557。这类研究的重点仍集中在通信资源分配、MEC 卸载和吞吐最大化上。相比之下，覆盖状态、数据到达、队列演化和 Sink 回传能力之间的反馈关系，尚未得到充分刻画。

现有 FANET 路由研究多聚焦协议层。常见方法包括拓扑路由、位置路由、分簇路由、DTN 路由和策略型路由。其核心任务是解决动态拓扑下如何转发数据包、选择下一跳并维护链路@10041916。协议层路由优化可以借助这类方法完成。但在本文关注的动态规划任务中，还需要进一步描述 UAV 连续控制、链路速率变化和队列泄放。

L-SHADE 主要沿用 SHADE 提出的成功历史参数记忆机制@6900380，还引入线性种群规模缩减，用于平衡搜索开销和收敛效率@LI2022350。在 UAV 资源配置等高维连续优化任务中，L-SHADE 及其变体已有应用。但原始机制主要依赖适应度改进记录，并未显式利用 UAV 覆盖状态。因此，算法无法根据覆盖变化及时调节搜索方向。

== 本文主要研究内容
围绕异构无人机集群通信网络动态路由规划问题，本文工作主要落在模型、算法和实验三个层面。

在模型层面，本文考虑由多架异构 UAV、若干地面任务节点和固定 Sink 节点构成的通信网络，建立 UAV 运动模型、无线通信模型、地面节点覆盖模型、数据队列与功能性连通表征模型以及能量消耗模型。在此基础上，将系统吞吐量、队列负载、能量消耗、覆盖违约和连通违约纳入同一目标函数，形成面向 UAV 控制序列的动态优化问题。

本文在种群生成阶段引入覆盖优先初始化机制。原始 L-SHADE 初始种群主要随机生成。任务节点分布未参与初始化过程，早期搜索容易落入低覆盖区域。本文据此生成部分覆盖导向初始个体。初始控制序列可更快接近任务节点区域，并保持基本覆盖。这样可以压缩低覆盖无效搜索空间。

在搜索过程中，本文构造覆盖状态指标，并据此调节 L-SHADE 的搜索参数。算法不再把所有搜索阶段视为同一种状态，而是区分覆盖构造、覆盖稳定、性能精修和覆盖恢复等情形，分别采用不同的搜索尺度。

在实验层面，本文在固定环境下对 L-SHADE、CFI-L-SHADE 和 CSA-L-SHADE 进行多次独立运行，从综合目标值、覆盖率、覆盖违约、连通违约、吞吐量、队列负载和能耗等指标比较算法表现，并结合收敛曲线和结果分布分析改进机制的作用。
== 本文组织结构
全文共设置六章，具体结构如下。

第 1 章为绪论，说明研究背景与意义，梳理国内外研究现状，并介绍本文工作与全文结构。

第 2 章转入相关理论与技术基础，该章支撑后续建模与算法设计。内容包括无人机通信网络组成、覆盖与连通表征、动态路由规划问题界定，以及差分进化与 L-SHADE 的基本原理。

第 3 章为异构无人机集群通信网络动态路由规划模型，构建 UAV 运动、无线通信、覆盖、队列、连通性表征、能耗和综合目标函数模型，并对问题进行形式化描述。

第 4 章为基于覆盖状态感知的 CSA-L-SHADE 路由优化算法，分析原始 L-SHADE 在本文问题中的不足，提出覆盖优先初始化和覆盖状态感知参数控制机制，并给出完整算法流程与复杂度分析。

第 5 章为仿真实验与结果分析，基于固定环境实验对 L-SHADE、CFI-L-SHADE 和 CSA-L-SHADE 进行对比，分析不同算法在综合目标、覆盖率、覆盖违约、吞吐量、队列负载和能耗等指标上的表现。

第 6 章为总结与展望，概括主要工作，并分析当前模型和算法的不足，给出后续改进方向。
= 相关理论与技术基础

本章围绕后续模型构建和算法设计所需的基础概念展开。首先说明无人机通信网络的节点组成、链路关系与异构特征，随后介绍覆盖、连通和功能性回传能力的表征方式，并进一步界定本文所研究的动态路由规划问题。最后，本章梳理差分进化算法及 L-SHADE 的基本机制，为问题建模和算法改进奠定理论基础。

== 无人机通信网络基本组成
本文研究的无人机通信网络由 UAV 节点、地面任务节点和 Sink 节点构成。UAV 节点在任务区域内移动，覆盖地面任务节点并进行数据转发；地面任务节点持续产生待回传数据；Sink 节点作为地面汇聚节点，负责接收 UAV 回传的数据。围绕该系统，存在 UAV–任务节点链路、UAV–UAV 链路和 UAV–Sink 链路。

任务节点接入依赖 UAV–任务节点链路。该链路决定覆盖关系，也决定数据入队。多 UAV 间的数据转发依靠 UAV–UAV 链路。UAV–Sink 链路则面向 Sink 回传。UAV 会持续移动。空间位置一旦变化，链路距离也会改变。随后，信道增益和传输速率产生波动。系统吞吐量也受影响。优化 UAV 通信网络时，节点运动必须纳入模型。链路质量和数据传输过程也应同时考虑。

在本文模型中，UAV 异构性不能被简化掉。UAV 个体之间存在能力差异。差异主要体现在最大速度、覆盖半径、通信带宽、发射功率、缓存容量和初始能量上。这些参数会影响 UAV 的任务分工，使其在覆盖、巡航、中继和回传中承担不同角色。本文后续建模将纳入上述异构参数。优化控制序列时，模型会协调不同 UAV 的运动、覆盖和通信行为。

== 覆盖与连通表征
覆盖表征用于描述地面任务节点是否可以被 UAV 服务。常见覆盖判定方式有两种，基于几何距离的覆盖半径模型，以及基于信道质量的覆盖判定模型。本文用距离阈值判断覆盖， UAV 与地面任务节点之间的距离不超过该 UAV 的覆盖半径时，认为该任务节点被该 UAV 覆盖。确定覆盖关系后，进一步计算任务周期内的平均覆盖率，并统计覆盖违约程度。

在传统图论框架中，连通性强调节点之间是否可达。对应到 UAV 网络中，就是判断拓扑是否连通。本文关注动态通信任务。此时，节点可达只能说明路径存在，不能保证数据稳定传回 Sink。拓扑路径存在，并不代表回传能力充足。若 UAV–Sink 链路速率较低，或 UAV 队列长期积压，系统仍可能无法完成稳定回传。本文的重点转向数据回传效果，即数据能否持续、稳定地汇聚到 Sink。

所谓功能性回传能力，关注的不是路径是否存在。它判断 UAV 队列数据能否持续、及时地汇聚到 Sink 节点。回传效果不仅由链路是否存在决定。UAV–UAV 链路、UAV–Sink 链路、传输速率和队列负载都会产生影响。在后续建模中，Sink 汇聚速率用于表示数据回传能力。系统队列负载和回传能力违约则用于反映积压风险。纯图论连通只说明节点可达。本文表征方式进一步关注数据能否真正传出，更符合动态 UAV 通信任务需求。
== 动态路由规划问题界定
传统通信网络中的路由更偏向协议层转发。它关注数据包应沿哪条路径传输，以及下一跳节点如何确定。UAV 通信网络不同于固定网络。节点位置会持续变化。轨迹变化会进一步影响链路质量、覆盖关系和回传能力。UAV 动态路由规划需要跨越协议层转发。它还要协调速度控制、航向调整、功率分配和任务调度。

本文所称“动态路由规划”并非传统协议层的显式下一跳选择或路由表优化，而是规划层面的 UAV 控制序列优化。具体而言，本文通过优化 UAV 在不同控制段内的速度、航向角和发射功率，改变 UAV 的空间分布、覆盖关系和链路速率，使系统在整个任务周期内形成较好的覆盖服务能力和面向 Sink 的数据回传能力。

这一问题可以理解为“轨迹控制—覆盖服务—链路回传—队列稳定”的联合优化过程。UAV 的运动控制决定覆盖关系和链路距离，覆盖关系决定地面任务数据是否进入 UAV 队列，链路速率决定队列能否及时泄放，队列状态又影响系统的整体性能评价。换言之，动态路由规划的重点不是寻找一条固定路径，而是通过连续控制变量协调 UAV 网络在时域上的服务与回传能力。

据此确定优化变量，为 UAV 分段控制序列。一个候选解对应一组完整控制方案。该方案包括各 UAV 在不同控制段的速度、航向角和发射功率。将控制序列输入动态仿真后，模型会返回覆盖率、吞吐量、队列负载、能耗和违约指标。上述变量设计将动态路由规划表达为高维连续优化问题。L-SHADE 及其改进算法也因此具备适用前提。
== 差分进化算法与 L-SHADE
DE是基于实数编码的进化算法，从一组随机生成的初始种群出发，不断通过变异、交叉与选择三个基本操作使种群进化，从而得到最优解，常用于连续变量优化问题@ZNXT201704001。DE 的搜索过程从差分变异开始。算法利用种群个体间的差分向量生成变异个体。随后，交叉和选择操作继续更新种群。DE 不需要目标函数梯度。因此，它适合非线性、不可导和黑箱优化问题。

缩放因子 F、交叉概率 CR 和种群规模，都会影响标准 DE 的搜索表现。F 决定差分变异强度。较高的 F 会增强全局探索，也可能带来震荡。较低的 F 更适合局部细化，但容易限制搜索范围。CR 则影响交叉更新范围。较高 CR 会推动更多维度变化，较低 CR 会保留更多原个体信息。围绕参数自动调整展开改进，成为 DE 研究中的常见思路。

SHADE（Success-History based Adaptive Differential Evolution）@6900380 在 DE 中加入基于成功历史经验的自适应机制。其本质是存储成功历史信息的集合，迭代过程中变异、交叉后的参数优于上一代时被认为是成功的，存入集合中，并通过高斯分布和柯西分布生成新参数，从而使参数能根据历史搜索经验动态调整。L-SHADE（Linear Population Size Reduction Success-History based Adaptive DE）@LI2022350 进一步引入线性种群规模缩减（LPSR），使得种群规模按照线性函数逐步减少，从而在保证探索能力的同时加快收敛。在算法迭代过程中， 变异采用DE/current-to-pbest/1策略，不仅利用最优个体信息，还结合其他较好个体的差值指导搜索方向，提高开发能力和多样性。外部存档用于存储被淘汰的个体，辅助生成变异向量，增强算法的全局搜索能力。所有这些机制作用下，L-SHADE搜索前期保留较大种群，算法多样性因此更充分。随着迭代推进，种群规模逐步收缩，算法收敛速度和全局搜索能力也随之提高。因此，L-SHADE 在高维连续优化问题中具有较好适用性。

本文采用 L-SHADE 作为基础优化框架，原因在于 UAV 动态路由规划可被编码为高维连续控制向量，且目标函数需要通过完整仿真计算，难以获得解析梯度。但原始 L-SHADE 的初始化、变异和参数控制均是通用机制，并不直接感知 UAV 覆盖状态。若要用于动态覆盖路由问题，还需要引入问题结构信息，使算法能根据覆盖状态调整搜索行为。

= 异构无人机集群通信网络动态路由规划模型

本章建立异构无人机集群通信网络动态路由规划问题的数学模型。围绕固定高度二维应急通信场景，先给出系统组成、基本假设和核心符号，再分别构建无人机运动、无线通信、地面节点覆盖、数据队列与连通性表征、能量消耗等子模型。进一步形成综合目标函数与约束描述，将无人机速度、航向角和发射功率的联合控制转化为可由后续算法求解的高维连续优化问题。

== 系统场景与基本假设
本文设定 UAV 飞行高度固定，并研究二维动态应急通信场景。任务区域设为边长 $L$ 的正方形，记为$Omega = [0, L] times [0, L]$。默认取 $L = 1000 "m"$。区域内包含三类节点。分别为 $K$ 个位置固定的地面任务节点、$N$  架异构 UAV，以及一个固定 Sink 节点 $s$。地面任务节点持续产生待传输数据。本文不区分业务优先级。Sink 默认位于任务区域中心，只接收汇聚数据。

系统由 UAV 节点、地面任务节点和 Sink 节点构成。UAV 覆盖地面节点、采集任务数据，并通过 UAV-UAV 链路和 UAV-Sink 链路完成多跳数据汇聚。不同 UAV 在最大飞行速度、覆盖半径、通信带宽、最大发射功率、缓存容量和能量容量等参数上存在差异，分别对应飞行能力、覆盖能力、通信能力、存储能力和续航能力的异构性。

系统运行时间离散为 $T$ 个时隙，记为 $t = 0, 1, dots, T - 1$，每个时隙长度为 $Delta t$。UAV 在任务过程中保持固定高度，仅在二维平面内运动。每架 UAV 的控制量包括飞行速度、期望航向角和发射功率；若采用分段常量控制，则同一控制段内控制量保持不变。UAV 运动需满足最大速度、最大加速度、最大转角、最大角速度、最小转弯半径和最小安全距离等约束。

当某地面任务节点位于 UAV 有效覆盖范围内时，其产生的数据进入该 UAV 缓存队列；随后数据经 UAV 间链路逐跳转发，并最终通过 UAV-Sink 链路到达 Sink。本文所称动态路由规划，是指在 UAV 位置、链路状态和队列状态持续变化的条件下，联合规划 UAV 运动控制与传输资源，形成面向 Sink 的多跳数据传输过程。

为了简化研究场景，本文作如下基本假设：任务区域为二维正方形区域，地面任务节点位置固定；各地面任务节点数据产生率相同，不考虑业务优先级差异；UAV 保持固定飞行高度，仅在二维平面内运动；UAV 与地面任务节点之间为视距通信，信道模型采用距离衰减形式；每架 UAV 具有有限缓存，未转发数据暂存于本地队列；Sink 为固定地面汇聚节点，仅接收数据，不参与转发；UAV 能耗由飞行能耗和通信发射能耗组成；UAV 之间保持不小于给定安全距离；任务区域用于生成地面节点、Sink 和 UAV 初始位置，UAV 可行行为由运动学、通信、能量和安全距离约束共同限定。

== 核心符号与变量定义

为避免正文符号表过长，本文仅在本节保留支撑后续模型构建、算法编码和复杂度分析的核心符号。完整参数、中间变量及派生量说明见附录 A。

=== 规模参数与索引

#three-line-table(
  columns: (auto, 1fr, auto),
  table.header([符号], [含义], [单位]),
  [$cal(U) = brace.l 1, 2, dots, N brace.r$], [UAV 节点集合], [-],
  [$cal(K) = brace.l 1, 2, dots, K brace.r$], [地面任务节点集合], [-],
  [$s$], [Sink 节点], [-],
  [$cal(V) = cal(U) union brace.l s brace.r$], [通信节点集合], [-],
  [$cal(T) = brace.l 0, 1, dots, T - 1 brace.r$], [离散时隙集合], [-],
  [$cal(G) = brace.l 0, 1, dots, G - 1 brace.r$], [控制段集合], [-],
  [$N$], [UAV 数量], [-],
  [$K$], [地面任务节点数量], [-],
  [$T$], [总时隙数], [-],
  [$L_c$], [单个控制段包含的时隙数], [-],
  [$G$], [控制段总数], [-],
  [$D$], [单个候选解维度], [-],
  [$i, j$], [UAV 或通信节点索引], [-],
  [$k$], [地面任务节点索引], [-],
  [$t$], [时隙索引], [-],
  [$g$], [控制段索引], [-],
)

控制段总数为

$
G = ceil(T / L_c).
$

每架 UAV 在每个控制段内包含期望速度、期望航向角和发射功率 3 个控制量，因此单个候选解维度为

$
D = 3 N G.
$

=== 场景输入与优化变量

#three-line-table(
  columns: (auto, 1fr, auto),
  table.header([符号], [含义], [单位]),
  [$L$], [正方形任务区域边长], [m],
  [$Delta t$], [单个时隙长度], [s],
  [$bold(q)_k = [x_k^"g", y_k^"g"]^top$], [地面任务节点 $k$ 的位置], [m],
  [$bold(p)_s = [x_s, y_s]^top$], [Sink 节点位置], [m],
  [$bold(p)_i(0)$], [UAV $i$ 的初始位置], [m],
)

本文以控制段为单位优化 UAV 控制量。对于任意 $i in cal(U)$ 和 $g in cal(G)$，定义

$
bold(u)_i(g) =
[
  hat(v)_i(g),
  hat(theta)_i(g),
  P_i^"tx"(g)
].
$

其中 $hat(v)_i(g)$ 为期望飞行速度，$hat(theta)_i(g)$ 为期望航向角，$P_i^"tx"(g)$ 为发射功率。整体优化变量为

$
bold(U) =
brace.l
  bold(u)_i(g)
  mid
  i in cal(U),
  g in cal(G)
brace.r.
$

控制变量满足

$
0 <= hat(v)_i(g) <= v_i^"max",
$

$
0 <= hat(theta)_i(g) < 2 pi,
$

$
0 <= P_i^"tx"(g) <= P_i^"max".
$

=== 关键模型参数

#three-line-table(
  columns: (auto, 1fr, auto),
  table.header([符号], [含义], [单位]),
  [$v_i^"max"$], [UAV $i$ 的最大飞行速度], [m/s],
  [$P_i^"max"$], [UAV $i$ 的最大发射功率], [W],
  [$R_i^"cov"$], [UAV $i$ 的覆盖半径], [m],
  [$B_i$], [UAV $i$ 的通信带宽], [Hz],
  [$Q_i^"max"$], [UAV $i$ 的最大缓存容量], [bit],
  [$E_i^"max"$], [UAV $i$ 的最大能量容量], [J],
  [$d_"safe"$], [UAV 间最小安全距离], [m],
  [$epsilon_"con"$], [最小数据泄放比例系数], [-],
  [$lambda_0, lambda_1, lambda_2, lambda_3, lambda_4$], [综合目标函数权重], [-],
)

其中，不同 UAV 可具有不同的 $v_i^"max"$、$P_i^"max"$、$R_i^"cov"$、$B_i$、$Q_i^"max"$ 和 $E_i^"max"$，用于描述 UAV 集群的异构性。

=== 主要状态量与评价输出

#three-line-table(
  columns: (auto, 1fr, auto),
  table.header([符号], [含义], [单位]),
  [$bold(p)_i(t)$], [UAV $i$ 在时隙 $t$ 的二维位置], [m],
  [$v_i(t)$], [UAV $i$ 在时隙 $t$ 的实际执行速度], [m/s],
  [$phi_i(t)$], [UAV $i$ 在时隙 $t$ 的实际执行航向角], [rad],
  [$Q_i(t)$], [UAV $i$ 在时隙 $t$ 的缓存队列长度], [bit],
  [$E_i(t)$], [UAV $i$ 在时隙 $t$ 的剩余能量], [J],

  [$J_"perf"$], [通信性能评价项], [-],
  [$J_"total"$], [综合目标函数值], [-],
)

上述评价输出量由完整任务周期仿真得到，用于个体排序、层级判优、覆盖状态估计和最优解输出。

== 无人机运动模型

在固定飞行高度条件下，UAV 运动被建模为二维平面内的离散时间更新过程。对于任意 UAV $i in cal(U)$，其在时隙 $t$ 的运动状态表示为

$
bold(s)_i(t)
=
[
  x_i(t),
  y_i(t),
  v_i(t),
  phi_i(t)
]^top.
$

其中，$bold(p)_i(t) = [x_i(t), y_i(t)]^top$ 为二维位置，$v_i(t)$ 为实际执行速度，$phi_i(t)$ 为实际执行航向角。初始速度和初始航向设为

$
v_i(0) = 0,
quad
phi_i(0) = 0.
$

系统以控制段为单位给出期望控制量。对于任意 $t in cal(T)_g$，UAV $i$ 接收控制段 $g$ 内的期望速度 $hat(v)_i(g)$ 和期望航向角 $hat(theta)_i(g)$。实际执行速度由期望速度、最大速度和最大切向加速度共同确定：

$
v_i(t)
=
op("clip")(
  hat(v)_i(g),
  max(0, v_i(t - 1) - a^"max" Delta t),
  min(v_i^"max", v_i(t - 1) + a^"max" Delta t)
).
$

并满足

$
0 <= v_i(t) <= v_i^"max".
$

其中，$op("clip")(x, l, u)$ 表示将 $x$ 截断至区间 $[l, u]$。

控制变量 $hat(theta)_i(g)$ 表示 UAV $i$ 在控制段 $g$ 内的期望绝对航向角。期望航向与上一时隙实际航向之间的最短角差定义为

$
delta_i(t)
=
op("wrap")_([-pi, pi])
(
  hat(theta)_i(g) - phi_i(t - 1)
).
$

单时隙最大允许航向变化量分两种情况定义。当 $v_i(t) > 0$ 时，

$
Delta phi_i^"max"(t)
=
min(
  Delta theta^"max",
  omega^"max" Delta t,
  (v_i(t) Delta t) / R^"min"
).
$

当 $v_i(t) = 0$ 时，

$
Delta phi_i^"max"(t)
=
min(
  Delta theta^"max",
  omega^"max" Delta t
).
$

实际执行转角为

$
delta_i^"exe"(t)
=
op("clip")(
  delta_i(t),
  -Delta phi_i^"max"(t),
  Delta phi_i^"max"(t)
).
$

实际执行航向角更新为

$
phi_i(t)
=
op("wrap")_([0, 2 pi))
(
  phi_i(t - 1) + delta_i^"exe"(t)
).
$

其中，$op("wrap")_([-pi, pi]) (dot)$ 和 $op("wrap")_([0, 2 pi)) (dot)$ 分别表示角度区间映射函数。

获得实际执行速度 $v_i(t)$ 和实际执行航向 $phi_i(t)$ 后，UAV 的候选位置按离散运动方程更新：

$
tilde(bold(p))_i(t + 1)
=
bold(p)_i(t)
+
v_i(t) Delta t
[
  cos phi_i(t),
  sin phi_i(t)
]^top.
$

等价地，

$
tilde(x)_i(t + 1)
=
x_i(t) + v_i(t) Delta t cos phi_i(t),
$

$
tilde(y)_i(t + 1)
=
y_i(t) + v_i(t) Delta t sin phi_i(t).
$

为避免 UAV 间距离过近，任意两架 UAV 应满足最小安全距离约束：

$
norm(bold(p)_i(t) - bold(p)_j(t))_2
>=
d_"safe",
quad
forall i, j in cal(U),
i != j.
$

在位置更新时，系统先计算候选位置 $tilde(bold(p))_i(t + 1)$。若存在 $j != i$，使得

$
norm(tilde(bold(p))_i(t + 1) - tilde(bold(p))_j(t + 1))_2
<
d_"safe",
$

则取消 UAV $i$ 当前时隙的位移更新，并将其实际执行速度置零：

$
bold(p)_i(t + 1) = bold(p)_i(t),
quad
v_i(t) = 0.
$

否则，接受候选位置：

$
bold(p)_i(t + 1) = tilde(bold(p))_i(t + 1).
$

UAV 的运动状态由期望控制量、速度约束、航向约束、位置更新和安全距离修正共同确定。该运动模型输出的 $bold(p)_i(t)$、$v_i(t)$ 和 $phi_i(t)$ 将作为后续通信距离、覆盖关系和飞行能耗计算的输入。

== 无线通信模型

本节讨论 UAV-UAV 转发链路和 UAV-Sink 汇聚链路，统一记接收节点为 $j in cal(V) = cal(U) union brace.l s brace.r$。假设链路满足视距通信，忽略同频干扰、多径衰落及 LoS/NLoS 随机切换。对于任意发射 UAV $i in cal(U)$ 和接收节点 $j in cal(V)$，$i != j$，当 $j in cal(U)$ 时，接收节点位置为 $bold(p)_j(t)$；当 $j = s$ 时，接收节点位置为 $bold(p)_s$。

则链路距离为

$
d_(i j)(t)
=
norm(bold(p)_i(t) - bold(p)_j(t))_2,
quad
i in cal(U),
j in cal(V),
i != j.
$

链路信道增益采用距离平方衰减模型：

$
g_(i j)(t)
=
beta_0 / (d_(i j)^2(t) + delta),
quad
i in cal(U),
j in cal(V),
i != j.
$

其中，$beta_0$ 为参考距离增益系数，$delta$ 为信道增益修正项。

链路 $i -> j$ 在时隙 $t$ 的信噪比为

$
gamma_(i j)(t)
=
(P_i^"tx"(t) g_(i j)(t)) / sigma^2,
$

其中，$P_i^"tx"(t)$ 为 UAV $i$ 的发射功率，$sigma^2$ 为噪声功率。相应的可达传输速率为

$
r_(i j)(t)
=
B_i log_2(1 + gamma_(i j)(t)),
quad
i in cal(U),
j in cal(V),
i != j.
$

等价地，

$
r_(i j)(t)
=
B_i log_2(
  1 + (P_i^"tx"(t) g_(i j)(t)) / sigma^2
).
$

其中，$B_i$ 为发送 UAV $i$ 的通信带宽。对于 UAV 自身到自身的无效链路，规定

$
r_(i i)(t) = 0,
quad
i in cal(U).
$

为统一表示各时隙内的链路传输能力，定义速率矩阵

$
bold(R)(t)
=
[r_(i j)(t)]_(i in cal(U), j in cal(V))
in
RR^(N times (N + 1)).
$

其中，$j in cal(U)$ 对应 UAV-UAV 转发速率，$j = s$ 对应 UAV-Sink 汇聚速率。后续队列模型基于 $bold(R)(t)$ 计算 UAV 间等效转发流量和 Sink 侧数据泄放能力。

== 地面节点覆盖模型

为刻画 UAV 对地面任务节点的数据采集条件，定义时隙 $t$ 内 UAV $i in cal(U)$ 与地面任务节点 $k in cal(K)$ 的二维距离为

$
d_(i k)^"g"(t)
=
norm(bold(p)_i(t) - bold(q)_k)_2.
$

考虑 UAV 覆盖半径 $R_i^"cov"$，二元覆盖指示量定义为

$
c_(i k)(t)
=
bb(I)(
  d_(i k)^"g"(t) <= R_i^"cov"
),
quad
i in cal(U),
k in cal(K),
t in cal(T),
$

其中，$bb(I)(dot)$ 为示性函数。任务节点 $k$ 在时隙 $t$ 的覆盖状态为

$
z_k(t)
=
min(
  1,
  sum_(i in cal(U)) c_(i k)(t)
).
$

据此，系统在时隙 $t$ 的覆盖率和整个任务周期内的平均覆盖率分别为

$
rho_"cov"(t)
=
1 / K
sum_(k in cal(K)) z_k(t),
$

$
rho_"cov"
=
1 / T
sum_(t in cal(T)) rho_"cov"(t)
=
1 / (T K)
sum_(t in cal(T))
sum_(k in cal(K))
z_k(t).
$

覆盖不足程度由覆盖违约量表示。时隙 $t$ 的覆盖违约量定义为

$
V_"cov"(t)
=
sum_(k in cal(K))
(1 - z_k(t)).
$

累计覆盖违约量为

$
V_"cov"^"sum"
=
sum_(t in cal(T))
V_"cov"(t).
$

归一化覆盖违约指标为

$
V_"cov"^"norm"
=
V_"cov"^"sum" / (T K).
$

在上述定义下，有

$
V_"cov"^"norm"
=
1 - rho_"cov".
$

本文不将任意时隙全覆盖作为硬约束，而以 $V_"cov"^"norm"$ 量化覆盖不足。该指标将进入综合目标函数，并用于第 4 章算法层级判优和覆盖状态感知参数控制。

== 数据队列与连通性表征模型

为刻画数据流转过程，本节基于链路速率建立 UAV 缓存队列模型。这里的系统连通性指 UAV 网络将缓存数据回传至 Sink 的功能性能力，而非静态拓扑全连通属性。

*数据到达量。* 地面任务节点 $k$ 在单个时隙内产生的数据量为

$
a_k = lambda_k Delta t.
$

若任务节点 $k$ 处于 UAV $i$ 的覆盖范围内，即 $c_(i k)(t) = 1$，则其数据进入 UAV $i$ 的缓存队列。UAV $i$ 在时隙 $t$ 的地面数据到达量为

$
A_i(t)
=
sum_(k in cal(K)) c_(i k)(t) a_k
=
sum_(k in cal(K)) c_(i k)(t) lambda_k Delta t.
$

本文采用并行采集假设，即同一任务节点被多架 UAV 覆盖时，其数据可分别进入对应 UAV 的缓存队列。

*等效转发流量。* 基于第 3.4 节得到的链路速率 $r_(i j)(t)$，定义 UAV $i$ 在时隙 $t$ 的等效转发流入速率和流出速率分别为

$
r_i^"in"(t)
=
sum_(j in cal(U), j != i)
r_(j i)(t),
$

$
r_i^"out"(t)
=
sum_(j in cal(U), j != i)
r_(i j)(t)
+
r_(i s)(t).
$

对应的数据流入量和流出量为

$
F_i^"in"(t) = r_i^"in"(t) Delta t,
quad
F_i^"out"(t) = r_i^"out"(t) Delta t.
$

*队列更新。* 设 $Q_i(t)$ 为 UAV $i$ 在时隙 $t$ 的缓存队列长度，初始队列为

$
Q_i(0) = 0.
$

则队列状态更新为

$
Q_i(t + 1)
=
op("clip")(
  Q_i(t)
  +
  A_i(t)
  +
  (r_i^"in"(t) - r_i^"out"(t)) Delta t,
  0,
  Q_i^"max"
),
$

其中 $Q_i^"max"$ 为 UAV $i$ 的最大缓存容量。系统总队列长度定义为

$
Q_"sys"(t)
=
sum_(i in cal(U))
Q_i(t).
$

*连通性表征。* Sink 侧的总汇聚速率为

$
R_s(t)
=
sum_(i in cal(U))
r_(i s)(t).
$

单时隙内的等效数据泄放量为

$
D_s(t)
=
R_s(t) Delta t.
$

设 $epsilon_"con"$ 为最小数据泄放比例系数，则时隙 $t$ 的功能性连通约束可表示为

$
D_s(t)
>=
epsilon_"con" Q_"sys"(t).
$

相应地，定义连通性违约量为

$
V_"con"(t)
=
max(
  0,
  epsilon_"con" Q_"sys"(t) - D_s(t)
).
$

整个任务周期内的累计连通性违约量为

$
V_"con"^"sum"
=
sum_(t in cal(T))
V_"con"(t).
$

记系统总缓存容量为

$
Q_"max"
=
sum_(i in cal(U))
Q_i^"max".
$

则归一化连通性违约指标为

$
V_"con"^"norm"
=
V_"con"^"sum" / (T epsilon_"con" Q_"max").
$

数据队列模型由覆盖驱动的数据到达、链路速率驱动的等效转发和 Sink 数据泄放能力构成。其中，$Q_i(t)$ 用于刻画 UAV 缓存状态，$Q_"sys"(t)$ 用于刻画系统负载，$V_"con"^"norm"$ 用于后续综合目标函数与算法层级判优。

== 无人机能量消耗模型

UAV 的能量消耗由飞行能耗和通信发射能耗构成。对于任意 UAV $i in cal(U)$，其在时隙 $t$ 的飞行功率定义为

$
P_i^"fly"(t)
=
P_i^"hover"
+
c_(2, i)^"fly" v_i^2(t)
+
c_(3, i)^"fly" v_i^3(t),
$

其中，$P_i^"hover"$ 为悬停功率，$c_(2, i)^"fly"$ 和 $c_(3, i)^"fly"$ 分别为速度平方项和速度立方项飞行功率系数。对应的飞行能耗为

$
E_i^"fly"(t)
=
P_i^"fly"(t) Delta t.
$

通信能耗仅考虑发射功率消耗，表示为

$
E_i^"tx"(t)
=
P_i^"tx"(t) Delta t.
$

因此，UAV $i$ 在时隙 $t$ 的总功率为

$
P_i^"total"(t)
=
P_i^"fly"(t)
+
P_i^"tx"(t),
$

即

$
P_i^"total"(t)
=
P_i^"hover"
+
c_(2, i)^"fly" v_i^2(t)
+
c_(3, i)^"fly" v_i^3(t)
+
P_i^"tx"(t).
$

设 $E_i(t)$ 为 UAV $i$ 在时隙 $t$ 开始时的剩余能量，则能量状态更新为

$
E_i(t + 1)
=
op("clip")(
  E_i(t) - P_i^"total"(t) Delta t,
  0,
  E_i^"max"
),
$

初始能量满足

$
E_i(0) = E_i^"max".
$

系统在时隙 $t$ 内的总能耗为

$
E_"sys"(t)
=
sum_(i in cal(U))
P_i^"total"(t) Delta t.
$

整个任务周期内的累计系统能耗为

$
E_"sum"
=
sum_(t in cal(T))
E_"sys"(t).
$

记系统总初始能量容量为

$
E_"max"
=
sum_(i in cal(U))
E_i^"max".
$

归一化能耗指标定义为

$
E_"norm"
=
E_"sum" / (T E_"max").
$

能量模型包括飞行功率、通信发射功率和剩余能量演化。其中，$E_"norm"$ 将作为综合目标函数中的能耗评价项。

== 综合性能指标与优化目标函数

前述各节已分别建立 UAV 运动模型、无线通信模型、地面节点覆盖模型、数据队列与连通性表征模型以及能量消耗模型。为了对不同 UAV 动态控制方案进行统一评价，本文从 Sink 汇聚能力、系统队列负载、能量消耗、覆盖违约和连通性违约五个方面构建综合性能指标。其中，Sink 汇聚能力越强表示通信性能越好，而队列积压、能量消耗、覆盖不足和回传能力不足越小表示方案越优。因此，本文将异构 UAV 动态路由规划问题表述为综合代价最小化问题。

本文沿用前文模型中得到的累计汇聚速率 $R_"sum"$、累计队列负载 $Q_"sum"$、累计系统能耗 $E_"sum"$、累计覆盖违约量 $V_"cov"^"sum"$ 和累计连通性违约量 $V_"con"^"sum"$，并将其归一化为如下评价指标：

$
R_"norm" = R_"sum" / (T R_"max"),
quad
Q_"norm" = Q_"sum" / (T Q_"max"),
quad
E_"norm" = E_"sum" / (T E_"max").
$

$
V_"cov"^"norm" = V_"cov"^"sum" / (T K),
quad
V_"con"^"norm" = V_"con"^"sum" / (T epsilon_"con" Q_"max").
$

其中，$R_"max"$ 为系统理论最大 Sink 汇聚速率，$Q_"max"$ 为系统总缓存容量，$E_"max"$ 为系统总初始能量容量。$R_"norm"$ 越大，表示 UAV-Sink 链路的平均汇聚能力越强；$Q_"norm"$ 和 $E_"norm"$ 越小，表示系统队列积压和能量消耗越低；$V_"cov"^"norm"$ 和 $V_"con"^"norm"$ 越小，表示系统覆盖能力和面向 Sink 的功能性回传能力越强。需要指出的是，$V_"con"^"norm"$ 表征的是数据回传能力不足，而非严格图论意义上的拓扑全连通约束。

基于上述归一化指标，首先定义通信性能项为

$
J_"perf"
=
-lambda_0 R_"norm"
+
lambda_1 Q_"norm"
+
lambda_2 E_"norm",
$

其中，$lambda_0$、$lambda_1$ 和 $lambda_2$ 分别为吞吐量、队列负载和能耗指标的权重系数。由于吞吐量越大越优，因此其前项取负号；队列负载和能量消耗越小越优，因此对应项取正号。

进一步将覆盖违约和连通性违约纳入综合目标函数，得到

$
J_"total"
=
J_"perf"
+
lambda_3 V_"cov"^"norm"
+
lambda_4 V_"con"^"norm".
$

即

$
J_"total"
=
-lambda_0 R_"norm"
+
lambda_1 Q_"norm"
+
lambda_2 E_"norm"
+
lambda_3 V_"cov"^"norm"
+
lambda_4 V_"con"^"norm".
$

其中，$lambda_3$ 和 $lambda_4$ 分别为覆盖违约和连通性违约的惩罚权重。本文以最小化 $J_"total"$ 为优化目标。该目标函数在鼓励提升 Sink 汇聚能力的同时，对队列积压、能量消耗、覆盖不足和回传能力不足进行惩罚，从而实现覆盖、回传、吞吐、队列和能耗之间的综合权衡。

本文实验中采用的默认权重为

$
lambda_0 = 0.40,
quad
lambda_1 = 0.20,
quad
lambda_2 = 0.15,
quad
lambda_3 = 0.15,
quad
lambda_4 = 0.10.
$

具体实验参数设置将在第 5 章中进一步说明。

仅依赖加权和目标函数可能导致算法在局部搜索过程中以牺牲覆盖或回传状态为代价改善通信性能。考虑到应急通信场景中地面覆盖与数据回传能力具有基础性地位，本文在综合目标函数之外进一步采用层级判优逻辑。

具体而言，在比较两个候选方案时，首先比较归一化覆盖违约指标 $V_"cov"^"norm"$。当两个方案的覆盖违约差异超过阈值 $eta_"cov"$ 时，覆盖违约更小者优先；若覆盖违约接近，则进一步比较归一化连通性违约指标 $V_"con"^"norm"$。当连通性违约差异超过阈值 $eta_"con"$ 时，连通性违约更小者优先；若二者仍接近，则比较通信性能项 $J_"perf"$，最后再比较综合目标值 $J_"total"$。

该判优逻辑可概括为

$
V_"cov"^"norm"
->
V_"con"^"norm"
->
J_"perf"
->
J_"total".
$

在本文实验设置中，覆盖违约比较阈值取

$
eta_"cov" = 0.01,
$

连通性违约比较阈值取

$
eta_"con" = 0.001.
$

通过上述层级判优方式，算法能够优先维持较好的覆盖状态和回传能力，再在此基础上进一步优化吞吐量、队列负载和能耗等通信性能指标。这一设计与本文“覆盖与回传优先，性能进一步优化”的建模思路保持一致。

== 动态路由规划问题描述

基于前述系统模型，本文将异构无人机集群通信网络动态路由规划问题表述为面向控制序列的动态优化问题。需要说明的是，本文所称动态路由规划并非协议层面的显式下一跳选择或数据包级路径优化，而是在 UAV 动态运动、链路速率变化和数据队列演化条件下，对 UAV 的运动控制与发射功率进行联合优化，使系统在任务周期内形成面向 Sink 的有效数据汇聚过程。

=== 优化变量与目标函数

本文以控制段为单位描述 UAV 控制序列。对于任意 UAV $i in cal(U)$ 和控制段 $g in cal(G)$，定义控制向量为

$
bold(u)_i(g)
=
[
  hat(v)_i(g),
  hat(theta)_i(g),
  P_i^"tx"(g)
]^top.
$

其中，$hat(v)_i(g)$ 为期望飞行速度，$hat(theta)_i(g)$ 为期望航向角，$P_i^"tx"(g)$ 为发射功率。由所有 UAV 在全部控制段上的控制向量组成整体优化变量：

$
bold(U)
=
brace.l
  bold(u)_i(g)
  mid
  i in cal(U),
  g in cal(G)
brace.r.
$

给定控制序列 $bold(U)$ 后，UAV 的位置、实际速度、实际航向、覆盖状态、链路速率、队列状态和剩余能量均可由第 3.3 至第 3.7 节的动态模型递推得到。基于这些状态量，可进一步计算第 3.8 节定义的 $R_"norm"$、$Q_"norm"$、$E_"norm"$、$V_"cov"^"norm"$ 和 $V_"con"^"norm"$，从而得到综合目标函数 $J_"total"(bold(U))$。本文的优化目标是在可行控制序列中寻找使综合代价最小的控制方案，即

$
min_(bold(U))
J_"total"(bold(U)).
$

该目标函数综合考虑 Sink 汇聚速率、队列负载、能量消耗、覆盖违约和连通性违约。由于目标为最小化，吞吐量项以负权重进入目标函数，队列、能耗、覆盖违约和连通性违约则作为代价项加入。

=== 约束条件汇总

接下来利用控制序列 $bold(U)$ 分析动态路由规划问题的主要约束。与静态路径规划不同，本文约束既包括控制变量自身的取值范围，也包括由动态仿真模型递推得到的运动、通信、覆盖、队列和能量状态。

（C1）控制变量边界约束。对于任意 $i in cal(U)$、$g in cal(G)$，控制变量需满足

$
0 <= hat(v)_i(g) <= v_i^"max",
quad
0 <= hat(theta)_i(g) < 2 pi,
quad
0 <= P_i^"tx"(g) <= P_i^"max".
$

其中，$v_i^"max"$ 和 $P_i^"max"$ 分别为 UAV $i$ 的最大飞行速度和最大发射功率。期望航向角 $hat(theta)_i(g)$ 被映射到 $[0, 2 pi)$ 范围内。由此定义控制变量的可行集合：

$
cal(F)
=
brace.l
  bold(U)
  mid
  0 <= hat(v)_i(g) <= v_i^"max",
  0 <= hat(theta)_i(g) < 2 pi,
  0 <= P_i^"tx"(g) <= P_i^"max",
  forall i in cal(U),
  g in cal(G)
brace.r.
$

（C2）运动与安全约束。控制序列进入仿真执行过程后，UAV 的实际速度、航向和位置由第 3.3 节的运动模型递推得到。实际运动过程需满足最大速度、最大加速度、最大转角、最大角速度和最小转弯半径等约束；当候选位置导致 UAV 间距离小于 $d_"safe"$ 时，系统通过位置修正机制保持安全距离。

（C3）通信、覆盖与队列约束。对于任意可行控制序列，链路速率由第 3.4 节的无线通信模型计算，地面节点覆盖状态由第 3.5 节的覆盖模型判定，队列状态由第 3.6 节的数据到达、UAV 间转发和 Sink 泄放过程共同递推。UAV 缓存队列需保持在其容量范围内，即 $0 <= Q_i(t) <= Q_i^"max"$。

（C4）能量约束。UAV 剩余能量由第 3.7 节的能量模型递推得到，飞行功率和通信发射功率共同决定能量消耗。任意时隙内剩余能量需保持在 $[0, E_i^"max"]$ 范围内。覆盖不足和回传能力不足不作为硬约束直接强制满足，而是通过 $V_"cov"^"norm"$ 和 $V_"con"^"norm"$ 进入目标函数及后续层级判优过程。

为简化问题表示，本文将由第 3.3 至第 3.7 节共同构成的状态递推过程记为

$
(
  bold(P),
  bold(R),
  bold(Z),
  bold(Q),
  bold(E)
)
=
Phi(bold(U)).
$

其中，$bold(P)$、$bold(R)$、$bold(Z)$、$bold(Q)$ 和 $bold(E)$ 分别表示任务周期内的 UAV 位置序列、链路速率序列、覆盖状态序列、队列状态序列和能量状态序列；$Phi(dot)$ 表示由运动、通信、覆盖、队列和能量模型共同构成的状态递推映射。

综上，本文的动态路由规划问题可表示为

$
cal(P):
quad
min_(bold(U))
J_"total"(bold(U))
$

$
"s.t."
quad
0 <= hat(v)_i(g) <= v_i^"max",
quad
0 <= hat(theta)_i(g) < 2 pi,
quad
0 <= P_i^"tx"(g) <= P_i^"max",
quad
forall i in cal(U),
g in cal(G),
$

$
0 <= Q_i(t) <= Q_i^"max",
quad
0 <= E_i(t) <= E_i^"max",
quad
forall i in cal(U),
t in cal(T),
$

$
(
  bold(P),
  bold(R),
  bold(Z),
  bold(Q),
  bold(E)
)
=
Phi(bold(U)).
$

其中，$cal(P)$ 表示本文构建的异构 UAV 集群动态路由规划优化问题。第一组约束对应控制变量边界约束（C1），第二组约束对应队列容量和剩余能量范围约束（C3）与（C4），第三组约束表示系统状态需满足由第 3.3 至第 3.7 节定义的运动、通信、覆盖、队列和能量动态递推关系。安全距离约束包含在运动模型及其位置修正机制中，覆盖不足和回传能力不足则通过目标函数中的违约项及后续层级判优过程处理。

=== 问题性质分析

由上述问题描述可知，本文构建的动态路由规划问题首先属于高维连续优化问题。每架 UAV 在每个控制段内需要优化期望速度、期望航向角和发射功率三个连续控制量，因此优化维度为

$
D = 3 N G.
$

若直接在每个时隙独立优化控制量，则原始维度为

$
D_"raw" = 3 N T.
$

由于通常有 $G < T$，采用控制段建模能够在一定程度上降低优化维度，但该问题仍具有较高的搜索复杂度。

其次，该问题具有显著的非线性特征。UAV 位置更新包含三角函数项，通信距离计算包含欧氏范数，信道增益与距离平方相关，链路速率由 Shannon 对数函数给出，飞行能耗还包含速度的二次项和三次项。因此，优化变量与目标函数之间存在复杂的非线性映射关系。

再次，该问题具有非凸和非光滑特征。覆盖指示量由距离阈值判定得到：

$
c_(i k)(t)
=
bb(I)(
  d_(i k)^"g"(t) <= R_i^"cov"
).
$

该判定会导致覆盖状态随 UAV 位置变化发生离散跳变。同时，队列更新和能量更新中存在截断运算，覆盖违约与连通性违约中存在 $max(dot)$ 运算，这些因素都会使目标函数呈现非光滑特性。

此外，该问题还具有强时序耦合。某一控制段中的速度、航向和发射功率不仅影响当前时隙的 UAV 位置、链路速率、覆盖关系和能耗，还会通过位置演化、队列积压和剩余能量变化影响后续时隙的系统状态。因此，该问题不同于静态优化问题，而是典型的动态时域优化问题。

最后，控制变量与多个优化指标之间存在强耦合关系。速度和航向共同决定 UAV 轨迹，从而影响覆盖状态、通信距离和飞行能耗；发射功率影响链路速率、Sink 汇聚能力和通信能耗；覆盖状态影响地面数据到达；链路速率和队列状态进一步影响连通性违约和系统稳定性。因此，简单的单目标优化或固定参数搜索难以稳定获得高质量解。

综上，本文所研究的问题并非显式混合整数规划模型，而是带有阈值覆盖判定和多类违约评价项的高维、非线性、非凸、非光滑动态连续优化问题。鉴于传统精确优化方法难以直接适用于该类问题，后续章节将设计基于启发式搜索的 CSA-L-SHADE 算法进行近似求解，以提高复杂动态 UAV 通信场景下的优化性能。

= 基于覆盖状态感知的 CSA-L-SHADE 路由优化算法

本章在模型基础上设计面向动态覆盖路由问题的 CSA-L-SHADE 优化算法。首先说明 L-SHADE 在本文问题中的编码、解码、评估和选择框架，并分析原始 L-SHADE 在覆盖不足、搜索阶段识别和参数调节方面的适配性挑战。随后，提出覆盖优先初始化机制和覆盖状态感知参数控制机制，使算法能够结合覆盖违约状态动态调整搜索行为。最后给出 CSA-L-SHADE 的完整流程与复杂度分析，为后续仿真实验提供算法基础。

== L-SHADE 求解框架

L-SHADE 是一种基于差分进化的自适应连续优化算法，其核心机制包括 current-to-pbest/1 变异、二项交叉、成功历史参数自适应、外部档案和线性种群规模缩减。第 2 章已对其基本原理进行了介绍，本节重点说明 L-SHADE 在本文异构 UAV 动态路由规划问题中的编码、评估与选择方式。

在本文问题中，一个个体表示完整任务周期内所有 UAV 的分段控制序列。对于 UAV $i$ 和控制段 $g$，其控制向量为

$
bold(u)_i(g)
=
[
  hat(v)_i(g),
  hat(theta)_i(g),
  P_i^"tx"(g)
]^top.
$

因此，候选解可表示为由所有 UAV、所有控制段控制量拼接而成的连续向量：

$
bold(x) in RR^D,
quad
D = 3 N G.
$

其中，$N$ 为 UAV 数量，$G$ 为控制段数量。该编码方式将 UAV 的轨迹控制与发射功率控制统一到连续优化空间中。

对于任意候选解 $bold(x)$，算法先将其解码为完整时域动作序列，并输入第 3 章建立的动态仿真模型。仿真结束后得到个体评价向量：

$
bold(C)(bold(x))
=
(
  V_"cov"^"norm",
  V_"con"^"norm",
  J_"perf",
  J_"total"
).
$

普通 L-SHADE 通常直接比较单一目标值。本文改用覆盖与回传能力优先的层级判优规则：先比较 $V_"cov"^"norm"$，再比较 $V_"con"^"norm"$，在二者相近时比较 $J_"perf"$ 和 $J_"total"$。该规则让搜索过程先压低覆盖违约和回传能力违约，再优化由吞吐、队列和能耗组成的综合性能。

在变异阶段，L-SHADE 采用 current-to-pbest/1 策略生成变异向量：

$
bold(v)_i
=
bold(x)_i
+
F_i (bold(x)_"pbest" - bold(x)_i)
+
F_i (bold(x)_(r_1) - bold(x)_(r_2)).
$

其中，$bold(x)_"pbest"$ 从当前种群前 $p$ 比例优秀个体中随机选取，$F_i$ 为缩放因子，$bold(x)_(r_2)$ 可来自当前种群或外部档案。随后，变异向量经二项交叉形成试验个体，并按第 3 章定义的速度、航向角和发射功率范围进行边界修复。

L-SHADE 通过成功历史记忆机制自适应采样 $F_i$ 和 $C R_i$，并通过线性种群规模缩减在搜索前期保持多样性、后期增强收敛能力。本文后续提出的 CSA 机制不替代这一成功历史自适应过程，而是在其采样结果基础上，根据种群覆盖状态对 $p$、$F$ 和 $C R$ 进行状态相关控制。由此，L-SHADE 构成 CSA-L-SHADE 的基础连续搜索框架。

==  L-SHADE 不足

原始 L-SHADE 具有较强的连续优化能力，但本文研究的异构 UAV 动态覆盖路由问题并不是一般黑箱连续优化问题。候选解由多架 UAV 在多个控制段内的速度、航向角和发射功率组成，目标值由 UAV 轨迹、地面覆盖、链路速率、队列演化和能量消耗共同决定。覆盖状态在这里尤其敏感：它既是综合目标函数中的惩罚项，也是后续数据到达、队列更新和 Sink 回传能力评价的基础。若算法不能在搜索过程中形成并维持覆盖结构，后续吞吐量、队列负载和能耗优化都会受到限制。

随机初始化是第一个问题。本文中一个个体对应 $D = 3 N G$ 维 UAV 分段控制向量，随机生成的速度、航向角和发射功率序列不包含任务节点空间分布信息，初始 UAV 轨迹可能偏离任务节点密集区域。当初始种群整体覆盖水平较低时，算法需要消耗较多函数评估次数修正轨迹方向，搜索前期覆盖违约也会偏高。这个问题本质上是搜索入口与有效覆盖区域之间存在结构性偏差。

差分变异也有类似问题。L-SHADE 的扰动本质上是通用向量扰动，搜索方向主要由种群中个体差分和 pbest 引导项决定。本文问题中，控制变量与性能指标之间存在明确的物理耦合关系：速度和航向角影响 UAV 位置，位置决定覆盖关系和链路距离，发射功率同时影响传输速率和通信能耗。原始差分扰动并不显式感知任务节点位置、覆盖半径和 Sink 回传方向，难以稳定产生符合覆盖路由结构的搜索行为。

覆盖判定还带有明显的阈值非光滑性。任务节点是否被覆盖由 UAV 与任务节点之间的距离是否小于覆盖半径决定，即

$
c_(i k)(t)
=
bb(I)(
  d_(i k)^"g"(t) <= R_i^"cov"
).
$

连续控制变量的微小变化可能导致覆盖状态跳变，也可能因未跨越覆盖边界而对覆盖指标没有影响。这种非光滑特征会削弱 L-SHADE 成功历史参数反馈的稳定性，使 $F$ 和 $C R$ 的历史经验难以准确反映覆盖结构变化。

参数控制同样不能忽略覆盖状态。本文问题中，搜索早期需要较强探索以构造覆盖结构；覆盖初步形成后，需要降低破坏性扰动以维持覆盖；覆盖稳定后，才适合继续优化吞吐量、队列负载和能耗。若覆盖发生退化，算法还需要重新加强覆盖恢复能力。原始 L-SHADE 主要依赖历史成功参数进行自适应，缺少对上述覆盖阶段的显式判断，容易在覆盖尚未稳定时过早转向性能优化，或在覆盖退化后缺少恢复机制。

基于上述分析，本文保留 L-SHADE 的连续搜索框架，但在两个位置加入问题结构信息：覆盖优先初始化机制用于改善初始种群的覆盖质量，覆盖状态感知参数控制机制用于根据种群覆盖状态动态调节 $p$、$F$ 和 $C R$。前者处理搜索入口问题，后者处理搜索过程中的覆盖状态适配问题。

== 覆盖优先初始化机制

为缓解随机初始化带来的低覆盖起点问题，本文在 CSA-L-SHADE 中引入覆盖优先初始化机制（Coverage-First Initialization, CFI）。该机制利用地面任务节点的空间分布构造部分覆盖导向初始个体，使初始种群中包含更接近覆盖可行区域的控制序列。CFI 只作用于种群初始化阶段，不改变 L-SHADE 后续的变异、交叉、选择、外部档案更新和成功历史记忆更新过程。

设地面任务节点集合为 $cal(K) = brace.l 1, 2, dots, K brace.r$，任务节点 $k$ 的位置为 $bold(q)_k$。对于每个 CFI 个体，先从任务节点中选取

$
N_c = min(N, K)
$

个覆盖目标点。为兼顾任务节点分布中心和空间分散性，本文采用“质心起点-最远点扩展”的目标点选择策略，先计算任务节点位置质心：

$
overline(bold(q))
=
1 / K
sum_(k in cal(K))
bold(q)_k.
$

选取距离质心最近的任务节点作为初始目标点：

$
k_1
=
arg min_(k in cal(K))
norm(bold(q)_k - overline(bold(q)))_2.
$

记当前已选目标集合为 $cal(C)$。在后续选择过程中，对于尚未被选中的任务节点，计算其到已选目标集合的最小距离，并选取该距离最大的节点作为新的覆盖目标：

$
k^*
=
arg max_(k in cal(K) without cal(C))
min_(m in cal(C))
norm(bold(q)_k - bold(q)_m)_2.
$

重复上述过程，直至满足

$
|cal(C)| = N_c.
$

这样得到的目标集合 $cal(C)$ 可在任务区域内形成相对分散的覆盖引导点。

在目标分配阶段，CFI 按 UAV 顺序进行贪心匹配。设 $cal(C)_i$ 表示分配 UAV $i$ 时尚未使用的目标集合。若 $cal(C)_i != emptyset$，则 UAV $i$ 被分配至距离其初始位置最近的未使用目标：

$
k(i)
=
arg min_(k in cal(C)_i)
norm(bold(p)_i(0) - bold(q)_k)_2.
$

若所有目标均已被分配，则允许目标复用，此时有

$
k(i)
=
arg min_(k in cal(C))
norm(bold(p)_i(0) - bold(q)_k)_2.
$

因此，当 $N > K$ 时，前 $K$ 架 UAV 可优先对应不同任务节点，剩余 UAV 则可复用已有覆盖目标。

为避免 CFI 个体在同一目标附近完全重合，本文在分配目标周围引入随机扰动。UAV $i$ 的扰动目标位置定义为

$
tilde(bold(q))_i
=
bold(q)_(k(i))
+
bold(xi)_i,
$

其中

$
bold(xi)_i
∼
cal(N)(
  bold(0),
  sigma_i^2 bold(I)_2
).
$

扰动尺度 $sigma_i$ 与 UAV 覆盖半径和任务节点空间分布有关。当任务节点数量为 1 时，取

$
sigma_i
=
0.15 R_i^"cov".
$

否则，取

$
sigma_i
=
min(
  max(
    0.05 R_i^"cov",
    0.08 norm(
      op("std")(
        brace.l bold(q)_k brace.r_(k in cal(K))
      )
    )_2
  ),
  0.25 R_i^"cov"
).
$

其中，$op("std")(brace.l bold(q)_k brace.r_(k in cal(K)))$ 表示地面任务节点坐标在二维方向上的标准差向量。

在获得扰动目标点后，CFI 为每架 UAV 构造分段控制序列。对于 UAV $i$ 和控制段 $g in cal(G)$，控制向量仍定义为

$
bold(u)_i(g)
=
[
  hat(v)_i(g),
  hat(theta)_i(g),
  P_i^"tx"(g)
]^top.
$

设控制段总数为 $G$，接近阶段的基准长度为

$
G_"tr"
=
ceil(0.25 G).
$

令 $overline(bold(p))_i(g) = [overline(x)_i(g), overline(y)_i(g)]^top$ 表示生成第 $g$ 个控制段时的 UAV 估计位置。若满足

$
g < G_"tr"
$

或

$
norm(overline(bold(p))_i(g) - tilde(bold(q))_i)_2
>
0.6 R_i^"cov",
$

则 UAV $i$ 在控制段 $g$ 采用接近模式。此时，期望航向角指向扰动目标：

$
hat(theta)_i(g)
=
op("atan2")(
  tilde(y)_i - overline(y)_i(g),
  tilde(x)_i - overline(x)_i(g)
).
$

速度和发射功率分别由比例系数生成：

$
hat(v)_i(g)
=
alpha_(v, i)^"tr"(g) v_i^"max",
quad
alpha_(v, i)^"tr"(g) ~ cal(U)(0.65, 0.90),
$

$
P_i^"tx"(g)
=
alpha_(p, i)^"tr"(g) P_i^"max",
quad
alpha_(p, i)^"tr"(g) ~ cal(U)(0.65, 0.90).
$

若上述条件不满足，则 UAV $i$ 在控制段 $g$ 采用保持模式。此时期望航向角在指向目标方向的基础上加入小幅角度扰动：

$
hat(theta)_i(g)
=
op("atan2")(
  tilde(y)_i - overline(y)_i(g),
  tilde(x)_i - overline(x)_i(g)
)
+
zeta_i(g),
$

其中

$
zeta_i(g) ~ cal(U)(-0.35, 0.35).
$

保持模式下的速度和发射功率为

$
hat(v)_i(g)
=
alpha_(v, i)^"h"(g) v_i^"max",
quad
alpha_(v, i)^"h"(g) ~ cal(U)(0.05, 0.20),
$

$
P_i^"tx"(g)
=
alpha_(p, i)^"h"(g) P_i^"max",
quad
alpha_(p, i)^"h"(g) ~ cal(U)(0.45, 0.70).
$

生成后的控制变量需满足第三章定义的边界条件：

$
0 <= hat(v)_i(g) <= v_i^"max",
quad
0 <= hat(theta)_i(g) < 2 pi,
quad
0 <= P_i^"tx"(g) <= P_i^"max".
$

在仿真评估阶段，实际执行速度和航向还会受到加速度、最大转角、最大角速度、最小转弯半径和安全距离修正机制的约束。

CFI 与随机初始化共同构成初始种群。设初始种群规模为 $N P_0$，覆盖优先初始化比例为 $rho_"CFI"$，则 CFI 个体数量和随机初始化个体数量分别为

$
N P_"CFI"
=
op("round")(
  rho_"CFI" N P_0
),
$

$
N P_"rand"
=
N P_0 - N P_"CFI".
$

本文实验中采用混合初始化设置：

$
N P_0 = 100,
quad
rho_"CFI" = 0.5.
$

在该设置下，初始种群中约一半个体由 CFI 生成，其余个体由随机初始化生成。初始化完成后，两类个体不再区别处理，均作为 L-SHADE 种群中的实数向量参与后续搜索。这样，初始种群在保持随机多样性的同时获得覆盖导向结构，为后续覆盖状态感知参数控制提供更稳定的搜索基础。

== 覆盖状态感知参数控制机制

覆盖优先初始化改善了初始种群的覆盖质量，但在后续差分进化过程中，种群仍可能出现覆盖退化或过早转向性能优化。为此，本文在 CFI-L-SHADE 的基础上引入覆盖状态感知参数控制机制（Coverage-State-Aware Parameter Control, CSA）。该机制根据种群覆盖状态动态约束 $p$、$F$ 和 $"CR"$，使算法在覆盖构造、覆盖稳定、性能精修和覆盖恢复阶段采用不同搜索尺度。

=== 覆盖状态指标构造

设第 $ell$ 代种群为

$
cal(P)^(ell)
=
brace.l
  bold(x)_1^(ell),
  bold(x)_2^(ell),
  dots,
  bold(x)_(N P_ell)^(ell)
brace.r,
$

其中 $N P_ell$ 为第 $ell$ 代种群规模。每个个体经完整动态仿真后得到评价向量

$
bold(C)(bold(x)_i^(ell))
=
(
  V_"cov"^"norm",
  V_"con"^"norm",
  J_"perf",
  J_"total"
).
$

本文按字典序对 $bold(C)(bold(x)_i^(ell))$ 进行升序排序，即先比较覆盖违约，再比较连通性违约，随后比较通信性能项和综合目标值。设排序后的种群为

$
op("rank")(
  cal(P)^(ell)
).
$

取前 $rho_e$ 比例个体构成精英集合：

$
N_e^(ell)
=
ceil(rho_e N P_ell),
quad
rho_e = 0.20.
$

$
cal(E)^(ell)
=
brace.l
  bold(x) in op("rank")(cal(P)^(ell))
  mid
  op("rank")(bold(x)) <= N_e^(ell)
brace.r.
$

基于精英集合，定义精英覆盖违约均值

$
g_ell
=
1 / |cal(E)^(ell)|
sum_(bold(x) in cal(E)^(ell))
V_"cov"^"norm"(bold(x)).
$

设 coverage-safe 阈值为

$
tau_"safe" = 0.10.
$

第 $ell$ 代种群中的 coverage-safe 比例定义为

$
r_ell
=
1 / (N P_ell)
sum_(i = 1)^(N P_ell)
bb(I)(
  V_"cov"^"norm"(bold(x)_i^(ell))
  <=
  tau_"safe"
).
$

设状态判断窗口长度为

$
L_s = 5,
$

定义精英覆盖违约变化量为

$
Delta g_ell
=
g_(ell - L_s) - g_ell.
$

CSA-L-SHADE 采用三类覆盖状态统计量

$
(
  g_ell,
  r_ell,
  Delta g_ell
)
$

刻画当前种群覆盖水平、coverage-safe 个体扩散程度及近期覆盖变化趋势。

=== 覆盖状态机

定义覆盖状态空间为

$
cal(S)
=
brace.l
  S_1, S_2, S_3, S_4
brace.r,
$

其中 $S_1$、$S_2$、$S_3$、$S_4$ 分别表示覆盖构造、覆盖稳定、性能精修和覆盖恢复状态，如表 4-1 所示。

#three-line-table(
  columns: (auto, auto, 1fr, 1fr),
  table.header([状态], [名称], [状态含义], [搜索目标]),
  [$S_1$], [Coverage Construction], [覆盖尚未建立], [快速形成覆盖结构],
  [$S_2$], [Coverage Stabilization], [覆盖初步形成但尚不稳定], [稳定并扩散覆盖结构],
  [$S_3$], [Performance Refinement], [覆盖已相对稳定], [优化吞吐、队列和能耗],
  [$S_4$], [Coverage Recovery], [覆盖发生退化], [恢复覆盖结构],
)

状态转移由 $g_ell$、$r_ell$、$Delta g_ell$ 及稳定计数器 $c_"stab"$ 共同决定。本文采用如下阈值：

$
tau_H = 0.15,
quad
tau_L = 0.10,
$

$
r_L = 0.20,
quad
r_H = 0.50,
$

$
Delta_"stable" = 0.002,
quad
H_"req" = 3,
$

$
tau_"recover" = 0.11,
quad
r_"recover" = 0.40.
$

稳定条件定义为

$
cal(A)_ell
=
[g_ell <= tau_L]
and
[r_ell >= r_H]
and
[Delta g_ell <= Delta_"stable"].
$

稳定计数器按如下规则更新：若 $cal(A)_ell$ 成立，则 $c_"stab" <- c_"stab" + 1$；否则 $c_"stab" <- 0$。

覆盖状态转移函数定义为

$
S_(ell + 1)
=
cal(F)(
  S_ell,
  g_ell,
  r_ell,
  Delta g_ell,
  c_"stab"
).
$

具体转移规则如下：

#three-line-table(
  columns: (auto, 1fr),
  table.header([转移结果], [触发条件]),
  [$S_(ell + 1) = S_2$], [$S_ell = S_1$, $g_ell <= tau_H$，且 $r_ell >= r_L$],
  [$S_(ell + 1) = S_3$], [$S_ell = S_2$，且 $c_"stab" >= H_"req"$],
  [$S_(ell + 1) = S_4$], [$S_ell = S_3$，且 $g_ell > tau_"recover"$ 或 $r_ell < r_"recover"$],
  [$S_(ell + 1) = S_2$], [$S_ell = S_4$，$g_ell <= tau_H$，且 $r_ell >= r_L$],
  [$S_(ell + 1) = S_1$], [$S_ell = S_4$，且 $g_ell > tau_H$ 或 $r_ell < r_L$],
  [$S_(ell + 1) = S_ell$], [其他情况],
)

其中，$S_4$ 仅在性能精修阶段发生覆盖退化时触发；若恢复后达到基本覆盖条件，则返回 $S_2$，否则回退至 $S_1$。

=== 状态驱动的 p/F/CR 控制

CSA-L-SHADE 保留 L-SHADE 的成功历史记忆机制。对于个体 $bold(x)_i^(ell)$，缩放因子和交叉概率先由历史记忆采样得到：

$
F_i
∼
op("Cauchy")(
  M_F[r],
  0.1
),
$

$
"CR"_i
∼
cal(N)(
  M_"CR"[r],
  0.1
),
$

其中 $r$ 为随机选取的历史记忆索引。随后，根据当前覆盖状态 $S_ell$ 对参数进行状态相关裁剪：

$
F_i
<-
op("clip")(
  F_i,
  F_"min"(S_ell),
  F_"max"(S_ell)
).
$

$
"CR"_i
<-
op("clip")(
  "CR"_i,
  "CR"_"min"(S_ell),
  "CR"_"max"(S_ell)
).
$

同时，pbest 选择比例由当前状态确定：

$
p_ell
=
p(S_ell).
$

状态驱动参数设置如表 4-2 所示。

#three-line-table(
  columns: (1fr, auto, auto, auto, 1fr),
  table.header([覆盖状态], [$p_ell$], [$F$ 范围], [$"CR"$ 范围], [参数控制意图]),
  [$S_1$ Coverage Construction], [0.08], [$[0.50, 0.80]$], [$[0.15, 0.40]$], [加强覆盖构造],
  [$S_2$ Coverage Stabilization], [0.10], [$[0.35, 0.60]$], [$[0.10, 0.30]$], [稳定覆盖结构],
  [$S_3$ Performance Refinement], [0.15], [$[0.20, 0.50]$], [$[0.10, 0.35]$], [精修通信性能],
  [$S_4$ Coverage Recovery], [0.08], [$[0.35, 0.60]$], [$[0.10, 0.25]$], [恢复覆盖结构],
)

CSA 机制并不替代 L-SHADE 的成功历史自适应，而是在其采样结果外施加覆盖状态约束。$p_ell$ 控制 pbest 候选范围，$F_i$ 控制差分变异步长，$"CR"_i$ 控制交叉强度。覆盖构造和覆盖恢复状态采用较小 $p_ell$，以强化高覆盖个体的引导；覆盖稳定和性能精修状态逐步降低搜索扰动，使算法在保持覆盖结构的基础上优化吞吐量、队列负载和能耗。

覆盖状态感知参数控制机制将 $V_"cov"^"norm"$ 的种群统计量引入 L-SHADE 参数控制过程。该机制不改变第 3 章定义的目标函数，也不引入新的覆盖硬约束，而是在搜索过程中动态调整 $p$、$F$ 和 $"CR"$，使算法能区分覆盖构造、覆盖稳定、性能精修和覆盖恢复阶段。
== CSA-L-SHADE 算法流程

本文构建的 CSA-L-SHADE 算法用于求解异构 UAV 集群通信网络动态路由规划问题。算法以 L-SHADE 为基础框架，以 UAV 分段控制序列作为个体编码，通过完整动态仿真获得个体评价向量，并按覆盖优先、连通次优先、性能再优化的层级判优规则更新种群。流程上，算法先利用 CFI 生成覆盖导向初始个体，再根据种群覆盖状态动态调整 $p$、$F$ 和 $"CR"$，随后执行 L-SHADE 主循环中的变异、交叉、选择、档案更新、成功历史记忆更新和线性种群缩减。

CSA-L-SHADE 的完整流程如算法 4-1 所示。

#let AlgLine(block) = (block,)

#algorithm(
  title: [CSA-L-SHADE 算法流程],
  {
    AlgLine[输入：$op("MaxNFE")$, $N P_0$, $N P_"min"$, $rho_"CFI"$, $H$]
    AlgLine[输出：最优控制序列 $bold(x)^*$ 及其评价指标]

    Assign[$op("NFE")$][$0$]
    Assign[$ell$][$0$]
    Assign[$cal(A)$][$emptyset$]

    AlgLine[初始化 $M_F$、$M_"CR"$，设置 $S_0 = S_1$，$c_"stab" = 0$]
    AlgLine[基于 CFI 与随机初始化生成初始种群 $cal(P)^(0)$]
    AlgLine[评估 $cal(P)^(0)$，并确定初始最优个体 $bold(x)^*$]

    While(
      [$op("NFE") < op("MaxNFE")$],
      {
        AlgLine[根据线性缩减规则更新 $N P_ell$]
        AlgLine[按层级判优排序并截断种群]
        AlgLine[计算 $g_ell$、$r_ell$、$Delta g_ell$，并更新状态 $S_ell$]

        Assign[$i$][$1$]
        While(
          [$i <= N P_ell$],
          {
            AlgLine[从 $M_F$、$M_"CR"$ 采样 $F_i$、$"CR"_i$]
            AlgLine[根据 $S_ell$ 裁剪 $F_i$、$"CR"_i$，并确定 $p_ell$]
            AlgLine[生成试验个体 $bold(y)_i$]
            AlgLine[修复边界并评估 $bold(y)_i$]

            IfElseChain(
              [$bold(y)_i$ 优于 $bold(x)_i^(ell)$],
              {
                Assign[$bold(x)_i^(ell + 1)$][$bold(y)_i$]
                AlgLine[将被替换个体加入外部档案 $cal(A)$]
                AlgLine[记录成功参数 $F_i$、$"CR"_i$]
              },
              {
                Assign[$bold(x)_i^(ell + 1)$][$bold(x)_i^(ell)$]
              },
            )

            AlgLine[更新全局最优个体 $bold(x)^*$]
            Assign[$i$][$i + 1$]
          },
        )

        AlgLine[更新 $M_F$、$M_"CR"$ 并调整外部档案规模]
        Assign[$ell$][$ell + 1$]
      },
    )

    Return[$bold(x)^*$]
  },
) <alg:csa-lshade>

上述流程中，CFI 只作用于初始种群构造阶段，CSA 机制只作用于参数控制阶段，L-SHADE 主循环仍负责连续控制空间中的差分变异、交叉、选择和历史记忆更新。CSA-L-SHADE 没有改变基础 L-SHADE 的主体演化结构，而是在初始化入口和参数控制层引入覆盖状态信息，使搜索过程能在覆盖构造、覆盖稳定、性能精修和覆盖恢复之间切换。
== 算法复杂度分析

CSA-L-SHADE 的计算复杂度主要由决策空间维度、个体动态仿真评估和附加算子开销构成。其中，完整任务周期仿真是算法的主要计算瓶颈。

*1. 决策空间维度。*

CSA-L-SHADE 的个体为 UAV 分段控制序列。设 UAV 数量为 $N$，控制段数量为

$
G = ceil(T / L_c),
$

每架 UAV 在每个控制段内包含期望速度、期望航向角和发射功率 3 个变量，单个候选解维度为

$
D = 3 N G.
$

由此可知，算法需要在随 $N$ 和 $G$ 线性增长的高维连续控制空间中搜索。

*2. 个体评估复杂度。*

每个候选解均需展开为完整时域动作序列，并在仿真环境中执行 $T$ 个时隙。单个时隙内，UAV-UAV 通信速率计算与安全距离检查主要涉及 $N^2$ 级计算，UAV-地面任务节点覆盖判定与数据到达计算主要涉及 $N K$ 级计算。单次个体评估的主复杂度为

$
O(T (N^2 + N K)).
$

若最大函数评价次数为 $op("MaxNFE")$，则由动态仿真评估产生的主导复杂度为

$
O(op("MaxNFE") dot T (N^2 + N K)).
$

*3. 附加算子开销。*

除动态仿真评估外，算法还包含种群排序、pbest 选择、变异交叉、边界修复、外部档案维护、成功历史记忆更新和线性种群缩减等操作。设第 $ell$ 代种群规模为 $N P_ell$，这些操作主要与 $N P_ell$ 和个体维度 $D$ 有关，通常低于完整时域仿真评估的开销。

CFI 机制只在初始化阶段执行一次，其开销来自覆盖目标选择、UAV-目标匹配和覆盖导向控制序列生成。CSA 机制在每代执行覆盖状态统计、有限状态机转移判断以及$F$/$ "CR"$ 参数裁剪，其中精英覆盖均值、coverage-safe 比例和状态转移判断均属于轻量级种群统计操作，不引入额外的时域仿真过程。

CSA-L-SHADE 的总体计算成本仍由候选解的完整动态仿真评估主导。CFI 和 CSA 机制只带来一次性初始化开销或低阶种群级统计开销，不改变算法的渐进主复杂度阶。因此，CSA-L-SHADE 与基础 L-SHADE 在主阶上保持一致：

$
O(op("MaxNFE") dot T (N^2 + N K)).
$

该复杂度结果说明，覆盖状态感知机制在总体计算复杂度基本不变的条件下，引入了面向动态覆盖路由问题的结构化搜索引导。
= 仿真实验与结果分析

本章通过仿真实验验证 CSA-L-SHADE 在异构无人机集群动态路由规划问题中的有效性。实验在统一固定环境下开展，对 L-SHADE、CFI-L-SHADE 和 CSA-L-SHADE 进行多次独立运行比较，并从综合目标、覆盖性能、覆盖违约、连通违约、吞吐量、队列负载、能耗以及收敛过程等方面分析不同算法的表现。通过这些结果，本章评估所提覆盖状态感知机制对路由优化质量和搜索稳定性的影响。

== 实验设置

为评估 CSA-L-SHADE 算法在异构无人机集群动态路由规划问题中的表现，本文在统一仿真平台下开展对比实验。所有实验均基于第 3 章建立的无人机运动、通信、覆盖、队列与能量模型实现，并采用固定环境设置，以保证不同算法之间的比较条件一致。

实验采用固定环境模式，即所有算法共享相同的任务节点分布、无人机初始位置及异构参数配置。实验环境随机种子设为 42，每种算法独立运行 5 次，最大函数评估次数设置为 30000。

实验场景参数如表 5-1 所示。

#three-line-table(
  columns: (1fr, auto),
  table.header([参数], [数值]),
  [UAV 数量 $N$], [8],
  [任务节点数量 $K$], [20],
  [仿真时长 $T$], [200],
  [控制段长度 $L$], [10],
  [控制段数 $S$], [20],
  [时隙长度 $Delta t$], [1 s],
  [UAV 飞行高度 $H$], [100 m],
)

为体现无人机异构性，实验中各 UAV 的覆盖半径、最大速度、带宽、最大发射功率、队列容量及初始能量均采用随机异构配置，其参数范围如表 5-2 所示。

#three-line-table(
  columns: (1fr, auto),
  table.header([参数], [取值范围]),
  [最大速度 $V_i^"max"$], [[10, 25] m/s],
  [覆盖半径 $R_i^c$], [[150, 300] m],
  [带宽 $B_i$], [[1e6, 5e6] Hz],
  [最大发射功率 $P_i^"max"$], [[1, 5] W],
  [队列容量 $Q_i^"max"$], [[5e6, 1e7] bit],
  [初始能量 $E_i^"max"$], [[2e5, 3e5] J],
)

其余通信模型参数、动力学约束参数以及 CSA-L-SHADE 状态控制参数见附录 B。
== 对比算法与评价指标

实验围绕 L-SHADE 系列算法展开对比。前期研究中，笔者曾对 GA、PSO、DE 等常见启发式算法做过初步比较，用于判断不同群智能算法在无人机动态路由规划问题中的适用性。综合收敛稳定性与优化效果后，本文选取 L-SHADE 作为后续改进的基础框架。本章正式实验比较 L-SHADE、CFI-L-SHADE 和 CSA-L-SHADE 三种算法。三种算法采用统一的差分进化框架与基础参数配置，其初始种群规模为100，最小种群规模为20，历史记忆长度为10，最大函数评估次数为30000。

实验结果采用固定环境下 5 次独立运行的统计结果，并以均值和标准差形式展示。评价指标沿用第 3 章定义的综合性能指标。主结果关注三种算法在 $J_"total"$、coverage ratio、$V_"cov"^"norm"$ 和 $V_"con"^"norm"$ 上的差异；辅助分析结合 $R_"norm"$、$Q_"norm"$ 和 $E_"norm"$，解释不同算法在吞吐、队列和能耗方面的变化。

本文不单独进行显著性检验，而是结合均值、标准差和收敛过程分析算法结果。
== 实验结果与分析

本节基于固定环境下 5 次独立运行结果，对 L-SHADE、CFI-L-SHADE 和 CSA-L-SHADE 三种算法进行对比分析。实验考察综合目标值、覆盖性能、连通违约、吞吐量、队列负载和能耗等指标，并结合收敛曲线与结果分布分析不同算法的优化特征。

=== 综合指标与覆盖性能对比

表 5-5 给出了三种算法在固定环境下的主评价指标结果。

#three-line-table(
  columns: (auto, auto, auto, auto, auto),
  table.header([Algorithm], [$J_"total"$], [coverage ratio], [$V_"cov"^"norm"$], [$V_"con"^"norm"$]),
  [L-SHADE], [$-0.016413 ± 0.017189$], [$0.827400 ± 0.015883$], [$0.172600 ± 0.015883$], [$0.000000 ± 0.000000$],
  [CFI-L-SHADE], [$-0.092238 ± 0.019092$], [$0.859600 ± 0.013599$], [$0.150490 ± 0.011271$], [$0.000000 ± 0.000000$],
  [CSA-L-SHADE], [$-0.112365 ± 0.062400$], [$0.894350 ± 0.025073$], [$0.107630 ± 0.021777$], [$0.000000 ± 0.000000$],
)

从综合目标值看，三种算法呈递进关系。L-SHADE 的平均 $J_"total"$ 为 $-0.016413$，CFI-L-SHADE 降低至 $-0.092238$，CSA-L-SHADE 降低至 $-0.112365$。相较 L-SHADE，CFI-L-SHADE 的综合目标值绝对下降 $0.075825$，CSA-L-SHADE 绝对下降 $0.095952$；相较 CFI-L-SHADE，CSA-L-SHADE 仍下降 $0.020127$。不过，$J_"total"$ 是加权综合指标，且 L-SHADE 基线值接近 0，相对百分比容易被放大。这里更适合结合绝对下降幅度和分项指标解释结果。

覆盖指标给出了更具体的解释。L-SHADE 的平均 coverage ratio 为 $0.827400$，CFI-L-SHADE 提升至 $0.859600$，CSA-L-SHADE 提升至 $0.894350$。相较 L-SHADE，CFI-L-SHADE 覆盖率提高约 3.89%，CSA-L-SHADE 提高约 8.09%；相较 CFI-L-SHADE，CSA-L-SHADE 仍提高约 4.04%。与之对应，CSA-L-SHADE 的 $V_"cov"^"norm"$ 相较 L-SHADE 降低约 37.64%，相较 CFI-L-SHADE 降低约 28.48%。因此，CSA-L-SHADE 的优势主要来自覆盖不足程度下降，而不是单纯由目标函数权重造成的数值差异。

三种算法的 $V_"con"^"norm"$ 均为 0，说明在当前固定环境和参数设置下，三种算法最终解均满足基于 Sink 数据泄放能力的功能性回传要求。也就是说，本组实验的主要差异不在功能性连通违约，而在覆盖能力、吞吐表现、队列负载和能耗水平上。

=== 通信性能与资源消耗分析

为分析综合目标值改善的来源，表 5-6 给出了三种算法在吞吐量、队列负载和能耗方面的结果。

#three-line-table(
  columns: (auto, auto, auto, auto),
  table.header([Algorithm], [$R_"norm"$], [$Q_"norm"$], [$E_"norm"$]),
  [L-SHADE], [$0.282580 ± 0.024343$], [$0.353330 ± 0.037843$], [$0.000416 ± 0.000011$],
  [CFI-L-SHADE], [$0.436780 ± 0.057542$], [$0.291825 ± 0.019460$], [$0.000407 ± 0.000015$],
  [CSA-L-SHADE], [$0.464139 ± 0.141157$], [$0.283919 ± 0.027831$], [$0.000391 ± 0.000010$],
)

从吞吐量看，CSA-L-SHADE 的 $R_"norm"$ 最高，达到 $0.464139$，相比 L-SHADE 提高约 64.25%，相比 CFI-L-SHADE 提高约 6.26%。覆盖性能改善没有以牺牲 Sink 汇聚能力为代价；相反，更合理的 UAV 空间分布和发射功率组合提高了 UAV-Sink 链路的整体可达传输能力。

从队列负载看，CSA-L-SHADE 的 $Q_"norm"$ 最低，为 $0.283919$，相比 L-SHADE 降低约 19.64%，相比 CFI-L-SHADE 降低约 2.71%。这表明 CSA-L-SHADE 在提升覆盖率的同时，并未造成更严重的数据积压。覆盖状态感知机制并不只追求覆盖率，而是在覆盖相对稳定后继续优化吞吐量和队列泄放能力，使覆盖服务与数据回传之间保持平衡。

从能耗看，三种算法的 $E_"norm"$ 均较小，差异不如覆盖和吞吐指标明显，但 CSA-L-SHADE 仍取得最低能耗水平。相比 L-SHADE，CSA-L-SHADE 的归一化能耗降低约 6.01%；相比 CFI-L-SHADE，降低约 3.93%。这一结果说明，CSA-L-SHADE 在改善覆盖、吞吐和队列指标时，没有引入额外能耗负担。

CSA-L-SHADE 的优势不是由单一指标决定的，而来自覆盖率提升、覆盖违约降低、吞吐量增加、队列负载下降和能耗轻微降低的共同作用。其中，覆盖相关指标改善最明显，与本文围绕覆盖状态进行结构化改进的设计目标一致。

=== 收敛过程与结果分布分析

图 5-1 至图 5-3 展示了三种算法在最终 $J_"total"$、coverage ratio 和 $V_"cov"^"norm"$ 上的分布情况。L-SHADE 的最终目标值较高、覆盖率较低、覆盖违约较大；CFI-L-SHADE 在三项指标上均优于 L-SHADE；CSA-L-SHADE 取得最低的平均 $J_"total"$、最高的 coverage ratio 和最低的 $V_"cov"^"norm"$。该分布结果与表 5-7 一致，说明这次改进不是个别运行中的偶然结果。

#capfig(
  image("figures/image5-1.png", width: 80%),
  caption: [三种算法最终综合目标值分布],
  label: <fig:final-j-total>,
)

#capfig(
  image("figures/image5-2.png", width: 80%),
  caption: [三种算法最终覆盖率分布],
  label: <fig:final-coverage-ratio>,
)

#capfig(
  image("figures/image5-3.png", width: 80%),
  caption: [三种算法最终覆盖违约分布],
  label: <fig:final-coverage-violation>,
)


图 5-4 给出了 best $J_"total"$-NFE 收敛曲线。L-SHADE 在搜索早期下降后较快进入平台期，随机初始化和通用差分扰动难以持续改善覆盖路由结构。CFI-L-SHADE 在搜索初期即取得更低目标值，说明覆盖优先初始化改善了初始种群质量，使算法能更早围绕较好的覆盖结构展开搜索。CSA-L-SHADE 在前中期不一定始终优于 CFI-L-SHADE，但在搜索后期继续下降，并最终达到最低目标值。这一现象与覆盖状态感知参数控制的设计目标一致：前期不强行追求单调领先，后期更重视覆盖保持后的综合优化。

#capfig(
  image("figures/image5-4.png", width: 80%),
  caption: [三种算法 best $J_"total"$-NFE 收敛曲线],
  label: <fig:best-j-total-nfe>,
)

图 5-5 展示了最终 $J_"total"$ 与 coverage ratio 之间的关系。L-SHADE 样本主要分布在较低覆盖率和较高目标值区域，CFI-L-SHADE 整体向更高覆盖率和更低目标值方向移动，CSA-L-SHADE 则集中在高覆盖、低目标值区域。在本文动态路由规划模型中，覆盖状态既是目标函数中的惩罚项，也是数据到达、队列演化和通信性能优化的基础条件。较好的覆盖结构能为后续 Sink 汇聚、队列泄放和能耗控制提供更有利的系统状态，这也是本文围绕覆盖状态设计搜索控制机制的原因。

#capfig(
  image("figures/image5-5.png", width: 80%),
  caption: [最终综合目标值与覆盖率关系],
  label: <fig:j-total-coverage-ratio>,
)

从实验结果看，CFI-L-SHADE 主要缓解了 L-SHADE 的低覆盖冷启动问题；CSA-L-SHADE 的收益则更多体现在覆盖保持和后期综合优化上。三种算法之间的递进关系，支持本文“覆盖优先初始化 + 覆盖状态感知参数控制”的设计思路。

= 总结与展望

== 主要研究成果与创新点

本文工作主要集中在以下几个方面。

模型方面，本文建立面向异构 UAV 集群的动态覆盖路由规划模型。不同于仅考虑静态覆盖或拓扑连通的模型，本文将 UAV 运动控制、地面任务节点覆盖、链路传输速率、缓存队列演化和能量消耗纳入统一框架，用于描述“轨迹-覆盖-队列-回传-能耗”之间的动态耦合关系。同时，本文采用功能性回传能力表征系统面向 Sink 的数据泄放能力，避免仅依赖静态图论连通性评价网络性能，使模型更符合动态应急通信场景下的数据传输需求。

在算法入口上，本文引入覆盖优先初始化机制。原始 L-SHADE 随机初始化缺少任务节点空间信息，搜索早期容易出现低覆盖轨迹；覆盖导向初始化方法则根据地面任务节点分布生成一部分初始个体。该机制通过目标点选择、UAV-目标匹配和“接近-保持”式控制序列生成，使初始种群中包含更接近覆盖可行区域的个体。实验结果显示，该机制提高了初始和最终覆盖质量，为后续差分进化搜索提供了更合理的搜索入口。

在参数控制上，本文提出覆盖状态感知 CSA-L-SHADE 算法。原始 L-SHADE 参数自适应主要依赖历史成功经验，缺少对 UAV 覆盖状态的显式感知。本文构造覆盖状态指标和有限状态机，将搜索过程划分为覆盖构造、覆盖稳定、性能精修和覆盖恢复四类状态，并根据不同状态动态约束 $p$、$F$ 和 $"CR"$。这样，L-SHADE 可根据种群覆盖状态调整搜索尺度和搜索方向，在保持覆盖结构的同时优化吞吐量、队列负载和能耗水平。

== 不足与展望

当前研究仍有不足，后续工作可以从模型真实性、路由粒度和参数自适应三个方向继续推进。

通信信道模型仍较为简化。本文采用基于二维距离平方衰减的简化信道模型，未显式考虑三维距离、高度变化、复杂地形遮挡、LoS/NLoS 概率切换、多径衰落和同频干扰等因素。后续研究可引入更真实的空地信道模型和干扰模型，使通信速率计算更加贴近复杂应急场景。

路由表征仍属于规划层面的功能性回传建模。本文通过 UAV-UAV 链路速率、UAV-Sink 汇聚速率和队列泄放能力刻画动态回传能力，但没有引入显式下一跳选择、链路调度或数据包级路由变量。后续可结合图路由或流量分配模型，将 UAV 轨迹控制与显式路由决策联合优化。

实验场景仍以固定环境验证为主。固定环境有助于保证算法公平比较，但实际应急通信场景中，任务节点分布、UAV 初始位置、数据产生强度和通信环境可能具有更强随机性。后续应在多随机环境、多任务规模和不同参数设置下验证 CSA-L-SHADE 的稳定性和泛化能力。

另外，CSA-L-SHADE 的状态控制参数仍依赖人工设定。本文根据覆盖状态设计了参数状态约束范围，但不同场景下合适的参数可能不同。后续可研究自适应阈值调整、强化学习辅助参数控制或多状态记忆机制，使算法根据环境规模和搜索过程自动调整状态判定条件与参数范围。

本文提出的 CSA-L-SHADE 算法在当前仿真设置下改善了异构 UAV 集群动态路由规划中的覆盖保持能力和综合优化性能。更复杂的通信环境、显式路由机制以及自适应参数控制，仍是后续需要继续验证的方向。

